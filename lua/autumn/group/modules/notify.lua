local C = require("autumn.color")

local M = {}

function M.get(spec, _, _)
	local bg = C(spec.bg1)
	local function border(color, amount)
		amount = amount or 50
		return bg.mix(C(color), amount).hex
	end

	return {
		NotifyERRORBorder = { fg = border(spec.diag.error) },
		NotifyWARNBorder = { fg = border(spec.diag.warn) },
		NotifyINFOBorder = { fg = border(spec.diag.info) },
		NotifyDEBUGBorder = { fg = border(spec.diag.hint) },
		NotifyTRACEBorder = { fg = spec.bg4 },

		NotifyERRORTitle = { fg = spec.diag.error },
		NotifyWARNTitle = { fg = spec.diag.warn },
		NotifyINFOTitle = { fg = spec.diag.info },
		NotifyDEBUGTitle = { fg = spec.diag.hint },
		NotifyTRACETitle = { fg = spec.syntax.comment },

		NotifyERRORIcon = { link = "NotifyERRORTitle" },
		NotifyWARNIcon = { link = "NotifyWARNTitle" },
		NotifyINFOIcon = { link = "NotifyINFOTitle" },
		NotifyDEBUGIcon = { link = "NotifyDEBUGTitle" },
		NotifyTRACEIcon = { link = "NotifyTRACETitle" },
		NotifyBackground = { link = "NormalFloat" },
	}
end

return M
