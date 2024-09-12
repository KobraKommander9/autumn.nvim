local files = require("autumn.files")

local fmt = string.format

local M = {}

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

	table.insert(lush_lines, [[  local palette = {]])
	for name, color in pairs(spec.palette) do
		local c = type(color) == "string" and color or color.hex
		table.insert(lush_lines, fmt([[    %s = hsl("%s"),]], name, c))
	end
	table.insert(lush_lines, [[  }]])

	for _, group in ipairs(spec_groups) do
		local colors = spec[group]
		table.insert(lush_lines, fmt([[  local %s = {]], group))
		for name, color in pairs(colors) do
			table.insert(lush_lines, fmt([[    %s = hsl("%s"),]], name, color))
		end
		table.insert(lush_lines, [[  }]])
	end

	table.insert(lush_lines, [[  local editor = {]])
	for key, value in pairs(spec) do
		if vim.tbl_contains(spec_groups, key) then
		-- skip
		elseif key == "palette" then
		-- skip
		else
			table.insert(lush_lines, fmt([[    %s = hsl("%s"),]], key, value))
		end
	end
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
			table.insert(lush_lines, fmt([[    %s(%s), -- %s { }]], group, inspect(op), group))
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
