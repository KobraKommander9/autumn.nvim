local M = {}

function M.get(spec, _, _)
	local c = spec.palette

	return {
		MiniClueBorder = { link = "FloatBorder" },
		MiniClueDescGroup = { link = "DiagnosticFloatingWarn" },
		MiniClueDescSingle = { link = "NormalFloat" },
		MiniClueNextKey = { link = "DiagnosticFloatingHint" },
		MiniClueNextKeyWithPostkeys = { link = "DiagnosticFloatingError" },
		MiniClueSeparator = { link = "DiagnosticFloatingInfo" },
		MiniClueTitle = { link = "FloatTitle" },

		MiniDiffSignAdd = { fg = spec.git.add },
		MiniDiffSignChange = { fg = spec.git.changed },
		MiniDiffSignDelete = { fg = spec.git.removed },
		MiniDiffOverAdd = { link = "DiffAdd" },
		MiniDiffOverChange = { link = "DiffText" },
		MiniDiffOverContext = { link = "DiffChange" },
		MiniDiffOverDelete = { link = "DiffDelete" },

		MiniFilesBorder = { link = "FloatBorder" },
		MiniFilesBorderModified = { link = "DiagnosticFloatingWarn" },
		MiniFilesCursorLine = { link = "CursorLine" },
		MiniFilesDirectory = { link = "Directory" },
		MiniFilesFile = { fg = spec.fg1 },
		MiniFilesNormal = { link = "NormalFloat" },
		MiniFilesTitle = { link = "FloatTitle" },
		MiniFilesTitleFocused = { fg = spec.fg1, style = "bold" },

		MiniIconsAzure = { fg = c.blue.bright.hex },
		MiniIconsBlue = { fg = c.blue.hex },
		MiniIconsCyan = { fg = c.cyan.hex },
		MiniIconsGreen = { fg = c.green.hex },
		MiniIconsGrey = { fg = spec.fg0 },
		MiniIconsOrange = { fg = c.orange.hex },
		MiniIconsPurple = { fg = c.magenta.hex },
		MiniIconsRed = { fg = c.red.hex },
		MiniIconsYellow = { fg = c.yellow.hex },

		MiniPickBorder = { link = "FloatBorder" },
		MiniPickBorderBusy = { link = "DiagnosticFloatingWarn" },
		MiniPickBorderText = { link = "FloatTitle" },
		MiniPickIconDirectory = { link = "Directory" },
		MiniPickIconFile = { link = "MiniPickNormal" },
		MiniPickHeader = { link = "DiagnosticFloatingHint" },
		MiniPickMatchCurrent = { link = "CursorLine" },
		MiniPickMatchMarked = { link = "Visual" },
		MiniPickMatchRanges = { link = "DiagnosticFloatingHint" },
		MiniPickNormal = { link = "NormalFloat" },
		MiniPickPreviewLine = { link = "CursorLine" },
		MiniPickPreviewRegion = { link = "IncSearch" },
		MiniPickPrompt = { link = "DiagnosticFloatingInfo" },

		MiniSurround = { link = "IncSearch" },
	}
end

return M
