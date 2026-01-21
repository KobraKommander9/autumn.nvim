local M = {}

function M.get(roles, _)
	local p = roles.palette

	return {
		-- Comments
		Comment = roles.syntax.comment,
		SpecialComment = { link = "Special" },

		-- Constents
		Boolean = roles.syntax.boolean,
		Character = { link = "String" },
		Constant = roles.syntax.constant,
		Float = { link = "Number" },
		Number = roles.syntax.number,
		String = roles.syntax.string,

		-- Identifiers
		Function = roles.syntax.func,
		Identifier = roles.syntax.ident,

		-- Keywords / statements
		Conditional = roles.syntax.control,
		Exception = { link = "Conditional" },
		Keyword = roles.syntax.keyword,
		Label = { link = "Keyword" },
		Repeat = { link = "Conditional" },
		Statement = roles.syntax.statement,

		-- Operators / Preprocessor
		Define = { link = "PreProc" },
		Include = { link = "PreProc" },
		Macro = { link = "PreProc" },
		Operator = roles.syntax.operator,
		PreCondit = { link = "PreProc" },
		PreProc = roles.syntax.preproc,

		-- Types / Storage
		StorageClass = { link = "Type" },
		Structure = { link = "Type" },
		Type = roles.syntax.type,
		Typedef = { link = "Type" },

		-- Special Symbols
		Debug = { link = "Special" },
		Delimiter = { link = "Special" },
		Special = roles.syntax.builtin_func,
		SpecialChar = { link = "Special" },
		Tag = { link = "Special" },

		-- Text decoration
		Bold = roles.markup.bold,
		Italic = roles.markup.italic,
		Underlined = roles.markup.underlined,

		-- Diagnostics
		Error = roles.semantic.error,
		Todo = roles.semantic.info,

		-- QuickFix
		qfLineNr = { fg = roles.ui.gutter.fg },
		qfFileName = { fg = roles.syntax.func.fg },
		qfSeparator = { fg = roles.ui.fg.subtle },

		-- Diff
		diffAdded = roles.semantic.success,
		diffChanged = roles.semantic.changed,
		diffFile = { fg = p.blue.base },
		diffIndexLine = { fg = p.magenta.base },
		diffLine = { fg = p.purple.base },
		diffNewFile = { fg = p.green.dim },
		diffOldFile = { fg = p.yellow.dim },
		diffRemoved = roles.semantic.deleted,
	}
end

return M
