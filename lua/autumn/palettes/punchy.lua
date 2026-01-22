local M = {}

local color = require("autumn.palettes.color")

local palette = {
	-- Backgrounds
	bg0 = "#161813",
	bg1 = "#1e211a",
	bg2 = "#262b21",
	bg3 = "#323a2b",

	-- Foregrounds
	fg0 = "#a89984",
	fg1 = "#ebdbb2",
	fg2 = "#d3869b",
	fg3 = "#665c54",

	-- Selections
	sel0 = "#374131",
	sel1 = "#4e6947",

	-- Border / UI
	border = "#282c22",

	-- Core semantic colors
	primary = color.new("#fe8019", "#af3a03", "#7d2a02"),
	secondary = color.new("#b8bb26", "#79740e", "#4f4d06"),

	-- Standard syntax colors
	red = color.new("#fb4934", "#9d0006", "#610003"),
	green = color.new("#b8bb26", "#79740e", "#4f4d06"),
	yellow = color.new("#fabd2f", "#b57614", "#7d5006"),
	blue = color.new("#83a598", "#458588", "#2d5e5e"),
	cyan = color.new("#89b482", "#5b8256", "#405c3d"),
	purple = color.new("#d3869b", "#8f3f71", "#5f2a4a"),
	magenta = color.new("#f39660", "#af3a03", "#7d2a02"),
	pink = color.new("#fbafc0", "#a65a6b", "#733f50"),
}

function M.get(p, styles)
	styles = styles or {}

	return {
		syntax = {
			func = {
				fg = p.fg2,
				style = color.get_style(styles.functions, "bold"),
			},
		},
	}
end

M.palette = palette

return M
