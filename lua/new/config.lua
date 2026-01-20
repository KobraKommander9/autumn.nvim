local M = {}

local defaults = {
	compile = {
		cache = true,
		path = vim.fn.stdpath("cache") .. "/autumn",
		suffix = "_compiled",
	},
	terminal_color = true,
	styles = {
		comments = "italic",
		documentation = "italic",

		keywords = "bold",
		statements = "NONE",

		conditionals = "NONE",
		constants = "NONE",
		functions = "NONE",
		numbers = "NONE",
		operators = "NONE",
		preprocs = "NONE",
		strings = "NONE",
		types = "NONE",
		variables = "NONE",

		diagnostics = "italic,underline",
		links = "italic,underline",
	},
	modules = {
		blink = true,
		diagnostic = true,
		lazy = true,
		lsp = true,
		mini = true,
		notify = true,
		treesitter = true,
	},
	langs = {
		go = true,
		json = true,
		lua = true,
		rust = true,
		shell = true,
		typescript = true,
		yaml = true,
	},
}

M.options = vim.deepcopy(defaults)

M.lang_mappings = {
	lua = "nlua",
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

function M.has_module(mod)
	return is_enabled(M.options.modules, mod)
end

function M.has_lang(lang)
	return is_enabled(M.options.langs, lang)
end

function M.get_compiled_info(opts)
	opts = opts or {}
	local output_path = opts.output_path or M.options.compile.path
	local file_suffix = opts.file_suffix or M.options.compile.suffix
	return output_path, output_path .. "/autumn" .. file_suffix
end

return M
