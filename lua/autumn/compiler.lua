local collect = require("autumn.collect")
local files = require("autumn.files")

local fmt = string.format

local M = {}

local spec_colors = {
	"white",
	"black",
	"gray",

	"red",
	"orange",
	"yellow",
	"green",
	"blue",
	"purple",
	"pink",
	"magenta",
	"cyan",

  "soft_red",
  "soft_orange",
  "soft_yellow",
  "soft_green",
  "soft_blue",
  "soft_purple",
  "soft_pink",
  "soft_magenta",
  "soft_cyan",

  "hard_red",
  "hard_orange",
  "hard_yellow",
  "hard_green",
  "hard_blue",
  "hard_purple",
  "hard_pink",
  "hard_magenta",
  "hard_cyan",
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

local function get_color_names(colors, groups, color)
	local result = {}

	local names = { "fg", "bg", "sp" }
	for _, name in ipairs(names) do
		result[name] = color[name] and colors[color[name]]
	end

	for group_name, group in pairs(groups) do
		for _, name in ipairs(names) do
			if color[name] and group[color[name]] then
				if result[name] == nil then
					result[name] = group_name .. "." .. group[color[name]]
				else
					result[name] = result[name] .. ", " .. group_name .. "." .. group[color[name]]
				end
			end
		end
	end

	return result
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

local theme = lush(function(injected_functions)]],
	}

	local lush_colors = {}
	local lush_grouped_colors = {}

	table.insert(lush_lines, [[  local palette = {]])
	for _, name in ipairs(spec_colors) do
		local color = spec.palette.palette[name]
		if type(color) == "string" then
			table.insert(lush_lines, fmt([[    %s = hsl("%s"),]], name, color))
			lush_colors[color] = name
		else
			table.insert(lush_lines, fmt([[    %s = hsl("%s"),]], name, color.base))
			table.insert(lush_lines, fmt([[    light_%s = hsl("%s"),]], name, color.bright))
			table.insert(lush_lines, fmt([[    dark_%s = hsl("%s"),]], name, color.dim))
			lush_colors[color.base] = name
			lush_colors[color.bright] = "light_" .. name
			lush_colors[color.dim] = "dark_" .. name
		end
	end
	table.insert(lush_lines, [[  }]])

	for _, group in ipairs(spec_groups) do
		local colors = spec[group]
		table.insert(lush_lines, fmt([[  local %s = {]], group))
		lush_grouped_colors[group] = {}

		local grouped_lines = {}
		for name, color in pairs(colors) do
			table.insert(grouped_lines, fmt([[    %s = hsl("%s"),]], name, color))
			lush_grouped_colors[group][color] = name
		end

		table.sort(grouped_lines)
		collect.insert(lush_lines, grouped_lines)

		table.insert(lush_lines, [[  }]])
	end

	table.insert(lush_lines, [[  local editor = {]])
	lush_grouped_colors.editor = {}
	local grouped_lines = {}

	for key, value in pairs(spec) do
		if vim.tbl_contains(spec_groups, key) then
		-- skip
		elseif key == "palette" then
		-- skip
		else
			table.insert(grouped_lines, fmt([[    %s = hsl("%s"),]], key, value))
			lush_grouped_colors.editor[value] = key
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

	for group, attrs in pairs(groups) do
		if should_link(attrs.link) then
			table.insert(lines, fmt([[  h(0, "%s", { link = "%s" })]], group, attrs.link))
			table.insert(lush_lines, fmt([[    %s({ link = "%s" }), -- %s { }]], group, attrs.link, group))
		else
			local op = parse_style(attrs.style)
			op.bg = attrs.bg
			op.fg = attrs.fg
			op.sp = attrs.sp
			table.insert(lines, fmt([[  h(0, "%s", %s)]], group, inspect(op)))
			table.insert(
				lush_lines,
				fmt(
					[[    %s(%s), -- %s { } %s]],
					group,
					inspect(op),
					group,
					inspect(get_color_names(lush_colors, lush_grouped_colors, op))
				)
			)
		end
	end

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
