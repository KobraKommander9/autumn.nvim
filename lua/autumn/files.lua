local M = {}

function M.ensure_dir(path)
	if vim.fn.isdirectory(path) == 0 then
		vim.fn.mkdir(path, "p")
	end
end

function M.read_file(filepath)
	local file = io.open(filepath, "r")
	if file then
		local content = file:read()
		file:close()
		return content
	end
end

function M.write_file(filepath, content)
	local file = io.open(filepath, "wb")
	if file then
		file:write(content)
		file:close()
	end
end

return M
