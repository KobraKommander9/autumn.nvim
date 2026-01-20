local M = {}

function M.get(spec, _, _)
	local diag = spec.diag

	return {
		NotifyBackground = { bg = spec.bg2 },

		NotifyERRORBorder = { fg = diag.error },
		NotifyWARNBorder = { fg = diag.warn },
		NotifyINFOBorder = { fg = diag.info },
		NotifyDEBUGBorder = { fg = spec.fg3 },
		NotifyTRACEBorder = { fg = spec.fg3 },

		NotifyERRORTitle = { fg = diag.error, style = "bold" },
		NotifyWARNTitle = { fg = diag.warn, style = "bold" },
		NotifyINFOTitle = { fg = diag.info, style = "bold" },
		NotifyDEBUGTitle = { fg = spec.fg3, style = "bold" },
		NotifyTRACETitle = { fg = spec.fg3, style = "bold" },

		NotifyERRORIcon = { fg = diag.error },
		NotifyWARNIcon = { fg = diag.warn },
		NotifyINFOIcon = { fg = diag.info },
		NotifyDEBUGIcon = { fg = spec.fg3 },
		NotifyTRACEIcon = { fg = spec.fg3 },

		NotifyERRORBody = { fg = spec.fg1 },
		NotifyWARNBody = { fg = spec.fg1 },
		NotifyINFOBody = { fg = spec.fg1 },
		NotifyDEBUGBody = { fg = spec.fg1 },
		NotifyTRACEBody = { fg = spec.fg1 },
	}
end

return M
