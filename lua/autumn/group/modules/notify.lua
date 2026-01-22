local M = {}

function M.get(roles, _, _)
	local p = roles.palette
	local sem = roles.semantic
	local ui = roles.ui

	return {
		NotifyBackground = { bg = ui.bg.float, fg = ui.fg.main },

		NotifyERRORBorder = { fg = sem.error.fg },
		NotifyWARNBorder = { fg = sem.warn.fg },
		NotifyINFOBorder = { fg = sem.info.fg },
		NotifyDEBUGBorder = { fg = p.purple.base },
		NotifyTRACEBorder = { fg = p.magenta.base },

		NotifyERRORIcon = { fg = sem.error.fg },
		NotifyWARNIcon = { fg = sem.warn.fg },
		NotifyINFOIcon = { fg = sem.info.fg },
		NotifyDEBUGIcon = { fg = p.purple.base },
		NotifyTRACEIcon = { fg = p.magenta.base },

		NotifyERRORTitle = { fg = sem.error.fg, style = "bold" },
		NotifyWARNTitle = { fg = sem.warn.fg, style = "bold" },
		NotifyINFOTitle = { fg = sem.info.fg, style = "bold" },
		NotifyDEBUGTitle = { fg = p.purple.base, style = "bold" },
		NotifyTRACETitle = { fg = p.magenta.base, style = "bold" },

		NotifyBody = { fg = ui.fg.main, bg = ui.bg.float },
		NotifyLogTime = { fg = ui.fg.subtle },
	}
end

return M
