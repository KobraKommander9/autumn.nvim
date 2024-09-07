local function format_color(color)
  local formatted = vim.deepcopy(color)
  formatted.force = true
  
  for _, attr in ipairs({ "fg", "bg", "sp" }) do
    if formatted[attr] then
      formatted[attr] = tostring(formatted[attr])
    end
  end

  return formatted
end

-------------------------------------------------------------------------------
-- Theme class

local Theme = setmetatable({}, {
	__index = function(t, key)
		if t[key] then
			return t[key]
		end
		return vim.api.nvim_get_hl(0, { name = key })
	end,
})

function Theme:new()
	local theme = {}
	setmetatable(theme, self)
	self.__index = self
	return theme
end

function Theme:extend(key, attrs)
	return vim.tbl_deep_extend("force", self[key], attrs)
end

function Theme:apply()
	vim.cmd("hi clear")
	vim.cmd("syntax reset")

	for group, attrs in pairs(self) do
		vim.api.nvim_set_hl(0, group, format_color(attrs))
	end
end

-------------------------------------------------------------------------------
-- Autumn Theme

local autumn = {}

function autumn.build(palette)
	vim.o.termguicolors = true
	vim.g.colors_name = "autumn"

	local theme = Theme:new()

	autumn.build_basic_groups(theme, palette)
	autumn.build_syntax_groups(theme, palette)
	autumn.build_diagnostic_groups(theme, palette)
	autumn.build_treesitter_groups(theme, palette)

	return theme
end

function autumn.build_basic_groups(theme, p)
	theme.NonText = { fg = p.dark_gray4 }
	theme.Normal = { fg = p.light_gray2, bg = p.dark_gray2 }

	theme.ColorColumn = { bg = p.dark_gray4 }
	theme.Conceal = { link = "NonText" }
	theme.CurSearch = { fg = p.white_yellow.readable(), bg = p.white_yellow }
	theme.CursorColumn = { bg = p.dark_gray3 }
	theme.CursorLine = { link = "CursorColumn" }
	theme.Directory = { fg = p.primary }
	theme.DiffAdd = { fg = p.green.readable(), bg = p.green }
	theme.DiffChange = { fg = p.light_gray1, bg = p.dark_gray4 }
	theme.DiffDelete = { fg = p.light_red, bold = true }
	theme.DiffText = { fg = p.light_blue.readable(), bg = p.light_blue }
	theme.ErrorMsg = { fg = p.light_red }
	theme.Folded = { fg = p.light_gray4, bg = p.dark_gray3 }
	theme.LineNr = { fg = p.dark_gray4 }
	theme.MatchParen = { bg = p.dark_gray4, bold = true }
	theme.ModeMsg = { fg = p.light_green }
	theme.MoreMsg = { fg = p.primary }
	theme.NormalFloat = { bg = p.dark_gray1 }
	theme.Pmenu = { bg = p.dark_gray3 }
	theme.PmenuSel = { fg = p.dark_gray3, bg = p.light_gray2, blend = 0 }
	theme.PmenuThumb = { bg = p.dark_gray4 }
	theme.Question = { fg = p.primary }
	theme.QuickFixLine = { fg = p.primary }
	theme.Search = { fg = p.dark_yellow.readable(), bg = p.dark_yellow }
	theme.SignColumn = { fg = p.dark_gray4 }
	theme.SpecialKey = { fg = p.dark_gray4 }
	theme.SpellBad = { sp = p.light_red, undercurl = true }
	theme.SpellCap = { sp = p.yellow, undercurl = true }
	theme.SpellLocal = { sp = p.light_green, undercurl = true }
	theme.SpellRare = { sp = p.light_blue, undercurl = true }
	theme.StatusLine = { fg = p.dark_gray3, bg = p.light_gray3 }
	theme.StatusLineNC = { fg = p.light_gray3, bg = p.dark_gray3 }
	theme.Title = { fg = p.light_gray2, bold = true }
	theme.Visual = { bg = p.dark_gray4 }
	theme.WarningMsg = { fg = p.yellow }
	theme.WinBar = { fg = p.light_gray4, bg = p.dark_gray1, bold = true }
	theme.WinBarNC = { fg = p.light_gray4, bg = p.dark_gray1 }
