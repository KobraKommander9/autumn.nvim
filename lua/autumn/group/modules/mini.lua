local M = {}

function M.get(roles, _, _)
	local syn = roles.syntax

	return {
		MiniFilesFile = syn.field,
	}
end

return M
