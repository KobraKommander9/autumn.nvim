local M = {}

function M.get(spec, _, _)
	local syn = spec.syntax

	return {
		["@label.json"] = { fg = syn.func },
	}
end

return M
