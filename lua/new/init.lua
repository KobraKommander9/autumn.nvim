local M = {}

local config = require("autumn.config")

local did_setup = false
local lock = false

function M.load(opts)
	opts = opts or {}

	if lock then
		return
	end

	if not did_setup then
		M.setup(opts)
	end
end

function M.setup(opts)
	did_setup = true
	config.options = vim.tbl_deep_extend("force", config.options, opts or {})
end

return M
