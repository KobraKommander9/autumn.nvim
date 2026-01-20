local M = {}

function M.get(spec, config)
	local diag = spec.diag
	local git = spec.git
	local syn = spec.syntax
	local stl = config.styles

	return {
		-- Comments
		Comment = { fg = syn.comment, style = stl.comments },
		SpecialComment = { link = "Special" },

		-- Constents
		Boolean = { link = "Number" },
		Character = { link = "String" },
		Constant = { fg = syn.const, style = stl.constants },
		Float = { link = "Number" },
		Number = { fg = syn.number, style = stl.numbers },
		String = { fg = syn.string, style = stl.strings },

		-- Identifiers
		Function = { fg = syn.func, style = stl.functions },
		Identifier = { fg = syn.ident, style = stl.variables },

		-- Keywords / statements
		Conditional = { fg = syn.conditional, style = stl.conditionals },
		Exception = { link = "Keyword" },
		Keyword = { fg = syn.keyword, style = stl.keywords },
		Label = { link = "Conditional" },
		Repeat = { link = "Conditional" },
		Statement = { fg = syn.statement, style = stl.statements },

		-- Operators / Preprocessor
		Define = { link = "PreProc" },
		Include = { link = "PreProc" },
		Macro = { link = "PreProc" },
		Operator = { fg = syn.operator, style = stl.operators },
		PreCondit = { link = "PreProc" },
		PreProc = { fg = syn.preproc, style = stl.preprocs },

		-- Types / Storage
		StorageClass = { link = "Type" },
		Structure = { link = "Type" },
		Type = { fg = syn.type, style = stl.types },
		Typedef = { link = "Type" },

		-- Special Symbols
		Debug = { link = "Special" },
		Delimiter = { link = "Special" },
		Special = { fg = syn.func },
		SpecialChar = { link = "Special" },
		Tag = { link = "Special" },

		-- Text decoration
		Bold = { style = "bold" },
		Italic = { style = "italic" },
		Underlined = { style = stl.links },

		-- Diagnostics
		Error = { fg = diag.error, style = stl.diagnostics },
		Todo = { fg = syn.variable, bg = diag.info, style = stl.diagnostics },

		-- QuickFix
		qfLineNr = { fg = syn.number },
		qfFileName = { fg = syn.type },

		-- Diff
		diffAdded = { fg = git.added },
		diffChanged = { fg = git.changed },
		diffFile = { fg = diag.info },
		diffIndexLine = { fg = syn.preproc },
		diffLine = { fg = syn.builtin2 },
		diffNewFile = { fg = diag.hint },
		diffOldFile = { fg = diag.warn },
		diffRemoved = { fg = git.removed },
	}
end

return M
