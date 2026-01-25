local M = {}

function M.get(roles, _, _)
	local syn = roles.syntax

	return {
		["@attribute.rust"] = { fg = roles.emphasis.medium.fg },
		["@punctuation.special.rust"] = { link = "PreProc" },
		["@constant.builtin.rust"] = { fg = syn.boolean.fg },
	}
end

return M
