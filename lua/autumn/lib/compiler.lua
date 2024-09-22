local collect = require("autumn.lib.collect")
local files = require("autumn.lib.files")

local fmt = string.format

local M = {}

local base_colors = {
	"white",
	"black",
	"gray",
}

local mixed_colors = {
	"red",
	"orange",
	"yellow",
	"green",
	"blue",
	"purple",
	"pink",
	"magenta",
	"cyan",
}

local spec_groups = {
	"syntax",
	"diag",
	"diff",
	"git",
}

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

local function should_link(link)
	return link and link ~= ""
end

local function inspect(tbl)
	local list = {}
	for k, v in pairs(tbl) do
		local q = type(v) == "string" and '"' or ""
		table.insert(list, fmt("%s = %s%s%s", k, q, v, q))
	end

	table.sort(list)
	return fmt([[{ %s }]], table.concat(list, ", "))
end

local function get_lush_group(group)
	return group:sub(1, 1) == "@" and fmt([[sym("%s")]], group) or group
end

function M.compile(opts)
	opts = opts or {}

	local config = require("autumn.config")
	local write_dbg = config.options.debug.enabled == true
	local style = opts.style or config.style

	local spec = require("autumn.spec").load(style)
	local groups = require("autumn.group").from(spec)
	local background = spec.palette.meta.light and "light" or "dark"

	local lines = {
		fmt(
			[[
return string.dump(function()
  local h = vim.api.nvim_set_hl
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  vim.cmd("syntax reset")

  vim.o.termguicolors = true
  vim.g.colors_name = "%s"
  vim.o.background = "%s"

]],
			style,
			background
		),
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
			table.insert(lush_lines, fmt([[  vim.g.%s = "%s"]], k, v))
		end
	end

	local function insert_color(name, color)
		if type(color) == "string" then
			table.insert(lush_lines, fmt([[    %s = hsl("%s"),]], name, color))
		elseif color ~= nil then
			table.insert(lush_lines, fmt([[    %s = hsl("%s"),]], name, color.base))
			table.insert(lush_lines, fmt([[    light_%s = hsl("%s"),]], name, color.bright))
			table.insert(lush_lines, fmt([[    dark_%s = hsl("%s"),]], name, color.dim))
		end
	end

	table.insert(lush_lines, [[  local palette = {]])
	for _, name in ipairs(base_colors) do
		local color = spec.palette[name]
		insert_color(name, color)
	end

	for _, name in ipairs(mixed_colors) do
		local color = spec.palette[name]
		insert_color(name, color)

		color = spec.palette["soft_" .. name]
		insert_color("soft_" .. name, color)

		color = spec.palette["hard_" .. name]
		insert_color("hard_" .. name, color)
	end
	table.insert(lush_lines, [[  }]])

	table.insert(lush_lines, [[  local editor = {]])
	local grouped_lines = {}
	for key, value in pairs(spec) do
		if vim.tbl_contains(spec_groups, key) then
		-- skip
		elseif key == "palette" then
		-- skip
		else
			table.insert(grouped_lines, fmt([[    %s = hsl("%s"),]], key, value))
		end
	end

	table.sort(grouped_lines)
	collect.insert(lush_lines, grouped_lines)
	table.insert(lush_lines, [[  }]])

	table.insert(
		lush_lines,
		[[

  local sym = injected_functions.sym
  return {]]
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
			if not linked_groups[lush_link] then
				linked_lines[lush_link] = linked_lines[lush_link] or {}
				table.insert(
					linked_lines[lush_link],
					fmt([[    %s({ %s }), -- %s { }]], lush_group, lush_link, lush_group)
				)
			else
				table.insert(dependent_lines, fmt([[    %s({ %s }), -- %s { }]], lush_group, lush_link, lush_group))
			end
		else
			local op = parse_style(attrs.style)
			op.bg = attrs.bg
			op.fg = attrs.fg
			op.sp = attrs.sp
			table.insert(lines, fmt([[  h(0, "%s", %s)]], group, inspect(op)))
			table.insert(primary_lines, fmt([[    %s(%s), -- %s { }]], lush_group, inspect(op), lush_group))

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
	collect.insert(lush_lines, primary_lines, dependent_lines)

	table.insert(lines, "end)")
	table.insert(
		lush_lines,
		[[
  }
end)

return theme]]
	)

	opts.style = style
	local output_path, output_file = config.get_compiled_info(opts)
	files.ensure_dir(output_path)

	if write_dbg then
		local dbg_path, dbg_file = config.get_debug_info(opts)
		files.ensure_dir(dbg_path)

		files.write_file(dbg_file .. ".lua", table.concat(lines, "\n"))
		files.write_file(dbg_file .. "_lush.lua", table.concat(lush_lines, "\n"))
	end

	local f = loadstring(table.concat(lines, "\n"), "=")
	if not f then
		local tmpfile = "/tmp/autumn_error.lua"
		vim.notify(fmt([[There is an error in your autumn config, refer to %s]], tmpfile))

		files.write_file(tmpfile, table.concat(lines, "\n"))
		dofile(tmpfile)
	else
		files.write_file(output_file, f())
	end
end

return M
