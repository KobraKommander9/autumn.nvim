local M = { style = "autumn" }

local defaults = {
	compile_path = vim.fn.stdpath("cache") .. "/autumn",
	compile_file_suffix = "_compiled",
}

M.options = vim.deepcopy(defaults)

function M.get_compiled_info(opts)
	opts = opts or {}
	local output_path = opts.output_path or M.options.compile_path
	local file_suffix = opts.file_suffix or M.options.compile_file_suffix
	local style = opts.name or M.style
	return output_path, output_path .. "/" .. style .. file_suffix
end

return M
