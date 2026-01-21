local M = {}

local function color(base, dim, bg)
	local c = { base = base, dim = dim, bg = bg }

	return setmetatable(c, {
		__index = function(t, key)
			return rawget(t, key)
		end,
		__tostring = function(t)
			return t.base
		end,
	})
end

local palette = {
	-- Backgrounds (green gradient)
	bg0 = "#1a1d16", -- main editing area
	bg1 = "#23281e", -- slightly lighter, cursorline base
	bg2 = "#2a2f23", -- panels, floats, sidebars
	bg3 = "#38422f", -- visual selection

	-- Foregrounds
	fg0 = "#b8b2a7", -- dim / secondary text
	fg1 = "#e6e1d8", -- main text
	fg2 = "#6b8fa3", -- blue accents (functions/methods)
	fg3 = "#8f8a80", -- subtle text (comments, nontext)

	-- Selections
	sel0 = "#38422f", -- visual select base
	sel1 = "#414d36", -- visual select highlight / hover

	-- Border / UI
	border = "#3a372f",

	-- Core semantic colors
	primary = color("#eb5e28", "#7a341e", "#5f3a1c"), -- orange (keywords, control flow)
	secondary = color("#7f9a3e", "#4f6430", "#3b4a21"), -- olive green (types, traits)

	-- Standard syntax colors
	red = color("#c14f3b", "#7a2f28", "#4a1f1c"),
	green = color("#9bbf4f", "#5f7a2e", "#2f4a21"),
	yellow = color("#d6a45a", "#8f6437", "#4a4720"),
	blue = color("#6b8fa3", "#3d5e6e", "#2d4a57"),
	cyan = color("#5f9ea0", "#386869", "#2a5052"),
	purple = color("#7f5fac", "#4d3b74", "#352c4d"),
	magenta = color("#b36b7d", "#724653", "#543640"),
	pink = color("#f990a7", "#a65a6b", "#733f50"),
}

M.palette = palette

return M
