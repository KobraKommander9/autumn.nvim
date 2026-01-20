local M = {}

function M.get(spec, config, _)
	local has_ts = config.has_module("treesitter")
	local p = spec.palette
	local syn = spec.syntax

	return {
		BlinkCmpDoc = { fg = spec.fg1, bg = spec.bg2 },
		BlinkCmpDocBorder = { fg = spec.border, bg = spec.bg2 },

		BlinkCmpLabel = { fg = spec.fg1, bg = spec.bg1 },
		BlinkCmpLabelDeprecated = { fg = syn.dep, style = "strikethrough" },
		BlinkCmpLabelMatch = { fg = syn.type },

		BlinkCmpLabelDetail = { link = "Comment" },

		BlinkCmpKindDefault = { fg = spec.fg2, bg = spec.bg3 },
		BlinkCmpKindKeyword = { fg = syn.keyword, bg = spec.bg3 },
		BlinkCmpKindVariable = { link = has_ts and "@variable" or "Identifier", bg = spec.bg3 },
		BlinkCmpKindConstant = { link = has_ts and "@constant" or "Constant", bg = spec.bg3 },
		BlinkCmpKindReference = { fg = syn.builtin0, bg = spec.bg3 },
		BlinkCmpKindValue = { fg = syn.builtin1, bg = spec.bg3 },
		BlinkCmpKindFunction = { link = "Function", bg = spec.bg3 },
		BlinkCmpKindMethod = { link = "Function", bg = spec.bg3 },
		BlinkCmpKindConstructor = { link = "Function", bg = spec.bg3 },

		BlinkCmpKindInterface = { fg = p.cyan.dim, bg = spec.bg3 },
		BlinkCmpKindEvent = { fg = syn.builtin2, bg = spec.bg3 },
		BlinkCmpKindEnum = { fg = syn.builtin2, bg = spec.bg3 },
		BlinkCmpKindUnit = { fg = syn.builtin2, bg = spec.bg3 },

		BlinkCmpKindClass = { link = "Type", bg = spec.bg3 },
		BlinkCmpKindStruct = { link = "Type", bg = spec.bg3 },
		BlinkCmpKindModule = { link = has_ts and "@namespace" or "Identifier", bg = spec.bg3 },

		BlinkCmpKindProperty = { link = has_ts and "@property" or "Identifier", bg = spec.bg3 },
		BlinkCmpKindField = { link = has_ts and "@field" or "Identifier", bg = spec.bg3 },
		BlinkCmpKindTypeParameter = { fg = syn.secondary.dim, bg = spec.bg3 },
		BlinkCmpKindEnumMember = { fg = syn.secondary.dim, bg = spec.bg3 },
		BlinkCmpKindOperator = { link = "Operator", bg = spec.bg3 },
		BlinkCmpKindSnippet = { fg = p.pink.base, bg = spec.bg3 },
	}
end

return M
