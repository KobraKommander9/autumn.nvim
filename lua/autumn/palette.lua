local M = {}

M.styles = {
	"autumn",
}

local function load_palette(name)
	local valid = vim.tbl_contains(M.styles, name)
	return valid and require("autumn.palette." .. name) or require("autumn.palette.autumn")
end

function M.load(name)
	if name then
		return load_palette(name)
	end

	local result = {}
	for _, style in ipairs(M.styles) do
		result[style] = load_palette(style)
	end

	return result
end

return M
