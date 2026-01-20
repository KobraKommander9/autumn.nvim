local M = {}

function M.get(spec, config, _)
	local p = spec.palette
	local syn = spec.syntax
	local stl = config.styles

	return {
		["@variable.shell"] = { fg = p.blue.dim, style = stl.variables },
		["@function.builtin.shell"] = { fg = syn.builtin0, style = stl.functions },
		["@keyword.shell"] = { fg = spec.primary, style = stl.keywords },
		["@parameter.shell"] = { fg = syn.variable, style = stl.variables },
	}
end

return M
