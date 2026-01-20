local M = {}

local defaults = {
	terminal_colors = true,
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
		lua = {
			styles = {
				constructor = "NONE",
			},
		},
		rust = true,
		shell = true,
		typescript = {
			styles = {
				decorator = "italic",
			},
		},
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

return M
