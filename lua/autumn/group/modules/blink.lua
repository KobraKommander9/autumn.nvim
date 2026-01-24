local M = {}

function M.get(roles, _, _)
	local syn = roles.syntax

	return {
		-- item kind icons
		BlinkCmpKindFunction = { fg = syn.func.fg },
		BlinkCmpKindMethod = { fg = syn.func.fg },
		BlinkCmpKindVariable = { fg = syn.variable.fg },
		BlinkCmpKindKeyword = { fg = syn.keyword.fg },
		BlinkCmpKindProperty = { fg = syn.field.fg },
		BlinkCmpKindInterface = { fg = syn.interface.fg },
		BlinkCmpKindTypeParameter = { fg = syn.interface.fg },
		BlinkCmpKindClass = { fg = syn.type.fg },
		BlinkCmpKindStruct = { fg = syn.type.fg },
		BlinkCmpKindConstant = { fg = syn.constant.fg },
		BlinkCmpKindField = { fg = syn.field.fg },
		BlinkCmpKindModule = { fg = syn.module.fg },
	}
end

return M
