local M = {}

function M.get(roles, _, _)
	local syn = roles.syntax
	local ui = roles.ui
	local sem = roles.semantic

	local hl = {
		-- Identifiers ------------------------------------------------------------
		["@variable"] = syn.variable,
		["@variable.builtin"] = syn.builtin_var,
		["@variable.parameter"] = syn.param,
		["@variable.member"] = syn.field,

		["@constant"] = { link = "Constant" },
		["@constant.builtin"] = { link = "Constant" },
		["@constant.macro"] = { link = "PreProc" },

		["@module"] = syn.module,
		["@module.builtin"] = syn.builtin_var,
		["@label"] = { link = "Label" },

		-- Literals ---------------------------------------------------------------
		["@string"] = { link = "String" },
		["@string.documentation"] = roles.info.documentation,
		["@string.regexp"] = syn.regex,
		["@string.escape"] = { fg = syn.regex.fg, style = "bold" },
		["@string.special"] = { link = "Special" },
		["@string.special.symbol"] = { link = "Constant" },
		["@string.special.url"] = roles.markup.link,
		["@string.special.path"] = syn.string_sp,

		["@character"] = { link = "Character" },
		["@character.special"] = { link = "SpecialChar" },

		["@boolean"] = { link = "Boolean" },
		["@number"] = { link = "Number" },
		["@number.float"] = { link = "Float" },

		-- Types ------------------------------------------------------------------
		["@type"] = { link = "Type" },
		["@type.builtin"] = syn.builtin_type,
		["@type.definition"] = syn.interface,
		["@type.qualifier"] = { link = "Keyword" },

		["@attribute"] = { link = "Constant" },
		["@property"] = syn.field,

		-- Functions --------------------------------------------------------------
		["@function"] = { link = "Function" },
		["@function.builtin"] = syn.builtin_func,
		["@function.call"] = { link = "@function" },
		["@function.macro"] = syn.preproc,

		["@function.method"] = { link = "@function" },
		["@function.method.call"] = { link = "@function" },

		["@constructor"] = syn.func,
		["@operator"] = { link = "Operator" },

		-- Keywords ---------------------------------------------------------------
		["@keyword"] = { link = "Keyword" },
		["@keyword.coroutine"] = { link = "Conditional" },
		["@keyword.function"] = { link = "Keyword" },
		["@keyword.operator"] = { link = "Operator" },
		["@keyword.import"] = { link = "Keyword" },
		["@keyword.storage"] = { link = "StorageClass" },
		["@keyword.repeat"] = { link = "Repeat" },
		["@keyword.return"] = { link = "Conditional" },
		["@keyword.debug"] = roles.emphasis.high,
		["@keyword.exception"] = { link = "Exception" },

		["@keyword.conditional"] = { link = "Conditional" },
		["@keyword.conditional.ternary"] = { link = "Operator" },

		["@keyword.directive"] = { link = "PreProc" },
		["@keyword.directive.define"] = { link = "PreProc" },

		-- Punctuation ------------------------------------------------------------
		["@punctuation.delimiter"] = syn.punctuation,
		["@punctuation.bracket"] = syn.bracket,
		["@punctuation.special"] = syn.operator,

		-- Comments ---------------------------------------------------------------
		["@comment"] = { link = "Comment" },
		["@comment.documentation"] = roles.info.documentation,

		["@comment.error"] = { fg = ui.bg.main, bg = sem.error.fg },
		["@comment.warning"] = { fg = ui.bg.main, bg = sem.warn.fg },
		["@comment.todo"] = { fg = ui.bg.main, bg = sem.hint.fg },
		["@comment.note"] = { fg = ui.bg.main, bg = sem.info.fg },

		-- Markup -----------------------------------------------------------------
		["@markup"] = { fg = ui.fg.main },
		["@markup.strong"] = roles.markup.bold,
		["@markup.italic"] = roles.markup.italic,
		["@markup.strikethrough"] = syn.deprecated,
		["@markup.underline"] = { style = "underline" },

		["@markup.heading"] = roles.markup.heading,

		["@markup.quote"] = roles.markup.quote,
		["@markup.math"] = syn.func,
		["@markup.environment"] = syn.preproc,

		["@markup.link"] = roles.markup.link,
		["@markup.link.label"] = { link = "Special" },
		["@markup.link.url"] = roles.markup.link,

		["@markup.raw"] = roles.markup.raw,
		["@markup.raw.block"] = { fg = ui.fg.main },

		["@markup.list"] = syn.punctuation,
		["@markup.list.checked"] = { fg = sem.added.fg },
		["@markup.list.unchecked"] = { fg = sem.warn.fg },

		["@diff.plus"] = { link = "diffAdded" },
		["@diff.minus"] = { link = "diffRemoved" },
		["@diff.delta"] = { link = "diffChanged" },

		["@tag"] = syn.keyword,
		["@tag.attribute"] = syn.field,
		["@tag.delimiter"] = syn.punctuation,

		-- Misc -------------------------------------------------------------------
		-- ["@none"] = { }, -- completely disable the highlight
		-- ["@conceal"] = { }, -- captures that are only meant to be concealed

		-- ["@spell"] = { }, -- for defining regions to be spellchecked
		-- ["@nospell"] = { }, -- for defining regions that should NOT be spellchecked
	}

	-- Legacy highlights
	hl["@parameter"] = hl["@variable.parameter"]
	hl["@field"] = hl["@variable.member"]
	hl["@namespace"] = hl["@module"]
	hl["@float"] = hl["@number.float"]
	hl["@symbol"] = hl["@string.special.symbol"]
	hl["@string.regex"] = hl["@string.regexp"]

	hl["@text"] = hl["@markup"]
	hl["@text.strong"] = hl["@markup.strong"]
	hl["@text.emphasis"] = hl["@markup.italic"]
	hl["@text.underline"] = hl["@markup.underline"]
	hl["@text.strike"] = hl["@markup.strikethrough"]
	hl["@text.uri"] = hl["@markup.link.url"]
	hl["@text.math"] = hl["@markup.math"]
	hl["@text.environment"] = hl["@markup.environment"]
	hl["@text.environment.name"] = hl["@markup.environment.name"]

	hl["@text.title"] = hl["@markup.heading"]
	hl["@text.literal"] = hl["@markup.raw"]
	hl["@text.reference"] = hl["@markup.link"]

	hl["@text.todo.checked"] = hl["@markup.list.checked"]
	hl["@text.todo.unchecked"] = hl["@markup.list.unchecked"]

	-- @text.todo is now for todo comments, not todo notes like in markdown
	hl["@text.todo"] = hl["@comment.todo"]
	hl["@text.warning"] = hl["@comment.warning"]
	hl["@text.note"] = hl["@comment.note"]
	hl["@text.danger"] = hl["@comment.error"]

	hl["@method"] = hl["@function.method"]
	hl["@method.call"] = hl["@function.method.call"]

	hl["@text.diff.add"] = hl["@diff.plus"]
	hl["@text.diff.delete"] = hl["@diff.minus"]

	hl["@define"] = hl["@keyword.directive.define"]
	hl["@preproc"] = hl["@keyword.directive"]
	hl["@storageclass"] = hl["@keyword.storage"]
	hl["@conditional"] = hl["@keyword.conditional"]
	hl["@exception"] = hl["@keyword.exception"]
	hl["@include"] = hl["@keyword.import"]
	hl["@repeat"] = hl["@keyword.repeat"]

	hl["@variable.member.yaml"] = hl["@field.yaml"]

	hl["@text.title.1.markdown"] = hl["@markup.heading.1.markdown"]
	hl["@text.title.2.markdown"] = hl["@markup.heading.2.markdown"]
	hl["@text.title.3.markdown"] = hl["@markup.heading.3.markdown"]
	hl["@text.title.4.markdown"] = hl["@markup.heading.4.markdown"]
	hl["@text.title.5.markdown"] = hl["@markup.heading.5.markdown"]
	hl["@text.title.6.markdown"] = hl["@markup.heading.6.markdown"]

	return hl
end

return M
