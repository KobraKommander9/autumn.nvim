local M = {}

local config = require("autumn.config")

local did_setup = false
local lock = false

function M.compile(opts)
	opts = opts or {}

	local compiler = require("autumn.compiler")
	compiler.compile(opts)

	if opts.notify then
		vim.notify("Autumn compiled successfully", vim.log.levels.INFO, {
			title = "Autumn",
			timeout = 2000,
		})
	end
end

function M.load(opts)
	opts = opts or {}

	if lock then
		return
	end

	if not did_setup then
		M.setup(opts)
	end

	local _, compiled_file = config.get_compiled_info(opts)
	lock = true

	local f = loadfile(compiled_file)
	if not f then
		M.compile()
		f = loadfile(compiled_file)
	end

	assert(f)
	f()

	lock = false
end

function M.setup(opts)
	did_setup = true
	config.options = vim.tbl_deep_extend("force", config.options, opts or {})

	if not config.options.compile.cache then
		M.compile()
		return
	end

	local current_hash = require("autumn.compiler").get_hash(config.options)
	local _, cache_file = config.get_compiled_info(opts)

	local f = loadfile(cache_file)
	if f then
		local cache = f()
		if cache.hash == current_hash then
			loadstring(cache.code)()
			return
		end
	end

	M.compile({ hash = current_hash })
end

return M
