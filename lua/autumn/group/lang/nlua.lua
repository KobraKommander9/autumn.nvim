local M = {}

function M.get(spec, _, opts)
	local syn = spec.syntax
	local stl = opts.styles

	return {
		["@constructor.lua"] = { fg = syn.type, style = stl.constructor },
	}
end

return M
