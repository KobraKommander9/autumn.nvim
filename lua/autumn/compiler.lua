local M = {}

local Files = require("autumn.files")
local fmt = string.format

local base_colors = {
	"white",
	"black",
	"gray",

	"primary",
	"secondary",

	"red",
	"green",
	"yellow",
	"blue",
	"magenta",
	"cyan",
	"pink",

	"bg0",
	"bg1",
	"bg2",
	"bg3",
	"bg4",

	"fg0",
	"fg1",
	"fg2",
	"fg3",

	"comment",
}

local spec_groups = {
	"syntax",
	"diag",
	"diag_bg",
	"diff",
	"git",
}

function M.insert(tbl, ...)
	for _, rhs in ipairs({ ... }) do
		for _, v in ipairs(rhs) do
			table.insert(tbl, v)
		end
	end
end

function M.deep_extend(...)
	local lhs = {}

	for _, rhs in ipairs({ ... }) do
		for k, v in pairs(rhs) do
			if type(lhs[k]) == "table" and type(v) == "table" then
				lhs[k] = M.deep_extend(lhs[k], v)
			else
				lhs[k] = v
			end
		end
	end

	return lhs
end

function M.load_spec()
	local p = require("autumn.palette")
	local spec = p.generate_spec(p.palette)
	spec.palette = p.palette
	return spec
end

function M.load_groups(spec)
	local Config = require("autumn.config")
	local cfg_opts = Config.options

	local autumn = require("autumn.group.autumn").get(spec, cfg_opts)
	local editor = require("autumn.group.editor").get(spec, cfg_opts)
	local syntax = {}

	local result = M.deep_extend(autumn, editor, syntax)

	local module_names = Config.module_names
	for _, name in ipairs(module_names) do
		local kind = type(cfg_opts.modules[name])
		local opts = kind == "boolean" and { enable = cfg_opts.modules[name] }
			or kind == "table" and cfg_opts.modules[name]
			or {}

		opts.enable = opts.enable == nil and cfg_opts.module_default or opts.enable

		if opts.enable then
			result = M.deep_extend(result, require("autumn.group.modules." .. name).get(spec, cfg_opts, opts))
		end
	end

	return result
end

local function parse_style(style)
	if not style or style == "NONE" then
		return {}
	end

	local result = {}
	for token in string.gmatch(style, "([^,]+)") do
		result[token] = true
	end

	return result
end

local function inspect(tbl, color_names)
	color_names = color_names or {}
	local list = {}

	for k, v in pairs(tbl) do
		if type(v) == "string" and color_names[v] then
			table.insert(list, fmt("%s = %s", k, color_names[v]))
		else
			local q = type(v) == "string" and '"' or ""
			table.insert(list, fmt("%s = %s%s%s", k, q, v, q))
		end
	end

	table.sort(list)
	return fmt([[{ %s }]], table.concat(list, ", "))
end

local function should_link(link)
	return link and link ~= ""
end

local function get_lush_group(group)
	return group:sub(1, 1) == "@" and fmt([[sym("%s")]], group) or group
end

