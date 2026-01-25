local M = {}

local defaults = {
	compile = {
		cache = true,
		path = vim.fn.stdpath("cache") .. "/vintage-rose",
		suffix = "_compiled",
	},
	terminal_color = true,
	modules = {
		blink = true,
		diagnostic = true,
		lsp = true,
		mini = true,
		notify = true,
		treesitter = true,
	},
	langs = {
		json = true,
		lua = true,
		rust = true,
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
	return output_path, output_path .. "/vintage-rose" .. file_suffix
end

return M
