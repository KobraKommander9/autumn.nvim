local M = {}

function M.get(spec, _ --[[ config ]], _ --[[ opts ]])
  local d = spec.diag

  return {
    DiagnosticError = { fg = d.error },
    DiagnosticWarn = { fg = d.warn },
    DiagnosticInfo = { fg = d.info },
    DiagnosticHint = { fg = d.hint },
    DiagnosticOk = { fg = d.ok },

    DiagnosticSignError = { link = "DiagnosticError" },
    DiagnosticSignWarn = { link = "DiagnosticWarn" },
    DiagnosticSignInfo = { link = "DiagnosticInfo" },
    DiagnosticSignHint = { link = "DiagnosticHint" },
    DiagnosticSignOk = { link = "DiagnosticOk" },

    DiagnosticVirtualTextError = { fg = d.error, bg = spec.bg1 },
    DiagnosticVirtualTextWarn = { fg = d.warn, bg = spec.bg1 },
    DiagnosticVirtualTextInfo = { fg = d.info, bg = spec.bg1 },
    DiagnosticVirtualTextHint = { fg = d.hint, bg = spec.bg1 },
    DiagnosticVirtualTextOk = { fg = d.ok, bg = spec.bg1 },

    DiagnosticUnderlineError = { sp = d.error, style = "underline" },
    DiagnosticUnderlineWarn = { sp = d.warn, style = "underline" },
    DiagnosticUnderlineInfo = { sp = d.info, style = "underline" },
    DiagnosticUnderlineHint = { sp = d.hint, style = "underline" },
    DiagnosticUnderlineOk = { sp = d.ok, style = "underline" },
  }
end

return M
