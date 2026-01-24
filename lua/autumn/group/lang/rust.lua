local M = {}

function M.get(spec, config, _)
	local p = spec.palette
	local syn = spec.syntax
	local stl = config.styles

	return {
		-- ["@function.rust"] = { fg = syn.func, style = stl.functions },
		-- ["@function.builtin.rust"] = { fg = syn.builtin0, style = stl.functions },
		-- ["@macro.rust"] = { fg = syn.builtin2, style = stl.functions },
		-- ["@attribute.rust"] = { fg = p.cyan.dim },
		-- ["@lifetime.rust"] = { fg = p.secondary.dim },
		-- ["@trait.rust"] = { fg = spec.secondary, style = stl.types },
		-- ["@impl.rust"] = { fg = spec.primary },
	}
end

return M