end

function autumn.build_syntax_groups(theme, p)
	theme.Comment = { fg = p.light_gray4, italic = true }

	theme.Constant = { fg = p.light_magenta }
	theme.String = { fg = p.light_green }
	theme.Character = { fg = p.light_green }
	theme.Number = { link = "Constant" }
	theme.Boolean = { fg = p.light_purple }
	theme.Float = { link = "Number" }

	theme.Identifier = { fg = p.light_secondary1 }
	theme.Function = { fg = p.light_secondary2 }

	theme.Statement = { fg = p.light_primary2, bold = true }
	theme.Operator = { fg = p.light_primary2 }
	theme.Keyword = { link = "Statement" }

	theme.PreProc = { fg = p.primary }
	theme.Define = { link = "PreProc" }
	theme.Macro = { link = "PreProc" }

	theme.Type = { fg = p.light_primary1 }

	theme.Special = { fg = p.light_blue }
	theme.SpecialChar = { link = "Special" }
	theme.Delimiter = { fg = p.white }

	theme.Error = { fg = p.red.readable(), bg = p.red }
	theme.Todo = { fg = p.light_gray2, bold = true }
end

function autumn.build_diagnostic_groups(theme, p)
	theme.DiagnosticError = { fg = p.light_red }
	theme.DiagnosticWarn = { fg = p.light_yellow }
	theme.DiagnosticInfo = { fg = p.light_blue }
	theme.DiagnosticHint = { fg = p.light_purple }
	theme.DiagnosticOk = { fg = p.light_green }
	theme.DiagnosticUnderlineError = { sp = p.light_red, underline = true }
	theme.DiagnosticUnderlineWarn = { sp = p.light_yellow, underline = true }
	theme.DiagnosticUnderlineInfo = { sp = p.light_blue, underline = true }
	theme.DiagnosticUnderlineHint = { sp = p.light_purple, underline = true }
	theme.DiagnosticUnderlineOk = { sp = p.light_green, underline = true }
end

