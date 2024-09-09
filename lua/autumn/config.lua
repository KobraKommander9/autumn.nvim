local M = {}

local defaults = {
  compile_path = vim.fn.stdpath("config") .. "/autumn",
  compile_file_suffix = "_compiled",
  transparency = {
		enabled = false,
		groups = {
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
}

M.options = vim.deepcopy(defaults)

M.get_compiled_info = function(opts)
  local output_path = opts.output_path or M.options.compile_path
  local file_suffix = opts.file_suffix or M.options.compile_file_suffix
  local style = opts.name or "autumn"
  return output_path, output_path .. "/" .. style .. file_suffix
end

return M
