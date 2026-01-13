local M = {}

function M.get(spec, _, _)
	return {
		["@field.rust"] = { fg = spec.fg2 },
	}
end

return M
