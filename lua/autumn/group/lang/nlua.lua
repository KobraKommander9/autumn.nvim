local M = {}

local defaults = {
	styles = {
		constructor = "NONE",
	},
}

function M.get(spec, _, opts)
	opts = vim.tbl_deep_extend("force", defaults, opts or {})

	local syn = spec.syntax
	local stl = opts.styles

	return {
		-- ["@constructor.lua"] = { fg = syn.func, style = stl.constructor },
		-- ["@function.lua"] = { fg = syn.func, style = stl.functions },
		-- ["@function.builtin.lua"] = { fg = syn.builtin0, style = stl.functions },
		-- ["@variable.lua"] = { fg = syn.variable, style = stl.variables },
		-- ["@keyword.lua"] = { fg = spec.primary, style = stl.keywords },
	}
end

return M
