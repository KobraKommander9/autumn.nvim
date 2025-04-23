local fmt = string.format

local M = {}

function M.ensure_dir(path)
	if vim.fn.isdirectory(path) == 0 then
		vim.fn.mkdir(path, "p")
	end
end

function M.read_file(filepath, silent)
	local file = io.open(filepath, "r")
	if file then
		local content = file:read()
		file:close()
		return content
	end

	if silent then
		return
	end

	vim.notify(fmt([[Unable to open %s for reading]], filepath), vim.log.levels.ERROR)
end

function M.write_file(filepath, content, silent)
	local file = io.open(filepath, "wb")
	if file then
		file:write(content)
		file:close()
	elseif not silent then
		vim.notify(fmt([[Unable to open %s for writing]], filepath), vim.log.levels.ERROR)
	end
end

return M
