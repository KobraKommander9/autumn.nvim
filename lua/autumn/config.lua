local M = { style = "autumn" }

local defaults = {
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
		documentation = "italic",
		functions = "NONE",
		keywords = "NONE",
		numbers = "NONE",
		operators = "NONE",
		preprocs = "NONE",
		statements = "bold",
		strings = "NONE",
		types = "NONE",
		variables = "NONE",
	},
	modules = {},
	debug = {
		enabled = false,
		path = vim.fn.stdpath("cache") .. "/autumn_debug",
	},
}

M.module_names = {
	"diagnostic",
	"lazy",
	"notify",
	"treesitter",
}

M.options = vim.deepcopy(defaults)

function M.reset()
	M.options = vim.deepcopy(defaults)
end

function M.set_style(style)
	M.style = style
end

function M.get_compiled_info(opts)
	opts = opts or {}
	local output_path = opts.output_path or M.options.compile_path
	local file_suffix = opts.file_suffix or M.options.compile_file_suffix
	local style = opts.name or M.style
	return output_path, output_path .. "/" .. style .. file_suffix
end

function M.get_debug_info(opts)
	opts = opts or {}
	local output_path = M.options.debug.path
	local style = opts.name or M.style
	return output_path, output_path .. "/" .. style
end

return M
