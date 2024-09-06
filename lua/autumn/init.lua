local M = {}

local defaults = {
	transparency = {
		enabled = false,
		groups = {
			"Normal",
			"NormalFloat",
			"NormalNC",
			"Pmenu",
		},
	},
	palette = {},
}

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", defaults, opts or {})
end

function M.load()
	vim.cmd("hi clear")
	vim.cmd("syntax reset")

	vim.o.termguicolors = true
	vim.g.colors_name = "autumn"

	local theme = require("autumn.theme").build(M.config)
	for group, attrs in pairs(theme) do
		vim.api.nvim_set_hl(0, group, attrs)
	end
end

setmetatable(M, {
	__index = function(_, key)
		if M.config == nil then
			M.setup()
		end
		return M[key]
	end,
})

return M
