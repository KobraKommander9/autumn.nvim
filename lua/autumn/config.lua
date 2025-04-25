local M = {}

M.is_nvim = vim.fn.has("nvim") == 1

local defaults = {
	cache = true,
	compile_path = vim.fn.stdpath("cache") .. "/autumn",
	compile_file_suffix = "_compiled",
	lush = {
		enabled = false,
		path = vim.fn.stdpath("cache") .. "/autumn",
	},
	terminal_colors = true,
	module_default = true,
	styles = {
		comments = "italic",
		conditionals = "NONE",
		constants = "NONE",
		diagnostics = "italic,underline",
		documentation = "italic",
		functions = "italic",
		keywords = "bold",
		links = "italic,underline",
		numbers = "NONE",
		operators = "NONE",
		preprocs = "NONE",
		statements = "bold",
		strings = "NONE",
		types = "NONE",
		variables = "NONE",
	},
	modules = {
		diagnostic = {
			enable = true,
			background = true,
		},
		native_lsp = {
			enable = M.is_nvim,
			background = true,
		},
		treesitter = M.is_nvim,
		lsp_semantic_tokens = M.is_nvim,
	},
	langs = {
		lua = {
			enable = true,
			styles = {
				constructor = "NONE",
			},
		},
	},
}

M.module_names = {
	"blink",
	"diagnostic",
	"lazy",
	"lsp_semantic_tokens",
	"mini",
	"native_lsp",
	"notify",
	"treesitter",
}

M.lang_names = {
	"lua",
}

M.options = vim.deepcopy(defaults)

function M.get_compiled_info(opts)
	opts = opts or {}
	local output_path = opts.output_path or M.options.compile_path
	local file_suffix = opts.file_suffix or M.options.compile_file_suffix
	return output_path, output_path .. "/autumn" .. file_suffix
end

function M.get_lush_info(opts)
	opts = opts or {}
	local output_path = opts.output_path or M.options.lush.path
	return output_path, output_path .. "/autumn_lush.lua"
end

return M
