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
	require("autumn.theme").build(M.config)
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
