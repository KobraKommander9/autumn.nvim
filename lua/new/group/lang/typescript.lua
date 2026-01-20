local M = {}

function M.get(spec, config, opts)
	local p = spec.palette
	local syn = spec.syntax
	local stl = config.styles
	local op_stl = opts.styles

	return {
		typescriptParent = { fg = syn.bracket },

		["@interface.ts"] = { fg = p.cyan.dim, style = stl.types },
		["@type.builtin.ts"] = { fg = spec.secondary, style = stl.types },
		["@enum.ts"] = { fg = spec.secondary },
		["@decorator.ts"] = { fg = p.magenta.base, style = op_stl.decorator },
		["@variable.ts"] = { fg = syn.variable, style = stl.variables },
		["@function.ts"] = { fg = syn.func, style = stl.functions },
		["@function.builtin.ts"] = { fg = syn.builtin0, style = stl.functions },
	}
end

return M
