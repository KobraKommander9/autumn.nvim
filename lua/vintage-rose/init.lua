local M = {}

local config = require("vintage-rose.config")

local did_setup = false

local function get_cached_contents(path)
	local f = loadfile(path)
	if not f then
		return nil
	end

	local ok, contents = pcall(f)
	return ok and contents or nil
end

function M.compile(opts)
	opts = opts or {}
	opts.hash = opts.hash or require("vintage-rose.compiler").get_hash(config.options)

	require("vintage-rose.compiler").compile(opts)

	if opts.notify then
		vim.notify("VintageRose compiled successfully", vim.log.levels.INFO, {
			title = "VintageRose",
			timeout = 2000,
		})
	end
end

function M.export(opts)
	opts = opts or {}
	if not opts.export then
		vim.notify("No exporter specified", vim.log.levels.WARN, {
			title = "VintageRose",
			timeout = 2000,
		})
	end

	local ok, exporter = pcall(require, "vintage-rose.exporters." .. opts.export)
	if not ok then
		vim.notify("Couldn't find exporter: " .. module, vim.log.levels.ERROR, {
			title = "VintageRose",
			timeout = 2000,
		})
		return
	end

	local cfg_opts = require("vintage-rose.config").options
	cfg_opts = vim.tbl_deep_extend("force", cfg_opts, opts)

	local roles = require("vintage-rose.palettes").load(cfg_opts)
	local groups = require("vintage-rose.compiler").load_groups(cfg_opts, roles)

	local content = exporter.build(roles, groups)
	local path = exporter.path(opts.export_path)

	require("vintage-rose.files").write_file(path, content)
end

function M.get_palette(opts)
	if not did_setup then
		M.setup(opts)
	end

	local _, compiled_file = config.get_compiled_info(config.options)
	local cache = get_cached_contents(compiled_file)

	if not cache or not cache.roles then
		M.compile({ hash = require("vintage-rose.compiler").get_hash(config.options) })
		cache = get_cached_contents(compiled_file)
	end

	return cache and cache.roles or {}
end

function M.load(opts)
	if not did_setup then
		M.setup(opts)
	end

	local _, compiled_file = config.get_compiled_info(config.options)
	local cache = get_cached_contents(compiled_file)

	if not cache then
		M.compile({ hash = require("vintage-rose.compiler").get_hash(config.options) })
		cache = get_cached_contents(compiled_file)
	end

	if cache and cache.code then
		loadstring(cache.code)()
	end
end

function M.reload(opts)
	opts = opts or {}

	for name, _ in pairs(package.loaded) do
		if name:match("^vintage-rose") then
			package.loaded[name] = nil
		end
	end

	local cfg = require("vintage-rose.config")
	local hash = "FORCE_" .. os.clock()

	M.compile({ hash = hash })

	local _, cache_file = cfg.get_compiled_info(cfg.options)

	local cache = get_cached_contents(cache_file)
	if cache then
		loadstring(cache.code)()

		if opts.notify then
			vim.notify("VintageRose: reloaded", vim.log.levels.INFO)
		end
	end
end

function M.setup(opts)
	did_setup = true
	config.options = vim.tbl_deep_extend("force", config.options, opts or {})

	local current_hash = require("vintage-rose.compiler").get_hash(config.options)
	local _, cache_file = config.get_compiled_info(config.options)

	if not config.options.compile.cache then
		M.compile({ hash = current_hash })
		M.load()
		return
	end

	local cache = get_cached_contents(cache_file)
	if cache and cache.hash == current_hash then
		loadstring(cache.code)()
	else
		M.compile({ hash = current_hash })
		M.load()
	end
end

return M
