local M = {}

function M.get(roles, _, _)
	local syn = roles.syntax

	return {
		jsonKeyword = { fg = syn.field.fg },

		["@constant.builtin.json"] = { link = "@number" },
	}
end

return M
