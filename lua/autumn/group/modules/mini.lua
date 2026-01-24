local M = {}

function M.get(roles, _, _)
	local p = roles.palette
	local sem = roles.semantic
	local syn = roles.syntax
	local ui = roles.ui

	return {
		--------------------------------------
		-- MiniClue (The keybinding helper)
		--------------------------------------
		-- MiniClueCurrent = roles.emphasis.high,
		-- MiniClueKeys = syn.keyword,
		-- MiniClueDesc = syn.variable,
		-- MiniClueBorder = { fg = ui.border, bg = ui.bg.float },

		--------------------------------------
		-- MiniDiff (The gutter signs)
		--------------------------------------
		-- MiniDiffAdd = { fg = sem.success.fg },
		-- MiniDiffDelete = { fg = sem.deleted.fg },
		-- MiniDiffChange = { fg = sem.changed.fg },
		-- MiniDiffText = { fg = p.blue.base }, -- Used in diff overlays

		--------------------------------------
		-- MiniFiles (The file explorer)
		--------------------------------------
		-- MiniFilesFile = syn.variable,
		-- MiniFilesFolder = { fg = syn.type.fg, style = "bold" }, -- Linked to Olive
		-- MiniFilesModule = syn.module,
		-- MiniFilesSymlink = { fg = p.cyan.base },
		-- MiniFilesExec = { fg = p.green.base },
		-- MiniFilesDot = { fg = ui.fg.subtle },
		-- MiniFilesNumber = syn.number,
		-- MiniFilesSymbol = syn.punctuation,
		-- MiniFilesBorder = { fg = ui.border },

		--------------------------------------
		-- MiniIcons (Used across the mini ecosystem)
		--------------------------------------
		-- MiniIconsAzure = { fg = p.blue.base },
		-- MiniIconsBlue = { fg = p.blue.dim },
		-- MiniIconsCyan = { fg = p.cyan.base },
		-- MiniIconsGreen = { fg = p.green.base },
		-- MiniIconsGrey = { fg = p.fg0 },
		-- MiniIconsMagenta = { fg = p.magenta.base },
		-- MiniIconsOrange = { fg = p.primary.base },
		-- MiniIconsPurple = { fg = p.purple.base },
		-- MiniIconsRed = { fg = p.red.base },
		-- MiniIconsYellow = { fg = p.yellow.base },

		--------------------------------------
		-- MiniPick (The fuzzy selector)
		--------------------------------------
		-- MiniPickPrompt = { fg = syn.keyword.fg, style = "bold" },
		-- MiniPickBorder = { fg = ui.border, bg = ui.bg.float },
		-- MiniPickHeader = { fg = syn.keyword.fg },
		-- MiniPickMatch = { fg = p.primary.base, style = "bold" }, -- Match Blink matching
		-- MiniPickSelection = { bg = ui.selection.active, style = "bold" },

		--------------------------------------
		-- MiniSurround
		--------------------------------------
		-- MiniSurround = syn.operator,
		-- MiniSurroundHighlight = { bg = ui.bg.visual }, -- Make it pop using bg3
	}
end

return M
