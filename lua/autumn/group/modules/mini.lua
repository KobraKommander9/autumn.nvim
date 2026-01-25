local M = {}

function M.get(roles, _, _)
	local sem = roles.semantic
	local syn = roles.syntax
	local ui = roles.ui

	return {
		-- Mini Files
		MiniFilesFile = syn.field,

		-- Mini Pick
		MiniPickBorder = { fg = ui.border, bg = ui.bg.float },
		MiniPickPrompt = { fg = sem.info.fg, bg = roles.ui.bg.float, style = "bold" },
		MiniPickMatchCurrent = { link = "IncSearch" },
	}
end

return M
