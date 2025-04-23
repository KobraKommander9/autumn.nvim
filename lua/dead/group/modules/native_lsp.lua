local M = {}

function M.get(
	spec,
	_ --[[ config ]],
	_ --[[ opts ]]
)
	local syn = spec.syntax

	return {
		LspReferenceText = { bg = spec.sel0 },
		LspReferenceRead = { bg = spec.sel0 },
		LspReferenceWrite = { bg = spec.sel0 },

		LspCodeLens = { fg = syn.comment },
		LspCodeLensSeparator = { fg = spec.fg3 },
		LspSignatureActiveParameter = { fg = spec.sel1 },

		LspInlayHint = { fg = syn.comment, bg = spec.bg2 },
	}
end

return M
