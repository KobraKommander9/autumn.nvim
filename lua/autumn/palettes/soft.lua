local M = {}

local color = require("autumn.palettes.color")

local palette = {
	-- Backgrounds
	bg0 = "#1c1f1a",
	bg1 = "#252920",
	bg2 = "#2e3328",
	bg3 = "#3e4536",

	-- Foregrounds
	fg0 = "#bdae93",
	fg1 = "#e8e3d8",
	fg2 = "#d699b6",
	fg3 = "#838175",

	-- Selections
	sel0 = "#4a5142",
	sel1 = "#5a6351",

	-- Border / UI
	border = "#3d3b34",

	-- Core semantic colors
	primary = color.new("#e67e50", "#a65432", "#7d3e26"),
	secondary = color.new("#a6b464", "#707a43", "#515830"),

	-- Standard syntax colors
	red = color.new("#e67e80", "#a64d4d", "#7d3a3a"),
	green = color.new("#a7c080", "#738f54", "#4a5c36"),
	yellow = color.new("#dbbc7f", "#a68a54", "#7d683f"),
	blue = color.new("#7fbbb3", "#4f8f87", "#3a6b65"),
	cyan = color.new("#83c092", "#5e946e", "#446b50"),
	purple = color.new("#d39bb6", "#996d85", "#735264"),
	magenta = color.new("#e69875", "#a66b50", "#7d503c"),
	pink = color.new("#f3a0a0", "#a66d6d", "#7d5252"),
}

function M.get(p)
	return {
		syntax = {
			punctuation = {
				fg = p.fg3,
			},

			field = {
				fg = p.magenta.base,
			},

			func = {
				fg = p.fg2,
			},

			operator = {
				fg = p.fg0,
			},
		},
	}
end

M.palette = palette

return M
