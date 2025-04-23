local Color = require("autumn.color")

local M = {}

function M.get(
	spec,
	_ --[[ config ]],
	_ --[[ opts ]]
)
	local diag = spec.diag
	local syn = spec.syntax

	local function border(color)
		return Color(spec.bg0).mix(Color(color), 50).hex
	end

	return {
		NotifyERRORBorder = { fg = border(diag.error) },
		NotifyWARNBorder = { fg = border(diag.warn) },
		NotifyINFOBorder = { fg = border(diag.info) },
		NotifyDEBUGBorder = { fg = border(diag.hint) },
		NotifyTRACEBorder = { fg = spec.bg3 },

		NotifyERRORTitle = { fg = diag.error },
		NotifyWARNTitle = { fg = diag.warn },
		NotifyINFOTitle = { fg = diag.info },
		NotifyDEBUGTitle = { fg = diag.hint },
		NotifyTRACETitle = { fg = syn.comment },

		NotifyERRORIcon = { link = "NotifyERRORTitle" },
		NotifyWARNIcon = { link = "NotifyWARNTitle" },
		NotifyINFOIcon = { link = "NotifyINFOTitle" },
		NotifyDEBUGIcon = { link = "NotifyDEBUGTitle" },
		NotifyTRACEIcon = { link = "NotifyTRACETitle" },
		NotifyBackground = { link = "NormalFloat" },
	}
end

return M
