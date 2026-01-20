local M = {}

function M.get(spec, _, _)
	local d = spec.diag

	return {
		DiagnosticError = { fg = d.error, style = "underline" },
		DiagnosticWarn = { fg = d.warn, style = "underline" },
		DiagnosticInfo = { fg = d.info, style = "underline" },
		DiagnosticHint = { fg = d.hint, style = "underline" },
		DiagnosticOk = { fg = d.ok, style = "underline" },

		DiagnosticSignError = { fg = d.error },
		DiagnosticSignWarn = { fg = d.warn },
		DiagnosticSignInfo = { fg = d.info },
		DiagnosticSignHint = { fg = d.hint },
		DiagnosticSignOk = { fg = d.ok },

		DiagnosticVirtualTextError = { fg = d.error, style = "italic" },
		DiagnosticVirtualTextWarn = { fg = d.warn, style = "italic" },
		DiagnosticVirtualTextInfo = { fg = d.info, style = "italic" },
		DiagnosticVirtualTextHint = { fg = d.hint, style = "italic" },
		DiagnosticVirtualTextOk = { fg = d.ok, style = "italic" },

		DiagnosticUnderlineError = { style = "undercurl", sp = d.error },
		DiagnosticUnderlineWarn = { style = "undercurl", sp = d.warn },
		DiagnosticUnderlineInfo = { style = "undercurl", sp = d.info },
		DiagnosticUnderlineHint = { style = "undercurl", sp = d.hint },
		DiagnosticUnderlineOk = { style = "undercurl", sp = d.ok },
	}
end

return M
