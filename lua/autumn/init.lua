local Config = require("autumn.config")
local Files = require("autumn.files")

local M = {}

local did_setup = false
local lock = false

function M.compile(opts)
	opts = opts or {}

	local compiler = require("autumn.compiler")
	compiler.compile()

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

	local _, compiled_file = Config.get_compiled_info(opts)
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
	Config.options = vim.tbl_deep_extend("force", Config.options, opts or {})

	if not Config.options.cache then
		M.compile()
		return
	end

	local cached_path = Config.options.compile_path .. "/cache"
	local cached = Files.read_file(cached_path, true)

	local git_path = debug.getinfo(1).source:sub(2, -23) .. "/.git"
	local git = vim.fn.getftime(git_path)
	local hash = require("autumn.hash")(Config.options) .. (git == -1 and git_path or git)

	if cached ~= hash then
		M.compile()
		Files.write_file(cached_path, hash)
	end
end

return M
