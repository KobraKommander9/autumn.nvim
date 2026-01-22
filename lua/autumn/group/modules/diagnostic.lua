local M = {}

function M.get(roles, _, _)
	local sem = roles.semantic

	return {
		DiagnosticError = { fg = sem.error.fg, style = "underline" },
		DiagnosticWarn = { fg = sem.warn.fg, style = "underline" },
		DiagnosticInfo = { fg = sem.info.fg, style = "underline" },
		DiagnosticHint = { fg = sem.hint.fg, style = "underline" },
		DiagnosticOk = { fg = sem.ok.fg, style = "underline" },

		DiagnosticSignError = { fg = sem.error.fg },
		DiagnosticSignWarn = { fg = sem.warn.fg },
		DiagnosticSignInfo = { fg = sem.info.fg },
		DiagnosticSignHint = { fg = sem.hint.fg },
		DiagnosticSignOk = { fg = sem.ok.fg },

		DiagnosticVirtualTextError = { fg = sem.error.fg, style = "italic" },
		DiagnosticVirtualTextWarn = { fg = sem.warn.fg, style = "italic" },
		DiagnosticVirtualTextInfo = { fg = sem.info.fg, style = "italic" },
		DiagnosticVirtualTextHint = { fg = sem.hint.fg, style = "italic" },
		DiagnosticVirtualTextOk = { fg = sem.ok.fg, style = "italic" },

		DiagnosticUnderlineError = { style = "undercurl", sp = sem.error.fg },
		DiagnosticUnderlineWarn = { style = "undercurl", sp = sem.warn.fg },
		DiagnosticUnderlineInfo = { style = "undercurl", sp = sem.info.fg },
		DiagnosticUnderlineHint = { style = "undercurl", sp = sem.hint.fg },
		DiagnosticUnderlineOk = { style = "undercurl", sp = sem.ok.fg },
	}
end

return M
