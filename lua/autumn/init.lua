local collect = require("autumn.lib.collect")
local config = require("autumn.config")
local files = require("autumn.lib.files")

local M = {}

function M.compile()
	local compiler = require("autumn.lib.compiler")

	local styles = require("autumn.palette").styles
	for _, style in ipairs(styles) do
		compiler.compile({ style = style })
	end
end

local did_setup = false
local lock = false

function M.load(opts)
	if lock then
		return
	end

	if not did_setup then
		M.setup()
	end

	opts = opts or {}

	local _, compiled_file = config.get_compiled_info(opts)
	lock = true

	local f = loadfile(compiled_file)
	if not f then
		M.compile()
		f = loadfile(compiled_file)
	end

	f()

	lock = false
end

function M.setup(opts)
	did_setup = true
	config.options = collect.deep_extend(config.options, opts or {})

	if config.options.debug.enabled == true then
		vim.g.autumn_debug = true
	end

	local cached_path = config.options.compile_path .. "/cache"
	local cached = files.read_file(cached_path, true)

	local git_path = debug.getinfo(1).source:sub(2, -23) .. "/.git"
	local git = vim.fn.getftime(git_path)
	local hash = require("autumn.hash")(config.options) .. (git == -1 and git_path or git)

	if vim.g.autumn_debug or cached ~= hash then
		M.compile()
		files.write_file(cached_path, hash)
	end
end

return M
