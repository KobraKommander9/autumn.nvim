local M = {}

local function load_spec(name)
	local palette = require("autumn.palette").load(name)
	local spec = palette.generate_spec(palette.palette)
	spec.palette = palette
	return spec
end

function M.load(name)
	if name then
		return load_spec(name)
	end

	local result = {}

	local styles = require("autumn.palette").styles
	for _, style in ipairs(styles) do
		result[style] = load_spec(style)
		if not result.palette then
			result.palette = result[style].palette
		end
	end

	return result
end

return M
