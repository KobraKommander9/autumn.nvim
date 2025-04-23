local M = {}

local defaults = {
	compile_path = vim.fn.stdpath("cache") .. "/autumn",
	compile_file_suffix = "_compiled",
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
