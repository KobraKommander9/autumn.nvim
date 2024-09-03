local lush = require("lush")
local hsl = lush.hsl

local theme = lush(function(injected_functions)
	local colors = {
		white = hsl("#f4ebbe"),
		black = hsl("#272d2d"),

		primary = hsl("#eb5e28"),
		secondary = hsl("#6a8532"),

		red = hsl("#800e13"),
		orange = hsl("#f27f34"),
		yellow = hsl("#edd83d"),
		green = hsl("#799431"),
		blue = hsl("#1c77c3"),
		purple = hsl("#846b8a"),

		pink = hsl("#d65780"),
		magenta = hsl("#a23b72"),
	}

	colors.light_primary1 = colors.primary.lighten(10)
	colors.light_primary2 = colors.primary.lighten(20)
	colors.light_secondary1 = colors.secondary.lighten(20)
	colors.light_secondary2 = colors.secondary.lighten(40)

	colors.white_orange = colors.white.mix(colors.orange, 50)

	colors.light_red = colors.red.lighten(50)
	colors.light_orange = colors.orange.lighten(50)
	colors.light_yellow = colors.yellow.lighten(50)
	colors.light_green = colors.green.lighten(50)
	colors.light_blue = colors.blue.lighten(50)
	colors.light_purple = colors.purple.lighten(30)

	colors.light_pink = colors.pink.lighten(10)
	colors.light_magenta = colors.magenta.lighten(40)

	colors.dark_yellow = colors.yellow.darken(50)

	colors.gray = colors.white.mix(colors.black, 90)
	colors.light_gray1 = colors.gray.lighten(90)
	colors.light_gray2 = colors.gray.lighten(80)
	colors.light_gray3 = colors.gray.lighten(70)
	colors.light_gray4 = colors.gray.lighten(60)
	colors.dark_gray1 = colors.gray.darken(60)
	colors.dark_gray2 = colors.gray.darken(50)
	colors.dark_gray3 = colors.gray.darken(20)
	colors.dark_gray4 = colors.gray.lighten(10)

	local sym = injected_functions.sym
	return {
		NonText({ fg = colors.dark_gray4 }),
		Normal({ fg = colors.light_gray2, bg = colors.dark_gray2 }),

		ColorColumn({ bg = colors.dark_gray4 }),
		Conceal({ NonText }),
		CurSearch({ fg = colors.yellow.readable(), bg = colors.yellow }),
		CursorColumn({ bg = colors.dark_gray3 }),
		CursorLine({ CursorColumn }),
		Directory({ fg = colors.primary }),
		DiffAdd({ fg = colors.green.readable(), bg = colors.green }),
		DiffChange({ fg = colors.light_gray1, bg = colors.dark_gray4 }),
		DiffDelete({ fg = colors.light_red, gui = "bold" }),
		DiffText({ fg = colors.light_blue.readable(), bg = colors.light_blue }),
		ErrorMsg({ fg = colors.light_red }),
		Folded({ fg = colors.light_gray4, bg = colors.dark_gray3 }),
		SignColumn({ fg = colors.dark_gray4 }),
		LineNr({ fg = colors.dark_gray4 }),
		MatchParen({ bg = colors.dark_gray4, gui = "bold" }),
		ModeMsg({ fg = colors.light_green }),
		MoreMsg({ fg = colors.primary }),
		NormalFloat({ bg = colors.dark_gray1 }),
		Pmenu({ bg = colors.dark_gray3 }),
		PmenuSel({ fg = colors.dark_gray3, bg = colors.light_gray2, blend = 0 }),
		PmenuThumb({ bg = colors.dark_gray4 }),
		Question({ fg = colors.primary }),
		QuickFixLine({ fg = colors.primary }),
		Search({ fg = colors.dark_yellow.readable(), bg = colors.dark_yellow }),
		SpecialKey({ fg = colors.dark_gray4 }),
		SpellBad({ sp = colors.light_red, gui = "undercurl" }),
		SpellCap({ sp = colors.yellow, gui = "undercurl" }),
		SpellLocal({ sp = colors.light_green, gui = "undercurl" }),
		SpellRare({ sp = colors.light_blue, gui = "undercurl" }),
		StatusLine({ fg = colors.dark_gray3, bg = colors.light_gray3 }),
		StatusLineNC({ fg = colors.light_gray3, bg = colors.dark_gray3 }),
		Title({ fg = colors.light_gray2, gui = "bold" }),
		Visual({ bg = colors.dark_gray4 }),
		WarningMsg({ fg = colors.yellow }),
		WinBar({ fg = colors.light_gray4, bg = colors.dark_gray1, gui = "bold" }),
		WinBarNC({ fg = colors.light_gray4, bg = colors.dark_gray1 }),

		-- ColorColumn    { }, -- Columns set with 'colorcolumn'
		-- Conceal        { }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
		-- Cursor         { }, -- Character under the cursor
		-- CurSearch      { }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
		-- lCursor        { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
		-- CursorIM       { }, -- Like Cursor, but used when in IME mode |CursorIM|
		-- CursorColumn   { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
		-- CursorLine     { }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
		-- Directory      { }, -- Directory names (and other special names in listings)
		-- DiffAdd        { }, -- Diff mode: Added line |diff.txt|
		-- DiffChange     { }, -- Diff mode: Changed line |diff.txt|
		-- DiffDelete     { }, -- Diff mode: Deleted line |diff.txt|
		-- DiffText       { }, -- Diff mode: Changed text within a changed line |diff.txt|
		-- EndOfBuffer    { }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
		-- TermCursor     { }, -- Cursor in a focused terminal
		-- TermCursorNC   { }, -- Cursor in an unfocused terminal
		-- ErrorMsg       { }, -- Error messages on the command line
		-- VertSplit      { }, -- Column separating vertically split windows
		-- Folded         { }, -- Line used for closed folds
		-- FoldColumn     { }, -- 'foldcolumn'
		-- SignColumn     { }, -- Column where |signs| are displayed
		-- IncSearch      { }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
		-- Substitute     { }, -- |:substitute| replacement text highlighting
		-- LineNr         { }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
		-- LineNrAbove    { }, -- Line number for when the 'relativenumber' option is set, above the cursor line
		-- LineNrBelow    { }, -- Line number for when the 'relativenumber' option is set, below the cursor line
		-- CursorLineNr   { }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
		-- CursorLineFold { }, -- Like FoldColumn when 'cursorline' is set for the cursor line
		-- CursorLineSign { }, -- Like SignColumn when 'cursorline' is set for the cursor line
		-- MatchParen     { }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
		-- ModeMsg        { }, -- 'showmode' message (e.g., "-- INSERT -- ")
		-- MsgArea        { }, -- Area for messages and cmdline
		-- MsgSeparator   { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
		-- MoreMsg        { }, -- |more-prompt|
		-- NonText        { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		-- Normal         { }, -- Normal text
		-- NormalFloat    { }, -- Normal text in floating windows.
		-- FloatBorder    { }, -- Border of floating windows.
		-- FloatTitle     { }, -- Title of floating windows.
		-- NormalNC       { }, -- normal text in non-current windows
		-- Pmenu          { }, -- Popup menu: Normal item.
		-- PmenuSel       { }, -- Popup menu: Selected item.
		-- PmenuKind      { }, -- Popup menu: Normal item "kind"
		-- PmenuKindSel   { }, -- Popup menu: Selected item "kind"
		-- PmenuExtra     { }, -- Popup menu: Normal item "extra text"
		-- PmenuExtraSel  { }, -- Popup menu: Selected item "extra text"
		-- PmenuSbar      { }, -- Popup menu: Scrollbar.
		-- PmenuThumb     { }, -- Popup menu: Thumb of the scrollbar.
		-- Question       { }, -- |hit-enter| prompt and yes/no questions
		-- QuickFixLine   { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		-- Search         { }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
		-- SpecialKey     { }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
		-- SpellBad       { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
		-- SpellCap       { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
		-- SpellLocal     { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
		-- SpellRare      { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
		-- StatusLine     { }, -- Status line of current window
		-- StatusLineNC   { }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
		-- TabLine        { }, -- Tab pages line, not active tab page label
		-- TabLineFill    { }, -- Tab pages line, where there are no labels
		-- TabLineSel     { }, -- Tab pages line, active tab page label
		-- Title          { }, -- Titles for output from ":set all", ":autocmd" etc.
		-- Visual         { }, -- Visual mode selection
		-- VisualNOS      { }, -- Visual mode selection when vim is "Not Owning the Selection".
		-- WarningMsg     { }, -- Warning messages
		-- Whitespace     { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
		-- Winseparator   { }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
		-- WildMenu       { }, -- Current match in 'wildmenu' completion
		-- WinBar         { }, -- Window bar of current window
		-- WinBarNC       { }, -- Window bar of not-current windows

		-- Syntax groups
		Comment({ fg = colors.light_gray4, gui = "italic" }),

		Constant({ fg = colors.light_magenta }),
		String({ fg = colors.light_green }),
		Character({ fg = colors.light_green }),
		Number({ Constant }),
		Boolean({ fg = colors.light_purple }),
		Float({ Number }),

		Identifier({ fg = colors.light_secondary1 }),
		Function({ fg = colors.light_secondary2 }),

		Statement({ fg = colors.light_primary2, gui = "bold" }),
		Operator({ fg = colors.light_primary2 }),
		Keyword({ Statement }),

		PreProc({ fg = colors.primary }),
		Define({ PreProc }),
		Macro({ PreProc }),

		Type({ fg = colors.light_primary1 }),

		Special({ fg = colors.light_blue }),
		SpecialChar({ Special }),
		Delimiter({ fg = colors.white }),

		Error({ fg = colors.red.readable(), bg = colors.red }),
		Todo({ fg = colors.light_gray2, gui = "bold" }),

		-- Comment        { }, -- Any comment

		-- Constant       { }, -- (*) Any constant
		-- String         { }, --   A string constant: "this is a string"
		-- Character      { }, --   A character constant: 'c', '\n'
		-- Number         { }, --   A number constant: 234, 0xff
		-- Boolean        { }, --   A boolean constant: TRUE, false
		-- Float          { }, --   A floating point constant: 2.3e10

		-- Identifier     { }, -- (*) Any variable name
		-- Function       { }, --   Function name (also: methods for classes)

		-- Statement      { }, -- (*) Any statement
		-- Conditional    { }, --   if, then, else, endif, switch, etc.
		-- Repeat         { }, --   for, do, while, etc.
		-- Label          { }, --   case, default, etc.
		-- Operator       { }, --   "sizeof", "+", "*", etc.
		-- Keyword        { }, --   any other keyword
		-- Exception      { }, --   try, catch, throw

		-- PreProc        { }, -- (*) Generic Preprocessor
		-- Include        { }, --   Preprocessor #include
		-- Define         { }, --   Preprocessor #define
		-- Macro          { }, --   Same as Define
		-- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

		-- Type           { }, -- (*) int, long, char, etc.
		-- StorageClass   { }, --   static, register, volatile, etc.
		-- Structure      { }, --   struct, union, enum, etc.
		-- Typedef        { }, --   A typedef

		-- Special        { }, -- (*) Any special symbol
		-- SpecialChar    { }, --   Special character in a constant
		-- Tag            { }, --   You can use CTRL-] on this
		-- Delimiter      { }, --   Character that needs attention
		-- SpecialComment { }, --   Special things inside a comment (e.g. '\n')
		-- Debug          { }, --   Debugging statements

		-- Underlined     { gui = "underline" }, -- Text that stands out, HTML links
		-- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
		-- Error          { }, -- Any erroneous construct
		-- Todo           { }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

		-- Diagnostics
		DiagnosticError({ fg = colors.light_red }),
		DiagnosticWarn({ fg = colors.light_yellow }),
		DiagnosticInfo({ fg = colors.light_blue }),
		DiagnosticHint({ fg = colors.light_purple }),
		DiagnosticOk({ fg = colors.light_green }),
		DiagnosticUnderlineError({ sp = colors.light_red, gui = "underline" }),
		DiagnosticUnderlineWarn({ sp = colors.light_yellow, gui = "underline" }),
		DiagnosticUnderlineInfo({ sp = colors.light_blue, gui = "underline" }),
		DiagnosticUnderlineHint({ sp = colors.light_purple, gui = "underline" }),
		DiagnosticUnderlineOk({ sp = colors.light_green, gui = "underline" }),

		-- DiagnosticError            { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		-- DiagnosticWarn             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		-- DiagnosticInfo             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		-- DiagnosticHint             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		-- DiagnosticOk               { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		-- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
		-- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
		-- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
		-- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
		-- DiagnosticVirtualTextOk    { } , -- Used for "Ok" diagnostic virtual text.
		-- DiagnosticUnderlineError   { } , -- Used to underline "Error" diagnostics.
		-- DiagnosticUnderlineWarn    { } , -- Used to underline "Warn" diagnostics.
		-- DiagnosticUnderlineInfo    { } , -- Used to underline "Info" diagnostics.
		-- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
		-- DiagnosticUnderlineOk      { } , -- Used to underline "Ok" diagnostics.
		-- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
		-- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
		-- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
		-- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
		-- DiagnosticFloatingOk       { } , -- Used to color "Ok" diagnostic messages in diagnostics float.
		-- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
		-- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
		-- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
		-- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.
		-- DiagnosticSignOk           { } , -- Used for "Ok" signs in sign column.

		-- Treesitter
		sym("@variable")({ fg = colors.white }),
		sym("@variable.builtin")({ fg = colors.light_pink }),
		sym("@variable.parameter")({ fg = colors.orange }),
		sym("@variable.parameter.builtin")({ sym("@variable.parameter") }),
		sym("@variable.member")({ fg = colors.light_orange }),

		sym("@constant")({ Constant }),
		sym("@constant.builtin")({ Boolean }),
		sym("@constant.macro")({ Boolean }),

		sym("@module")({ fg = colors.white }),
		sym("@module.builtin")({ fg = colors.white_orange }),
		sym("@label")({ fg = colors.white }),

		sym("@string")({ String }),
		sym("@string.documentation")({ String, gui = "italic" }),
		sym("@string.regexp")({ SpecialChar }),
		sym("@string.escape")({ SpecialChar }),
		sym("@string.special")({ SpecialChar }),
		sym("@string.special.symbol")({ sym("@string.special") }),
		sym("@string.special.path")({ sym("@string.special") }),
		sym("@string.special.url")({ gui = "underline" }),

		sym("@character")({ Character }),
		sym("@character.special")({ sym("@character") }),

		sym("@boolean")({ Boolean }),
		sym("@number")({ Number }),
		sym("@number.float")({ Float }),

		sym("@type")({ Type }),
		sym("@type.builtin")({ sym("@type") }),
		sym("@type.definition")({ fg = colors.green }),

		sym("@attribute")({ sym("@variable") }),
		sym("@attribute.builtin")({ sym("@attribute") }),
		sym("@property")({ sym("@variable") }),

		sym("@function")({ Function }),
		sym("@function.builtin")({ Keyword }),
		sym("@function.call")({ sym("@function") }),
		sym("@function.macro")({ Macro }),
		sym("@function.method")({ sym("@function") }),
		sym("@function.method.call")({ sym("@function.method") }),

		sym("@constructor")({ sym("@function") }),
		sym("@operator")({ Operator }),

		sym("@keyword")({ Keyword }),
		sym("@keyword.coroutine")({ sym("@keyword") }),
		sym("@keyword.function")({ sym("@function") }),
		sym("@keyword.operator")({ sym("@operator") }),
		sym("@keyword.type")({ sym("@keyword") }),
		sym("@keyword.modifier")({ sym("@keyword") }),
		sym("@keyword.repeat")({ sym("@keyword") }),
		sym("@keyword.return")({ sym("@keyword") }),
		sym("@keyword.debug")({ sym("@keyword") }),
		sym("@keyword.exception")({ sym("@keyword") }),
		sym("@keyword.conditional")({ sym("@keyword") }),
		sym("@keyword.conditional.ternary")({ sym("@operator") }),
		sym("@keyword.directive")({ PreProc }),
		sym("@keyword.directive.define")({ Define }),

		sym("@punctuation.delimiter")({ Delimiter }),
		sym("@punctuation.bracket")({ sym("@punctuation.delimiter") }),
		sym("@punctuation.special")({ sym("@punctuation.delimiter") }),

		sym("@comment")({ Comment }),
		sym("@comment.documentation")({ sym("@comment"), gui = "bold" }),
		sym("@comment.error")({ Comment, sp = colors.light_red, gui = "italic,underline" }),
		sym("@comment.warning")({ Comment, sp = colors.light_yellow, gui = "italic,underline" }),
		sym("@comment.todo")({ Comment, sp = colors.light_blue, gui = "bold,italic,underline" }),
		sym("@comment.note")({ sym("@comment.todo"), gui = "italic,underline" }),

		sym("@markup.strong")({ gui = "bold" }),
		sym("@markup.italic")({ gui = "italic" }),
		sym("@markup.strikethrough")({ gui = "strikethrough" }),
		sym("@markup.underline")({ gui = "underline" }),

		sym("@markup.heading")({ Title, gui = "bold,underline" }),
		sym("@markup.heading.1")({ sym("@markup.heading") }),
		sym("@markup.heading.2")({ sym("@markup.heading"), gui = "bold" }),
		sym("@markup.heading.3")({ sym("@markup.heading"), gui = "underline" }),
		sym("@markup.heading.4")({ sym("@markup.heading"), gui = "italic,underline" }),
		sym("@markup.heading.5")({ sym("@markup.heading"), gui = "italic" }),
		sym("@markup.heading.6")({ sym("@markup.heading"), gui = "" }),

		sym("@markup.quote")({ sym("@variable") }),
		sym("@markup.math")({ String }),

		sym("@markup.link")({ Special }),
		sym("@markup.link.label")({ Title, gui = "" }),
		sym("@markup.link.url")({ sym("@markup.link"), gui = "underline" }),

		sym("@markup.raw")({ sym("@comment"), gui = "" }),
		sym("@markup.raw.block")({ sym("@markup.raw") }),

		sym("@markup.list")({ sym("@variable") }),
		sym("@markup.list.checked")({ sym("@markup.list"), gui = "strikethrough" }),
		sym("@markup.list.unchecked")({ sym("@markup.list") }),

		sym("@diff.plus")({ DiffAdd }),
		sym("@diff.minus")({ DiffDelete }),
		sym("@diff.delta")({ DiffChange }),

		sym("@tag")({ Constant }),
		sym("@tag.builtin")({ sym("@tag") }),
		sym("@tag.attribute")({ sym("@label") }),
		sym("@tag.delimiter")({ Delimiter }),
	}
end)

return theme
