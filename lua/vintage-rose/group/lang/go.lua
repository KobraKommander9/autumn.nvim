local M = {}

function M.get(roles, _, _)
	local syn = roles.syntax

	return {
		["@constant.builtin.go"] = { fg = syn.boolean.fg },
	}
end

return M
