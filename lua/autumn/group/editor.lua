local M = {}

function M.get(roles, _)
	local sem = roles.semantic
	local ui = roles.ui

	return {
		-- Basic editor
		Normal = { fg = ui.fg.main, bg = ui.bg.main },
		NormalFloat = { fg = ui.fg.main, bg = ui.bg.float },
		NormalNC = { link = "Normal" },
		Visual = { bg = ui.bg.visual },
		VisualNOS = { link = "Visual" },

		EndOfBuffer = { fg = ui.bg.main },
		Whitespace = { fg = ui.fg.subtle },
		NonText = { fg = ui.fg.subtle },
		Conceal = { link = "NonText" },
		SpecialKey = { link = "NonText" },

		-- Cursor / line
		CursorLine = { bg = ui.bg.alt },
		CursorLineNr = { fg = ui.gutter.active, bg = ui.gutter.bg },
		LineNr = { fg = ui.gutter.fg, bg = ui.gutter.bg },
		ColorColumn = { bg = ui.bg.alt },

		Cursor = { fg = ui.bg.main, bg = ui.fg.main },
		lCursor = { link = "Cursor" },
		CursorIM = { link = "Cursor" },

		-- Signs / folds
		SignColumn = { bg = ui.bg.main },
		SignColumnSB = { link = "SignColumn" },
		FoldColumn = { fg = ui.fg.subtle, bg = ui.bg.main },
		Folded = { fg = ui.fg.dim, bg = ui.bg.alt, style = "italic" },

		-- Tabs / status
		StatusLine = { fg = ui.fg.main, bg = ui.bg.alt },
		StatusLineNC = { fg = ui.fg.subtle, bg = ui.bg.alt },
		TabLine = { fg = ui.fg.dim, bg = ui.bg.alt },
		TabLineFill = { bg = ui.bg.alt },
		TabLineSel = { fg = ui.bg.main, bg = ui.fg.main, style = "bold" },

		WinSeparator = { fg = ui.border },
		VertSplit = { link = "WinSeparator" },
		WinBar = { fg = ui.fg.main, bg = ui.bg.main, style = "bold" },
		WinBarNC = { fg = ui.fg.subtle, bg = ui.bg.main },

		FloatBorder = { fg = ui.border, bg = ui.bg.float },

		-- Search
		Search = { bg = ui.selection.bg, fg = ui.fg.main },
		IncSearch = { bg = ui.selection.active, fg = ui.bg.main },
		CurSearch = { link = "IncSearch" },
		Substitute = { bg = ui.selection.active, fg = ui.bg.main },

		-- Spelling & Diffs
		SpellBad = { sp = sem.error.fg, style = "undercurl" },
		SpellCap = { sp = sem.warn.fg, style = "undercurl" },
		SpellLocal = { sp = sem.info.fg, style = "undercurl" },
		SpellRare = { sp = sem.hint.fg, style = "undercurl" },

		DiffAdd = { bg = sem.success.fg, fg = ui.bg.main },
		DiffChange = { bg = sem.changed.fg, fg = ui.bg.main },
		DiffDelete = { bg = sem.deleted.fg, fg = ui.bg.main },
		DiffText = { bg = sem.info.fg, fg = ui.bg.main },

		-- Popup menus
		Pmenu = { fg = ui.fg.main, bg = ui.bg.float },
		PmenuSbar = { link = "Pmenu" },
		PmenuSel = { bg = ui.selection.active },
		PmenuThumb = { bg = ui.fg.subtle },
		WildMenu = { link = "Pmenu" },

		-- Messages
		MsgArea = { fg = ui.fg.main },
		ModeMsg = { fg = ui.fg.main, style = "bold" },
		MoreMsg = roles.info.msg,
		Question = { link = "MoreMsg" },
		ErrorMsg = { fg = sem.error.fg, style = "bold" },
		WarningMsg = { fg = sem.warn.fg, style = "bold" },

		-- QuickFix / misc
		QuickFixLine = { bg = ui.bg.alt, style = "bold" },
		MatchParen = { bg = ui.selection.bg, style = "bold" },
		Directory = { fg = sem.info.fg, style = "bold" },

		-- Titles / headings
		Title = roles.markup.heading,
	}
end

return M
