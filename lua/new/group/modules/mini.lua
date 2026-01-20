local M = {}

function M.get(spec, _, _)
	local p = spec.palette
	local syn = spec.syntax
	local diag = spec.diag
	local diff = spec.diff

	return {
		--------------------------------------
		-- MiniClue
		MiniClueCurrent = { fg = p.primary.base, style = "bold" },
		MiniClueKeys = { fg = syn.keyword },
		MiniClueDesc = { fg = syn.variable },

		--------------------------------------
		-- MiniDiff
		MiniDiffAdd = { fg = diff.add },
		MiniDiffDelete = { fg = diff.delete },
		MiniDiffChange = { fg = diff.change },
		MiniDiffText = { fg = diff.text },

		--------------------------------------
		-- MiniFiles
		MiniFilesFile = { fg = syn.variable },
		MiniFilesFolder = { fg = p.secondary.base, style = "bold" },
		MiniFilesModule = { fg = p.purple.base },
		MiniFilesSymlink = { fg = p.cyan.base },
		MiniFilesExec = { fg = p.green.base },
		MiniFilesDot = { fg = p.fg3 }, -- hidden dotfiles
		MiniFilesNumber = { fg = syn.number },
		MiniFilesSymbol = { fg = syn.operator },

		--------------------------------------
		-- MiniIcons
		MiniIconFile = { link = "MiniFilesFile" },
		MiniIconFolder = { link = "MiniFilesFolder" },
		MiniIconModule = { link = "MiniFilesModule" },
		MiniIconClass = { fg = p.secondary.base },
		MiniIconMethod = { fg = p.pink.base },
		MiniIconFunction = { fg = p.pink.base },
		MiniIconVariable = { fg = syn.variable },
		MiniIconConstant = { fg = p.magenta.base },
		MiniIconBoolean = { fg = p.green.base },
		MiniIconNumber = { fg = syn.number },
		MiniIconString = { fg = syn.string },
		MiniIconProperty = { fg = p.secondary.base },
		MiniIconKeyword = { fg = syn.keyword },
		MiniIconOperator = { fg = syn.operator },
		MiniIconComment = { fg = syn.comment, style = "italic" },
		MiniIconWarning = { fg = diag.warn },
		MiniIconError = { fg = diag.error },
		MiniIconInfo = { fg = diag.info },

		--------------------------------------
		-- MiniPick
		MiniPickPrompt = { fg = syn.keyword, style = "bold" },
		MiniPickSelection = { bg = p.sel1 },
		MiniPickCurrent = { bg = p.sel0, fg = p.fg1, style = "bold" },
		MiniPickBorder = { fg = p.border },
		MiniPickMatch = { fg = p.primary.base, style = "bold" },

		--------------------------------------
		-- MiniSurround
		MiniSurround = { fg = syn.operator }, -- surrounding symbols
		MiniSurroundHighlight = { bg = p.sel0 }, -- selected area
		MiniSurroundYank = { bg = p.secondary.base }, -- yanked text highlight
	}
end

return M
