local M = {}

function M.get(roles, _, _)
	local p = roles.palette
	local syn = roles.syntax
	local ui = roles.ui

	return {
		-- the main menu
		BlinkCmpMenu = { fg = ui.fg.main, bg = ui.bg.float },
		BlinkCmpMenuBorder = { fg = ui.border.base, bg = ui.bg.float },
		BlinkCmpMenuSelection = { fg = ui.fg.main, bg = ui.selection.active, style = "bold" },
		BlinkCmpLabelDescription = { fg = ui.fg.subtle },
		BlinkCmpSource = { fg = p.purple.dim, style = "italic" },

		-- fuzzy matching
		BlinkCmpLabelMatch = roles.emphasis.high,

		-- item kind icons
		BlinkCmpKindFunction = { fg = syn.func.fg },
		BlinkCmpKindMethod = { fg = syn.func.fg },
		BlinkCmpKindVariable = { fg = syn.variable.fg },
		BlinkCmpKindKeyword = { fg = syn.keyword.fg },
		BlinkCmpKindProperty = { fg = syn.field.fg },
		BlinkCmpKindInterface = { fg = syn.interface.fg },
		BlinkCmpKindTypeParameter = { fg = syn.interface.fg },
		BlinkCmpKindClass = { fg = syn.type.fg },
		BlinkCmpKindStruct = { fg = syn.type.fg },
		BlinkCmpKindConstant = { fg = syn.constant.fg },
		BlinkCmpKindField = { fg = syn.field.fg },
		BlinkCmpKindSnippet = { fg = p.magenta.base },
		BlinkCmpKindModule = { fg = syn.module.fg },

		-- documentation window
		BlinkCmpDoc = { fg = ui.fg.main, bg = ui.bg.float },
		BlinkCmpDocBorder = { fg = ui.border.base, bg = ui.bg.float },
		BlinkCmpDocCursorLine = { bg = ui.selection.bg },

		-- signature help
		BlinkCmpSignatureHelp = { fg = ui.fg.main, bg = ui.bg.float },
		BlinkCmpSignatureHelpBorder = { fg = ui.border.base, bg = ui.bg.float },
		BlinkCmpSignatureHelpActiveParameter = roles.emphasis.high,
	}
end

return M