function autumn.build_treesitter_groups(theme, p)
	theme["@variable"] = { fg = p.white }
	theme["@variable.builtin"] = { fg = p.light_pink }
	theme["@variable.parameter"] = { fg = p.orange }
	theme["@variable.parameter.builtin"] = { link = "@variable.parameter" }
	theme["@variable.member"] = { fg = p.light_orange }

	theme["@constant"] = { link = "Constant" }
	theme["@constant.builtin"] = { link = "Boolean" }
	theme["@constant.macro"] = { link = "Boolean" }

	theme["@module"] = { fg = p.white }
	theme["@module.builtin"] = { fg = p.white_orange }
	theme["@label"] = { fg = p.white }

	theme["@string"] = { link = "String" }
	theme["@string.documentation"] = theme:extend("String", { italic = true })
	theme["@string.regexp"] = { link = "SpecialChar" }
	theme["@string.escape"] = { link = "SpecialChar" }
	theme["@string.special"] = { link = "SpecialChar" }
	theme["@string.special.symbol"] = { link = "@string.special" }
	theme["@string.special.path"] = { link = "@string.special" }
	theme["@string.special.url"] = { underline = true }

	theme["@character"] = { link = "Character" }
	theme["@character.special"] = { link = "@character" }

	theme["@boolean"] = { link = "Boolean" }
	theme["@number"] = { link = "Number" }
	theme["@number.float"] = { link = "Float" }

	theme["@type"] = { link = "Type" }
	theme["@type.builtin"] = { link = "@type" }
	theme["@type.definition"] = { fg = p.green }

	theme["@attribute"] = { link = "@variable" }
	theme["@attribute.builtin"] = { link = "@attribute" }
	theme["@property"] = { link = "@variable" }

	theme["@function"] = { link = "Function" }
	theme["@function.builtin"] = { link = "Keyword" }
	theme["@function.call"] = { link = "@function" }
	theme["@function.macro"] = { link = "Macro" }
	theme["@function.method"] = { link = "@function" }
	theme["@function.method.call"] = { link = "@function.method" }

	theme["@constructor"] = { link = "@function" }
	theme["@operator"] = { link = "Operator" }

	theme["@keyword"] = { link = "Keyword" }
	theme["@keyword.coroutine"] = { link = "@keyword" }
	theme["@keyword.function"] = { link = "@function" }
	theme["@keyword.operator"] = { link = "@operator" }
	theme["@keyword.type"] = { link = "@keyword" }
	theme["@keyword.modifier"] = { link = "@keyword" }
	theme["@keyword.repeat"] = { link = "@keyword" }
	theme["@keyword.return"] = { link = "@keyword" }
	theme["@keyword.debug"] = { link = "@keyword" }
	theme["@keyword.exception"] = { link = "@keyword" }
	theme["@keyword.conditional"] = { link = "@keyword" }
	theme["@keyword.conditional.ternary"] = { link = "@operator" }
	theme["@keyword.directive"] = { link = "PreProc" }
	theme["@keyword.directive.define"] = { link = "Define" }

	theme["@punctuation.delimiter"] = { link = "Delimiter" }
	theme["@punctuation.bracket"] = { link = "@punctuation.delimiter" }
	theme["@punctuation.special"] = { link = "@punctuation.delimiter" }

	theme["@comment"] = { link = "Comment" }
	theme["@comment.documentation"] = theme:extend("@comment", { bold = true })
	theme["@comment.error"] = theme:extend("Comment", { sp = p.light_red, italic = true, underline = true })
	theme["@comment.warning"] = theme:extend("Comment", { sp = p.light_yellow, italic = true, underline = true })
	theme["@comment.todo"] = theme:extend("Comment", { sp = p.light_blue, bold = true, italic = true, underline = true })
	theme["@comment.note"] = theme:extend("@comment.todo", { italic = true, underline = true })

	theme["@markup.strong"] = { bold = true }
	theme["@markup.italic"] = { italic = true }
	theme["@markup.strikethrough"] = { strikethrough = true }
	theme["@markup.underline"] = { underline = true }

	theme["@markup.heading"] = theme:extend("Title", { bold = true, underline = true })
	theme["@markup.heading.1"] = { link = "@markup.heading" }
	theme["@markup.heading.2"] = theme:extend("@markup.heading", { bold = true })
	theme["@markup.heading.3"] = theme:extend("@markup.heading", { underline = true })
	theme["@markup.heading.4"] = theme:extend("@markup.heading", { italic = true, underline = true })
	theme["@markup.heading.5"] = theme:extend("@markup.heading", { italic = true })
	theme["@markup.heading.6"] = theme:extend("@markup.heading", {})

	theme["@markup.quote"] = { link = "@variable" }
	theme["@markup.math"] = { link = "String" }

	theme["@markup.link"] = { link = "Special" }
	theme["@markup.link.label"] = theme:extend("Title", {})
	theme["@markup.link.url"] = theme:extend("@markup.link", { underline = true })

	theme["@markup.raw"] = theme:extend("@comment", {})
	theme["@markup.raw.block"] = { link = "@markup.raw" }

	theme["@markup.list"] = { link = "@variable" }
	theme["@markup.list.checked"] = theme:extend("@markup.list", { strikethrough = true })
	theme["@markup.list.unchecked"] = { link = "@markup.list" }

	theme["@diff.plus"] = { link = "DiffAdd" }
	theme["@diff.minus"] = { link = "DiffDelete" }
	theme["@diff.delta"] = { link = "DiffChange" }

	theme["@tag"] = { link = "Constant" }
	theme["@tag.builtin"] = { link = "@tag" }
	theme["@tag.attribute"] = { link = "@label" }
	theme["@tag.delimiter"] = { link = "Delimiter" }
end

-------------------------------------------------------------------------------

local M = {}

local function get_bg(color)
	return M.config.transparent and "NONE" or color
end

function M.build(config)
	local palette = require("autumn.palette").get(config.palette)
	local theme = autumn.build(palette)

	if config.transparency.enabled == true then
		local transparent_groups = config.transparency.groups or {}
		for _, group in ipairs(transparent_groups) do
			theme[group].bg = get_bg(theme[group].bg)
		end
	end

	theme:apply()
end

return M
