local M = {}

local color = require("vintage-rose.palettes.color")

local palette = {
	-- Backgrounds
	bg0 = "#262318", -- main editing area
	bg1 = "#322f25", -- slightly lighter, cursorline base
	bg2 = "#3c392c", -- panels, floats, sidebars
	bg3 = "#585341", -- visual selection
	bg4 = "#423d2b", -- surfaces (diff changes, lsp hover background)

	-- Foregrounds
	fg0 = "#b8b4a0", -- dim / secondary text
	fg1 = "#f2eed9", -- main text
	fg2 = "#d69981", -- accents (functions/methods)
	fg3 = "#616355", -- subtle text (comments, nontext)

	-- Selections
	sel0 = "#4a2b30", -- visual select base
	sel1 = "#8c4351", -- visual select highlight / hover

	-- Border / UI
	border = "#706d5d",

	-- Core semantic colors
	primary = color.new("#f7768e", "#965b67", "#3d262a"),
	secondary = color.new("#e0af68", "#8c7352", "#382e21"),

	-- Standard syntax colors
	red = color.new("#db4b4b"),
	green = color.new("#9ece6a", "#7da383"),
	yellow = color.new("#ff9e64"),
	blue = color.new("#7aa2f7"),
	cyan = color.new("#89ddff"),
	purple = color.new("#bb9af7", "#a48ead"),
	magenta = color.new("#ad8ee6"),
	pink = color.new("#f7768e", "#965b67", "#3d262a"),
}

M.palette = palette

return M
