local M = {}

function M.get(spec, _)
	local diag = spec.diag
	local diff = spec.diff
	local syn = spec.syntax

	return {
		-- Basic editor
		Normal = { bg = spec.bg0, fg = spec.fg1 },
		NormalFloat = { bg = spec.bg1, fg = spec.fg1 },
		NormalNC = { link = "Normal" },
		Visual = { bg = spec.sel0 },
		VisualNOS = { link = "Visual" },

		EndOfBuffer = { fg = spec.bg3 },
		Whitespace = { fg = spec.bg3 },
		NonText = { fg = spec.bg3 },
		Conceal = { link = "NonText" },
		SpecialKey = { link = "NonText" },

		-- Cursor / line
		CursorLine = { bg = spec.bg1 },
		CursorColumn = { link = "CursorLine" },
		CursorLineNr = { fg = syn.number, style = "bold" },
		LineNr = { fg = spec.fg3 },
		ColorColumn = { bg = spec.bg2 },

		Cursor = { fg = spec.bg0, bg = spec.fg1 },
		lCursor = { link = "Cursor" },
		CursorIM = { link = "Cursor" },

		-- Signs / folds
		SignColumn = { fg = spec.fg3 },
		SignColumnSB = { link = "SignColumn" },
		FoldColumn = { fg = spec.fg3 },
		Folded = { fg = spec.fg3, bg = spec.bg2 },

		-- Tabs / status
		StatusLine = { fg = spec.fg2, bg = spec.bg2 },
		StatusLineNC = { fg = spec.fg0, bg = spec.bg0 },
		TabLine = { fg = spec.fg2, bg = spec.bg2 },
		TabLineFill = { bg = spec.bg0 },
		TabLineSel = { fg = spec.bg0, bg = spec.fg2 },

		WinSeparator = { fg = spec.border },
		VertSplit = { link = "WinSeparator" },
		WinBar = { bg = spec.bg0, fg = spec.fg1, style = "bold" },
		WinBarNC = { bg = spec.bg0, fg = spec.fg3 },

		FloatBoarder = { fg = spec.border },

		-- Search
		Search = { bg = spec.sel0, fg = spec.bg0 },
		IncSearch = { bg = spec.sel1, fg = spec.bg0 },
		CurSearch = { link = "IncSearch" },
		Substitute = { bg = diag.error, fg = spec.bg0 },

		-- Diagnostics
		SpellBad = { sp = diag.error, style = "undercurl" },
		SpellCap = { sp = diag.warn, style = "undercurl" },
		SpellLocal = { sp = diag.info, style = "undercurl" },
		SpellRare = { sp = diag.hint, style = "undercurl" },

		-- Diff
		DiffAdd = { bg = diff.add },
		DiffChange = { bg = diff.change },
		DiffDelete = { bg = diff.delete },
		DiffText = { bg = diff.text },

		-- Popup menus
		Pmenu = { bg = spec.sel0, fg = spec.fg1 },
		PmenuSbar = { link = "Pmenu" },
		PmenuSel = { bg = spec.sel1 },
		PmenuThumb = { bg = spec.sel1 },
		WildMenu = { link = "Pmenu" },

		-- Messages
		MsgArea = { fg = spec.fg1 },
		ModeMsg = { fg = diag.ok, style = "bold" },
		MoreMsg = { fg = diag.info, style = "bold" },
		Question = { link = "MoreMsg" },
		ErrorMsg = { fg = diag.error },
		WarningMsg = { fg = diag.warn },

		-- QuickFix / misc
		QuickFixLine = { bg = diag.info, fg = spec.bg0 },
		MatchParen = { fg = diag.warn, style = "bold" },
		Directory = { fg = syn.type },

		-- Titles / headings
		title = { fg = syn.type, style = "bold" },
	}
end

return M
