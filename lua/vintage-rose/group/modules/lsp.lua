local M = {}

function M.get(roles, _, _)
	local syn = roles.syntax
	local sem = roles.semantic
	local ui = roles.ui

	return {
		-- LSP Diagnostics (native)
		LspDiagnosticsError = { fg = sem.error.fg },
		LspDiagnosticsWarning = { fg = sem.warn.fg },
		LspDiagnosticsInformation = { fg = sem.info.fg },
		LspDiagnosticsHint = { fg = sem.hint.fg },

		LspDiagnosticsVirtualTextError = { fg = sem.error.fg },
		LspDiagnosticsVirtualTextWarning = { fg = sem.warn.fg },
		LspDiagnosticsVirtualTextInformation = { fg = sem.info.fg },
		LspDiagnosticsVirtualTextHint = { fg = sem.hint.fg },

		LspDiagnosticsUnderlineError = { sp = sem.error.fg, style = "undercurl" },
		LspDiagnosticsUnderlineWarning = { sp = sem.warn.fg, style = "undercurl" },
		LspDiagnosticsUnderlineInformation = { sp = sem.info.fg, style = "undercurl" },
		LspDiagnosticsUnderlineHint = { sp = sem.hint.fg, style = "undercurl" },

		-- LSP Semantic Tokens (linked to treesitter)
		LspReferenceText = { bg = ui.bg.surface },
		LspReferenceRead = { bg = ui.bg.surface },
		LspReferenceWrite = { bg = ui.bg.surface, sp = roles.emphasis.high.fg, style = "underline" },

		LspCodeLens = roles.emphasis.muted,
		LspCodeLensSeparator = { fg = ui.fg.subtle },
		LspInlayHint = { fg = ui.fg.subtle, style = "italic" },

		LspSignatureActiveParameter = roles.emphasis.bold,

		-- LSP Semantic Types
		LspType = { link = "@type" },
		LspClass = { link = "@type" },
		LspInterface = { link = "@type.definition" },
		LspEnum = { link = "@type" },
		LspEnumMember = { link = "@constant" },
		LspFunction = { link = "@function" },
		LspMethod = { link = "@method" },
		LspVariable = { link = "@variable" },
		LspParameter = { link = "@parameter" },
		LspProperty = { link = "@property" },
		LspNamespace = { link = "@module" },
		LspTypeParameter = { link = "@type" },
		LspConstant = { link = "@constant" },
		LspString = { link = "@string" },
		LspNumber = { link = "@number" },
		LspBoolean = { link = "@boolean" },
		LspKeyword = { link = "@keyword" },
		LspOperator = { link = "@operator" },
		LspDecorator = { link = "@function.builtin" },
		LspMacro = { link = "@function.builtin" },

		-- Types & Classes
		["@lsp.type.class"] = { link = "@type" },
		["@lsp.type.decorator"] = { link = "@function.macro" },
		["@lsp.type.enum"] = { link = "@type" },
		["@lsp.type.enumMember"] = { link = "@constant" },
		["@lsp.type.function"] = { link = "@function" },
		["@lsp.type.interface"] = { link = "@type.definition" },
		["@lsp.type.macro"] = { link = "@function.macro" },
		["@lsp.type.method"] = { link = "@function.method" },
		["@lsp.type.namespace"] = { link = "@module" },
		["@lsp.type.parameter"] = { link = "@variable.parameter" },
		["@lsp.type.property"] = { link = "@variable.member" },
		["@lsp.type.struct"] = { link = "@type" },
		["@lsp.type.type"] = { link = "@type" },
		["@lsp.type.typeParameter"] = { link = "@type.definition" },
		["@lsp.type.variable"] = { link = "@variable" },
		["@lsp.type.comment"] = { link = "@comment" },
		["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },

		-- Type Modifiers
		["@lsp.typemod.variable.defaultLibrary"] = syn.builtin_var,
		["@lsp.typemod.type.defaultLibrary"] = syn.builtin_type,
		["@lsp.typemod.function.defaultLibrary"] = syn.builtin_func,
		["@lsp.typemod.method.defaultLibrary"] = syn.builtin_func,
		["@lsp.typemod.keyword.async"] = syn.control,
		["@lsp.typemod.variable.readonly"] = syn.constant,

		-- Unresolved references
		["@lsp.type.unresolvedReference"] = { fg = sem.error.fg, style = "italic" },
	}
end

return M
