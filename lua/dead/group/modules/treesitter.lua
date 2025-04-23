local M = {}

local defaults = {
	styles = {
		checked_lists = "strikethrough",
	},
}

function M.get(spec, config, opts)
	opts = vim.tbl_deep_extend("force", defaults, opts or {})

	local op_stl = opts.styles

	local diag = spec.diag
	local syn = spec.syntax
	local stl = config.styles

	return {
		-- Identitifiers ------------------------------------------------------------
		["@variable"] = { fg = syn.variable, style = stl.variables },
		["@variable.builtin"] = { fg = syn.builtin0, style = stl.variables },
		["@variable.parameter"] = { fg = syn.builtin1, style = stl.variables },
		["@variable.parameter.builtin"] = { link = "@variable.parameter" },
		["@variable.member"] = { fg = syn.field },

		["@constant"] = { link = "Constant" },
		["@constant.builtin"] = { fg = syn.builtin2, style = stl.keywords },
		["@constant.macro"] = { link = "Macro" },

		["@module"] = { fg = syn.bulitin1 },
		["@module.builtin"] = { fg = syn.builtin1 },
		["@label"] = { link = "Label" },

		-- Literals -----------------------------------------------------------------
		["@string"] = { link = "String" },
		["@string.documentation"] = { fg = syn.string, style = stl.documentation },
		["@string.regexp"] = { fg = syn.regex, style = stl.strings },
		["@string.escape"] = { fg = syn.regex, style = "bold" },
		["@string.special"] = { link = "Special" },
		["@string.special.path"] = { link = "@string.special" },
		["@string.special.symbol"] = { link = "@string.special" },
		["@string.special.url"] = { fg = syn.const, style = stl.links },

		["@character"] = { link = "Character" },
		["@character.special"] = { link = "SpecialChar" },

		["@boolean"] = { link = "Boolean" },
		["@number"] = { link = "Number" },
		["@number.float"] = { link = "Float" },

		-- Types --------------------------------------------------------------------
		["@type"] = { link = "Type" },
		["@type.builtin"] = { fg = syn.builtin1, style = stl.types },
		["@type.definition"] = { fg = syn.builtin3, style = stl.types },
		["@type.qualifier"] = { link = "@type" },

		["@attribute"] = { link = "Constant" },
		["@attribute.builtin"] = { link = "@attribute" },
		["@property"] = { fg = syn.field },

		-- Functions ----------------------------------------------------------------
		["@function"] = { link = "Function" },
		["@function.builtin"] = { fg = syn.builtin0, style = stl.functions },
		["@function.call"] = { link = "@function" },
		["@function.macro"] = { fg = syn.builtin0, style = stl.functions },
		["@function.method"] = { link = "@function" },
		["@function.method.call"] = { link = "@function.method" },

		["@constructor"] = { fg = syn.ident },
		["@operator"] = { fg = syn.ident },

		-- Keywords -----------------------------------------------------------------
		["@keyword"] = { link = "Keyword" },
		["@keyword.conditional"] = { link = "Conditional" },
		["@keyword.conditional.ternary"] = { link = "@keyword.conditional" },
		["@keyword.coroutine"] = { link = "@keyword" },
		["@keyword.debug"] = { link = "@keyword" },
		["@keyword.directive"] = { link = "PreProc" },
		["@keyword.directive.define"] = { link = "Define" },
		["@keyword.exception"] = { link = "Exception" },
		["@keyword.function"] = { fg = syn.keyword, style = stl.functions },
		["@keyword.import"] = { link = "Include" },
		["@keyword.modifier"] = { link = "@keyword" },
		["@keyword.operator"] = { fg = syn.operator, style = stl.operators },
		["@keyword.repeat"] = { link = "Repeat" },
		["@keyword.return"] = { fg = syn.builtin0, style = stl.keywords },
		["@keyword.storage"] = { link = "StorageClass" },
		["@keyword.type"] = { link = "@keyword" },

		-- Punctuation --------------------------------------------------------------
		["@punctuation.delimiter"] = { fg = syn.bracket },
		["@punctuation.bracket"] = { fg = syn.bracket },
		["@punctuation.special"] = { fg = syn.builtin1, style = stl.operators },

		-- Comments -----------------------------------------------------------------
		["@comment"] = { link = "Comment" },
		["@comment.documentation"] = { fg = syn.comment, style = stl.documentation },

		["@comment.error"] = { fg = spec.bg1, bg = diag.error, style = stl.diagnostics },
		["@comment.warning"] = { fg = spec.bg1, bg = diag.warn, style = stl.diagnostics },
		["@comment.todo"] = { fg = spec.bg1, bg = diag.info, style = stl.diagnostics },
		["@comment.note"] = { fg = spec.bg1, bg = diag.hint, style = stl.diagnostics },

		-- Markup -------------------------------------------------------------------
		["@markup"] = { fg = spec.fg1 },
		["@markup.strong"] = { style = "bold" },
		["@markup.italic"] = { style = "italic" },
		["@markup.strikethrough"] = { style = "strikethrough" },
		["@markup.underline"] = { style = "underline" },

		["@markup.heading"] = { fg = syn.func, style = "bold,underline" },
		["@markup.heading.1"] = { link = "@markup.heading" },
		["@markup.heading.2"] = { fg = syn.func, style = "bold" },
		["@markup.heading.3"] = { fg = syn.func, style = "bold,italic" },
		["@markup.heading.4"] = { fg = syn.func, style = "italic,underline" },
		["@markup.heading.5"] = { fg = syn.func, style = "italic" },
		["@markup.heading.6"] = { fg = syn.func, style = "underline" },

		["@markup.quote"] = { link = "@variable" },
		["@markup.math"] = { link = "@string" },

		["@markup.link"] = { fg = syn.keyword, style = "bold" },
		["@markup.link.label"] = { link = "Special" },
		["@markup.link.url"] = { fg = syn.const, style = stl.links },

		["@markup.raw"] = { fg = syn.ident, style = "italic" },
		["@markup.raw.block"] = { link = "@markup.raw" },

		["@markup.list"] = { fg = syn.builtin1, style = stl.operators },
		["@markup.list.checked"] = { fg = syn.builtin1, style = op_stl.checked_lists },
		["@markup.list.unchecked"] = { link = "@markup.list" },

		["@diff.plus"] = { link = "diffAdded" },
		["@diff.minus"] = { link = "diffRemoved" },
		["@diff.delta"] = { link = "diffChanged" },

		["@tag"] = { fg = syn.keyword },
		["@tag.attribute"] = { fg = syn.func, style = "italic" },
		["@tag.delimiter"] = { fg = syn.builtin1 },

		-- LSP ----------------------------------------------------------------------
		["@lsp.type.enum"] = { link = "@type" },
		["@lsp.type.variable"] = { link = "Identifier" },
		["@lsp.type.parameter"] = { link = "@variable.parameter" },
		["@lsp.type.namespace"] = { link = "@type.builtin" },
		["@lsp.typemod.type.defaultLibrary"] = { link = "@type.builtin" },
		["@lsp.typemod.function.defaultLibrary"] = { link = "@function" },

		-- Language specific --------------------------------------------------------
		-- json
		["@label.json"] = { fg = syn.func },

		-- lua
		["@constructor.lua"] = { fg = spec.fg2 },

		-- yaml
		["@variable.member.yaml"] = { fg = syn.func },

		-- Legacy -------------------------------------------------------------------
		["@parameter"] = { link = "@variable.parameter" },
		["@field"] = { link = "@variable.member" },
		["@namespace"] = { link = "@module" },
		["@float"] = { link = "@number.float" },
		["@symbol"] = { link = "@string.special.symbol" },
		["@string.regex"] = { link = "@string.regexp" },

		["@text"] = { link = "@markup" },
		["@text.strong"] = { link = "@markup.strong" },
		["@text.emphasis"] = { link = "@markup.italic" },
		["@text.underline"] = { link = "@markup.underline" },
		["@text.strike"] = { link = "@markup.strikethrough" },
		["@text.uri"] = { link = "@markup.link.url" },
		["@text.math"] = { link = "@markup.math" },
		["@text.environment"] = { link = "@markup.environment" },
		["@text.environment.name"] = { link = "@markup.environment.name" },

		["@text.title"] = { link = "@markup.heading" },
		["@text.literal"] = { link = "@markup.raw" },
		["@text.reference"] = { link = "@markup.link" },

		["@text.todo.checked"] = { link = "@markup.list.checked" },
		["@text.todo.unchecked"] = { link = "@markup.list.unchecked" },

		["@text.todo"] = { link = "@comment.todo" },
		["@text.warning"] = { link = "@comment.warning" },
		["@text.note"] = { link = "@comment.note" },
		["@text.danger"] = { link = "@comment.error" },

		["@method"] = { link = "@function.method" },
		["@method.call"] = { link = "@function.method.call" },

		["@text.diff.add"] = { link = "@diff.plus" },
		["@text.diff.delete"] = { link = "@diff.minus" },

		["@define"] = { link = "@keyword.directive.define" },
		["@preproc"] = { link = "@keyword.directive" },
		["@storageclass"] = { link = "@keyword.storage" },
		["@conditional"] = { link = "@keyword.conditional" },
		["@exception"] = { link = "@keyword.exception" },
		["@include"] = { link = "@keyword.import" },
		["@repeat"] = { link = "@keyword.repeat" },

		["@text.title.1.markdown"] = { link = "@markup.heading.1" },
		["@text.title.2.markdown"] = { link = "@markup.heading.2" },
		["@text.title.3.markdown"] = { link = "@markup.heading.3" },
		["@text.title.4.markdown"] = { link = "@markup.heading.4" },
		["@text.title.5.markdown"] = { link = "@markup.heading.5" },
		["@text.title.6.markdown"] = { link = "@markup.heading.6" },
	}
end

return M
