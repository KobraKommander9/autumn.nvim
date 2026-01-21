local M = {}

local defaults = {
	compile = {
		cache = true,
		path = vim.fn.stdpath("cache") .. "/autumn",
		suffix = "_compiled",
	},
	terminal_color = true,
	modules = {
		blink = false,
		diagnostic = false,
		lazy = false,
		lsp = false,
		mini = false,
		notify = false,
		treesitter = false,
	},
	langs = {
		go = false,
		json = false,
		lua = false,
		rust = false,
		shell = false,
		typescript = false,
		yaml = false,
	},
}

local function is_enabled(t, key)
	local entry = t[key]
	if not entry then
		return false
	end

	if type(entry) == "table" then
		return entry.disable ~= true
	end

	return entry == true
end

M.options = vim.deepcopy(defaults)
M.options.has_module = function(mod)
	return is_enabled(M.options.modules, mod)
end
M.options.has_lang = function(lang)
	return is_enabled(M.options.langs, lang)
end

function M.get_compiled_info(opts)
	opts = opts or {}
	local output_path = opts.output_path or M.options.compile.path
	local file_suffix = opts.file_suffix or M.options.compile.suffix
	return output_path, output_path .. "/autumn" .. file_suffix
end

return M
