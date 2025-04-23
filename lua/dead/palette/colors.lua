local Color = require("autumn.color")

local M = {}

local palette = {
	"red",
	"orange",
	"yellow",
	"green",
	"blue",
	"purple",
	"pink",
	"magenta",
	"cyan",
}

function M.new(colors)
	if not colors.white or not colors.black then
		return colors
	end

	colors.gray = Color.new(colors.white.mix(colors.black, 90))
	for _, name in ipairs(palette) do
		colors["soft_" .. name] = Color.new(colors.white.mix(colors[name], 50))
		colors["hard_" .. name] = Color.new(colors.black.mix(colors[name], 50))
	end

	return colors
end

setmetatable(M, {
	__call = function(_, ...)
		return M.new(...)
	end,
})

return M
