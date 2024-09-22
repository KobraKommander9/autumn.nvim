local collect = require("autumn.lib.collect")

local M = {}

function M.from(spec)
	local config = require("autumn.config").options

	local editor = require("autumn.group.editor").get(spec, config)
	local syntax = require("autumn.group.syntax").get(spec, config)

	local result = collect.deep_extend(editor, syntax)

	local module_names = require("autumn.config").module_names
	for _, name in ipairs(module_names) do
		local kind = type(config.modules[name])
		local opts = kind == "boolean" and { enable = config.modules[name] }
			or kind == "table" and config.modules[name]
			or {}

		opts.enable = opts.enable == nil and config.module_default or opts.enable

		if opts.enable then
			result = collect.deep_extend(result, require("autumn.group.modules." .. name).get(spec, config, opts))
		end
	end

	return result
end

function M.load(name)
	name = name or require("autumn.config").style
	return M.from(require("autumn.spec").load(name))
end

return M