function M.compile(opts)
	opts = opts or {}

	local config = require("autumn.config")
	local write_lush = config.options.lush.enabled == true

	local spec = M.load_spec()
	local groups = M.load_groups(spec)

	local lines = {
		[[
return string.dump(function()
  local h = vim.api.nvim_set_hl
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  vim.cmd("syntax reset")

  vim.o.termguicolors = true
  vim.g.colors_name = "autumn"
  vim.o.background = "dark"
]],
	}

	local lush_lines = {
		[[
local lush = require("lush")
local hsl = lush.hsl

---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)]],
	}

	if config.options.terminal_colors then
		local terminal = require("autumn.group.terminal").get(spec)
		for k, v in pairs(terminal) do
			table.insert(lines, fmt([[  vim.g.%s = "%s"]], k, v))
			table.insert(lush_lines, fmt([[  -- vim.g.%s = "%s"]], k, v))
		end
	end

	local color_names = {}

	local function insert_color(name, color)
		local n = "palette." .. name

		if type(color) == "string" then
			table.insert(lush_lines, fmt([[    %s = hsl("%s"),]], name, color))
		else
			table.insert(lush_lines, fmt([[    %s = hsl("%s"),]], name, color.base.hex))
			table.insert(lush_lines, fmt([[    %s_bright = hsl("%s"),]], name, color.bright.hex))
			table.insert(lush_lines, fmt([[    %s_dim = hsl("%s"),]], name, color.dim.hex))

			color_names[color.base.hex] = n
			color_names[color.bright.hex] = n .. "_bright"
			color_names[color.dim.hex] = n .. "_dim"
		end
	end

	local function make_group(name, group, fn)
		table.insert(lush_lines, fmt([[  local %s = {]], name))

		local grouped_lines = {}
		for key, value in pairs(group) do
			if fn == true or fn(key) then
				table.insert(grouped_lines, fmt([[    %s = hsl("%s"),]], key, value))
				color_names[value] = name .. "." .. key
			end
		end

		table.sort(grouped_lines)
		M.insert(lush_lines, grouped_lines)
		table.insert(lush_lines, [[  }]])
	end

	table.insert(lush_lines, [[  local palette = {]])
	for _, name in ipairs(base_colors) do
		local color = spec.palette[name]
		insert_color(name, color)
	end
	table.insert(lush_lines, [[  }]])

	make_group("editor", spec, function(key)
		if vim.tbl_contains(spec_groups, key) then
			return false
		elseif key == "palette" then
			return false
		end
		return true
	end)

	for _, name in ipairs(spec_groups) do
		make_group(name, spec[name], true)
	end

	table.insert(
		lush_lines,
		[[

  local sym = injected_functions.sym
  return{]]
	)

	local primary_lines = {}
	local dependent_lines = {}

	local linked_groups = {}
	local linked_lines = {}

	for group, attrs in pairs(groups) do
		local lush_group = get_lush_group(group)

		if should_link(attrs.link) then
			table.insert(lines, fmt([[  h(0, "%s", { link = "%s" })]], group, attrs.link))

			local lush_link = get_lush_group(attrs.link)
			local lush_line = fmt([[    %s({ %s }), -- %s { }]], lush_group, lush_link, lush_group)

			if not linked_groups[lush_link] then
				linked_lines[lush_link] = linked_lines[lush_link] or {}
				table.insert(linked_lines[lush_link], lush_line)
			else
				table.insert(dependent_lines, lush_line)
			end
		else
			local op = parse_style(attrs.style)
			op.bg = attrs.bg
			op.fg = attrs.fg
			op.sp = attrs.sp
			table.insert(lines, fmt([[  h(0, "%s", %s)]], group, inspect(op)))
			table.insert(
				primary_lines,
				fmt([[    %s(%s), -- %s { }]], lush_group, inspect(op, color_names), lush_group)
			)

			table.insert(linked_groups, lush_group)
			if linked_lines[lush_group] then
				for _, line in ipairs(linked_lines[lush_group]) do
					table.insert(dependent_lines, line)
				end
			end
		end
	end

	table.sort(primary_lines)
	table.sort(dependent_lines)
	M.insert(lush_lines, primary_lines, dependent_lines)

	table.insert(lines, "end)")
	table.insert(
		lush_lines,
		[[
  }
end)

return theme]]
	)

	local output_path, output_file = config.get_compiled_info(opts)
	Files.ensure_dir(output_path)

	if write_lush then
		local lush_path, lush_file = config.get_lush_info(opts)
		Files.ensure_dir(lush_path)

		Files.write_file(lush_file, table.concat(lush_lines, "\n"))
	end

	local f = loadstring(table.concat(lines, "\n"), "=")
	if not f then
		local tmpfile = "/tmp/autumn_error.lua"
		vim.notify(fmt([[There is an error in your autumn config, refer to %s]], tmpfile))

		Files.write_file(tmpfile, table.concat(lines, "\n"))
		dofile(tmpfile)
	else
		Files.write_file(output_file, f())
	end
end

return M
