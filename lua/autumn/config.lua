local M = {}

local defaults = {
	cache = true,
	compile_path = vim.fn.stdpath("cache") .. "/autumn",
	compile_file_suffix = "_compiled",
	terminal_colors = true,
	module_default = true,
	transparency = {
		enabled = false,
		groups = {
			"DiagnosticVirtualTextError",
			"DiagnosticVirtualTextWarn",
			"DiagnosticVirtualTextInfo",
			"DiagnosticVirtualTextHint",
			"DiagnosticVirtualTextOk",
			"LspInlayHint",
			"Normal",
			"NormalFloat",
			"NormalNC",
			"Pmenu",
		},
	},
	styles = {
		comments = "italic",
		conditionals = "NONE",
		constants = "NONE",
		diagnostics = "italic,underline",
		documentation = "italic",
		functions = "NONE",
		keywords = "NONE",
		links = "italic,underline",
		numbers = "NONE",
		operators = "NONE",
		preprocs = "NONE",
		statements = "bold",
		strings = "NONE",
		types = "NONE",
		variables = "NONE",
	},
	modules = {},
}

M.module_names = {}

M.options = vim.deepcopy(defaults)

function M.get_compiled_info(opts)
	opts = opts or {}
	local output_path = opts.output_path or M.options.compile_path
	local file_suffix = opts.file_suffix or M.options.compile_file_suffix
	return output_path, output_path .. "/autumn" .. file_suffix
end

return M
