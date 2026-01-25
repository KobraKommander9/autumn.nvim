local M = {}

function M.get(roles, _)
	local diff = roles.diff
	local sem = roles.semantic
	local syn = roles.syntax
	local ui = roles.ui

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
		Error = sem.error,
		Todo = sem.info,

		-- QuickFix
		qfLineNr = { fg = ui.gutter.fg },
		qfFileName = { fg = syn.func.fg },
		qfSeparator = { fg = ui.fg.subtle },

		-- Diff
		Added = diff.added,
		Changed = diff.changed,
		Removed = diff.removed,

		diffAdded = { link = "Added" },
		diffChanged = { link = "Changed" },
		diffRemoved = { link = "Removed" },

		diffFile = diff.header,
		diffIndexLine = diff.meta,
		diffLine = diff.fragment,
		diffNewFile = diff.new_file,
		diffOldFile = diff.old_file,
	}
end

return M
