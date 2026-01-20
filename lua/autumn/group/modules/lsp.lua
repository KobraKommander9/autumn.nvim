local M = {}

function M.get(spec, _, _)
	local p = spec.palette
	local diag = spec.diag
	local syn = spec.syntax

	return {
		-- LSP Diagnostics (native)
		LspDiagnosticsError = { fg = diag.error },
		LspDiagnosticsWarning = { fg = diag.warn },
		LspDiagnosticsInformation = { fg = diag.info },
		LspDiagnosticsHint = { fg = diag.hint },
		LspDiagnosticsVirtualTextError = { fg = diag.error },
		LspDiagnosticsVirtualTextWarning = { fg = diag.warn },
		LspDiagnosticsVirtualTextInformation = { fg = diag.info },
		LspDiagnosticsVirtualTextHint = { fg = diag.hint },
		LspDiagnosticsUnderlineError = { sp = diag.error, style = "undercurl" },
		LspDiagnosticsUnderlineWarning = { sp = diag.warn, style = "undercurl" },
		LspDiagnosticsUnderlineInformation = { sp = diag.info, style = "undercurl" },
		LspDiagnosticsUnderlineHint = { sp = diag.hint, style = "undercurl" },

		-- LSP Semantic Tokens (linked to treesitter)
		LspReferenceText = { link = "@variable" }, -- symbol under cursor
		LspReferenceRead = { link = "@variable.read" }, -- read access
		LspReferenceWrite = { link = "@variable.write" }, -- write access

		LspCodeLens = { fg = syn.comment }, -- inline code lens
		LspCodeLensSeparator = { fg = syn.comment },

		-- LSP Semantic Types
		LspType = { link = "@type" }, -- classes, structs, interfaces
		LspClass = { link = "@type" },
		LspInterface = { fg = p.cyan.dim },
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

		LspInlayHint = { fg = spec.fg0, style = "italic" },
		LspSignatureActiveParameter = { fg = spec.primary, style = "bold" },

		-- Types & Classes
		["@lsp.class"] = { link = "@type" },
		["@lsp.enum"] = { link = "@type" },
		["@lsp.enumMember"] = { link = "@constant" },
		["@lsp.interface"] = { link = "LspInterface" },
		["@lsp.typeParameter"] = { link = "@type" },
		["@lsp.builtinType"] = { link = "@type" },
		["@lsp.boolean"] = { link = "@number" },
		["@lsp.number"] = { link = "@number" },
		["@lsp.string"] = { link = "@string" },
		["@lsp.escapeSequence"] = { link = "@string.escape" },
		["@lsp.formatSpecifier"] = { link = "@punctuation.special" },

		["@lsp.type"] = { link = "@type" },
		["@lsp.type.class"] = { link = "@type" }, -- class
		["@lsp.type.enum"] = { link = "@type" }, -- enum
		["@lsp.type.enumMember"] = { link = "@constant" }, -- enum members
		["@lsp.type.interface"] = { link = "@lsp.interface" }, -- interface (secondary.base)
		["@lsp.type.typeAlias"] = { link = "@type" }, -- type aliases
		["@lsp.type.parameter"] = { link = "@parameter" }, -- function/method params
		["@lsp.type.variable"] = { link = "@variable" }, -- regular variables
		["@lsp.type.selfKeyword"] = { link = "@variable.builtin" }, -- self/this
		["@lsp.type.function"] = { link = "@function" }, -- normal functions
		["@lsp.type.method"] = { link = "@function" }, -- methods
		["@lsp.type.decorator"] = { link = "@decorator" }, -- decorators/annotations
		["@lsp.type.property"] = { link = "@property" }, -- object properties
		["@lsp.type.keyword"] = { link = "@keyword" }, -- language keywords
		["@lsp.type.operator"] = { link = "@operator" }, -- operators
		["@lsp.type.boolean"] = { link = "@number" }, -- booleans (purple.base)
		["@lsp.type.number"] = { link = "@number" }, -- numbers (purple.base)
		["@lsp.type.string"] = { link = "@string" }, -- strings (cyan.base)
		["@lsp.type.comment"] = { link = "@comment" }, -- comments

		-- Special / namespace
		["@lsp.type.namespace"] = { link = "@module" }, -- modules, packages
		["@lsp.type.unresolvedReference"] = { link = "@error" }, -- errors

		-- Functions / Methods
		["@lsp.function"] = { link = "@function" },
		["@lsp.method"] = { link = "@function" },
		["@lsp.decorator"] = { link = "@decorator" },

		-- Variables / Properties
		["@lsp.variable"] = { link = "@variable" },
		["@lsp.parameter"] = { link = "@parameter" },
		["@lsp.property"] = { link = "@property" },
		["@lsp.selfKeyword"] = { link = "@variable.builtin" },

		-- Keywords / Operators
		["@lsp.keyword"] = { link = "@keyword" },
		["@lsp.operator"] = { link = "@operator" },

		-- Comments / Documentation
		["@lsp.comment"] = { link = "@comment" },
		["@lsp.namespace"] = { link = "@namespace" },
		["@lsp.unresolvedReference"] = { link = "@error" },

		-- Type Modifiers
		["@lsp.typemod.class.defaultLibrary"] = { link = "@type.builtin" },
		["@lsp.typemod.enum.defaultLibrary"] = { link = "@type.builtin" },
		["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
		["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
		["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.builtin" },
		["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
		["@lsp.typemod.operator.injected"] = { link = "@operator" },
		["@lsp.typemod.string.injected"] = { link = "@string" },
		["@lsp.typemod.type.defaultLibrary"] = { link = "@type.builtin" },
		["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
		["@lsp.typemod.variable.injected"] = { link = "@variable" },
		["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
	}
end

return M
