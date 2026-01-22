local M = {}

function M.get(roles, _, _)
	local syn = roles.syntax

	return {
		-- structs & interfaces
		["@type.go"] = syn.type,
		["@type.definition.go"] = syn.interface,

		-- functions & methods
		["@function.method.go"] = syn.func,
		["@variable.receiver.go"] = { fg = syn.param.fg, style = "italic" },

		-- builtins & keywords
		["@function.builtin.go"] = syn.builtin_func,
		["@constant.builtin.go"] = syn.constant,

		-- semantic tokens
		["@lsp.typemod.variable.defaultLibrary.go"] = syn.builtin_var,
		["@lsp.type.namespace.go"] = syn.module,
		["@lsp.type.type.go"] = syn.type,
	}
end

return M
