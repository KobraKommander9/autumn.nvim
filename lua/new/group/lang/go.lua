local M = {}

function M.get(spec, config, _)
	local p = spec.palette
	local syn = spec.syntax
	local stl = config.styles

	return {
		["@variable.go"] = { fg = syn.variable, style = stl.variables },
		["@function.go"] = { fg = syn.func, style = stl.functions },
		["@function.builtin.go"] = { fg = syn.builtin0, style = stl.functions },
		["@interface.go"] = { fg = spec.secondary, style = stl.types },
		["@type.builtin.go"] = { fg = spec.secondary, style = stl.types },
		["@keyword.go"] = { fg = spec.primary, style = stl.keywords },
		["@constant.go"] = { fg = p.magenta.base, style = stl.constants },
	}
end

return M
