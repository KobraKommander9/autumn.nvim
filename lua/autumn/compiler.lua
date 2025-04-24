local M = {}

local Files = require("autumn.files")
local fmt = string.format

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

local function inspect(tbl)
	local list = {}
	for k, v in pairs(tbl) do
		local q = type(v) == "string" and '"' or ""
		table.insert(list, fmt("%s = %s%s%s", k, q, v, q))
	end

	table.sort(list)
	return fmt([[{ %s }]], table.concat(list, ", "))
end

local function should_link(link)
	return link and link ~= ""
end

function M.compile(opts)
	opts = opts or {}

	local config = require("autumn.config")

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

	if config.options.terminal_colors then
		local terminal = require("autumn.group.terminal").get(spec)
		for k, v in pairs(terminal) do
			table.insert(lines, fmt([[  vim.g.%s = "%s"]], k, v))
		end
	end

	for group, attrs in pairs(groups) do
		if should_link(attrs.link) then
			table.insert(lines, fmt([[  h(0, "%s", { link = "%s" })]], group, attrs.link))
		else
			local op = parse_style(attrs.style)
			op.bg = attrs.bg
			op.fg = attrs.fg
			op.sp = attrs.sp
			table.insert(lines, fmt([[  h(0, "%s", %s)]], group, inspect(op)))
		end
	end

	table.insert(lines, "end)")

	local output_path, output_file = config.get_compiled_info(opts)
	Files.ensure_dir(output_path)

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
