local M = {}

function M.get(roles, _)
	local p = roles.palette
	local syn = roles.syntax

	return {
		-- Comments
		Comment = syn.comment,
		SpecialComment = { link = "Special" },

		-- Constents
		Boolean = syn.boolean,
		Character = { link = "String" },
		Constant = syn.constant,
		Float = { link = "Number" },
		Number = syn.number,
		String = syn.string,

		-- Identifiers
		Function = syn.func,
		Identifier = syn.ident,

		-- Keywords / statements
		Conditional = syn.control,
		Exception = { link = "Conditional" },
		Keyword = syn.keyword,
		Label = { link = "Keyword" },
		Repeat = { link = "Conditional" },
		Statement = syn.statement,

		-- Operators / Preprocessor
		Define = { link = "PreProc" },
		Include = { link = "PreProc" },
		Macro = { link = "PreProc" },
		Operator = syn.operator,
		PreCondit = { link = "PreProc" },
		PreProc = syn.preproc,

		-- Types / Storage
		StorageClass = { link = "Type" },
		Structure = { link = "Type" },
		Type = syn.type,
		Typedef = { link = "Type" },

		-- Special Symbols
		Debug = { link = "Special" },
		Delimiter = { link = "Special" },
		Special = syn.builtin_func,
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
		qfFileName = { fg = syn.func.fg },
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
