local M = {}

function M.get(roles, _, _)
	local sem = roles.semantic

	return {
		DiagnosticError = { fg = sem.error.fg },
		DiagnosticWarn = { fg = sem.warn.fg },
		DiagnosticInfo = { fg = sem.info.fg },
		DiagnosticHint = { fg = sem.hint.fg },
		DiagnosticOk = { fg = sem.ok.fg },

		DiagnosticFloatingError = { link = "DiagnosticError" },
		DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
		DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
		DiagnosticFloatingHint = { link = "DiagnosticHint" },
		DiagnosticFloatingOk = { link = "DiagnosticOk" },

		DiagnosticSignError = { link = "DiagnosticError" },
		DiagnosticSignWarn = { link = "DiagnosticWarn" },
		DiagnosticSignInfo = { link = "DiagnosticInfo" },
		DiagnosticSignHint = { link = "DiagnosticHint" },
		DiagnosticSignOk = { link = "DiagnosticOk" },

		DiagnosticVirtualTextError = sem.error,
		DiagnosticVirtualTextWarn = sem.warn,
		DiagnosticVirtualTextInfo = sem.info,
		DiagnosticVirtualTextHint = sem.hint,
		DiagnosticVirtualTextOk = sem.ok,

		DiagnosticUnderlineError = { style = "undercurl", sp = sem.error.fg },
		DiagnosticUnderlineWarn = { style = "undercurl", sp = sem.warn.fg },
		DiagnosticUnderlineInfo = { style = "undercurl", sp = sem.info.fg },
		DiagnosticUnderlineHint = { style = "undercurl", sp = sem.hint.fg },
		DiagnosticUnderlineOk = { style = "undercurl", sp = sem.ok.fg },
	}
end

return M
