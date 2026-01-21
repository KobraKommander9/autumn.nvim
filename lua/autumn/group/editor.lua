local M = {}

function M.get(roles, _)
	return {
		-- Basic editor
		Normal = { fg = roles.ui.fg.main, roles.ui.bg.main },
		NormalFloat = { fg = roles.ui.fg.main, bg = roles.ui.bg.float },
		NormalNC = { link = "Normal" },
		Visual = { bg = roles.ui.bg.visual },
		VisualNOS = { link = "Visual" },

		EndOfBuffer = { fg = roles.ui.bg.main },
		Whitespace = { fg = roles.ui.fg.subtle },
		NonText = { fg = roles.ui.fg.subtle },
		Conceal = { link = "NonText" },
		SpecialKey = { link = "NonText" },

		-- Cursor / line
		CursorLine = { bg = roles.ui.bg.alt },
		CursorLineNr = { fg = roles.ui.gutter.active, bg = roles.ui.gutter.bg },
		LineNr = { fg = roles.ui.gutter.fg, bg = roles.ui.gutter.bg },
		ColorColumn = { bg = roles.ui.bg.alt },

		Cursor = { fg = roles.ui.bg.main, bg = roles.ui.fg.main },
		lCursor = { link = "Cursor" },
		CursorIM = { link = "Cursor" },

		-- Signs / folds
		SignColumn = { bg = roles.ui.bg.main },
		SignColumnSB = { link = "SignColumn" },
		FoldColumn = { fg = roles.ui.fg.subtle, bg = roles.ui.bg.main },
		Folded = { fg = roles.ui.fg.dim, bg = roles.ui.bg.alt, style = "italic" },

		-- Tabs / status
		StatusLine = { fg = roles.ui.fg.main, bg = roles.ui.bg.alt },
		StatusLineNC = { fg = roles.ui.fg.subtle, bg = roles.ui.bg.alt },
		TabLine = { fg = roles.ui.fg.dim, bg = roles.ui.bg.alt },
		TabLineFill = { bg = roles.ui.bg.alt },
		TabLineSel = { fg = roles.ui.bg.main, bg = roles.ui.fg.main, style = "bold" },

		WinSeparator = { fg = roles.ui.border.base },
		VertSplit = { link = "WinSeparator" },
		WinBar = { fg = roles.ui.fg.main, bg = roles.ui.bg.main, style = "bold" },
		WinBarNC = { fg = roles.ui.fg.subtle, bg = roles.ui.bg.main },

		FloatBorder = { fg = roles.ui.border.base, bg = roles.ui.bg.float },

		-- Search
		Search = { bg = roles.ui.selection.bg, fg = roles.ui.fg.main },
		IncSearch = { bg = roles.ui.selection.active, fg = roles.ui.bg.main },
		CurSearch = { link = "IncSearch" },
		Substitute = { bg = roles.ui.bg.accent, fg = roles.ui.bg.main },

		-- Spelling & Diffs
		SpellBad = { sp = roles.semantic.error.fg, style = "undercurl" },
		SpellCap = { sp = roles.semantic.warn.fg, style = "undercurl" },
		SpellLocal = { sp = roles.semantic.info.fg, style = "undercurl" },
		SpellRare = { sp = roles.semantic.hint.fg, style = "undercurl" },

		DiffAdd = { bg = roles.semantic.success.fg, fg = roles.ui.bg.main },
		DiffChange = { bg = roles.semantic.changed.fg, fg = roles.ui.bg.main },
		DiffDelete = { bg = roles.semantic.deleted.fg, fg = roles.ui.bg.main },
		DiffText = { bg = roles.semantic.info.fg, fg = roles.ui.bg.main },

		-- Popup menus
		Pmenu = { fg = roles.ui.fg.main, bg = roles.ui.bg.float },
		PmenuSbar = { link = "Pmenu" },
		PmenuSel = { bg = roles.ui.selection.active },
		PmenuThumb = { bg = roles.ui.fg.subtle },
		WildMenu = { link = "Pmenu" },

		-- Messages
		MsgArea = { fg = roles.ui.fg.main },
		ModeMsg = { fg = roles.ui.fg.main, style = "bold" },
		MoreMsg = { fg = roles.semantic.info.fg },
		Question = { link = "MoreMsg" },
		ErrorMsg = { fg = roles.semantic.error.fg, style = "bold" },
		WarningMsg = { fg = roles.semantic.warn.fg, style = "bold" },

		-- QuickFix / misc
		QuickFixLine = { bg = roles.ui.bg.alt, style = "bold" },
		MatchParen = { bg = roles.ui.selection.bg, style = "bold" },
		Directory = { fg = roles.semantic.info.fg, style = "bold" },

		-- Titles / headings
		Title = roles.markup.heading,
	}
end

return M
