local M = {}

local defaults = {
	styles = {
		builtins = "italic",
	},
}

function M.get(roles, _, opts)
	opts = vim.tbl_deep_extend("force", defaults, opts or {})

	local stl = opts.styles

	return {
		["@variable.builtin.lua"] = { fg = roles.emphasis.high.fg, style = stl.builtins },
	}
end

return M
