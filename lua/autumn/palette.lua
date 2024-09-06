local hsl = require("autumn.gen.hsl")

local generate_palette = function(palette)
	palette = palette or {}
	for key, value in pairs(palette) do
		palette[key] = hsl(value)
	end

	local colors = {
		white = hsl("#f4ebbe"),
		black = hsl("#272d2d"),

		primary = hsl("#eb5e28"),
		secondary = hsl("#6a8532"),

		red = hsl("#800e13"),
		orange = hsl("#f27f34"),
		yellow = hsl("#edd83d"),
		green = hsl("#799431"),
		blue = hsl("#1c77c3"),
		purple = hsl("#846b8a"),

		pink = hsl("#d65780"),
		magenta = hsl("#a23b72"),
	}

	colors.light_primary1 = colors.primary.lighten(10)
	colors.light_primary2 = colors.primary.lighten(20)
	colors.light_secondary1 = colors.secondary.lighten(20)
	colors.light_secondary2 = colors.secondary.lighten(40)

	colors.white_orange = colors.white.mix(colors.orange, 50)
	colors.white_yellow = colors.white.mix(colors.yellow, 50)

	colors.light_red = colors.red.lighten(50)
	colors.light_orange = colors.orange.lighten(50)
	colors.light_yellow = colors.yellow.lighten(50)
	colors.light_green = colors.green.lighten(50)
	colors.light_blue = colors.blue.lighten(50)
	colors.light_purple = colors.purple.lighten(30)

	colors.light_pink = colors.pink.lighten(10)
	colors.light_magenta = colors.magenta.lighten(40)

	colors.dark_yellow = colors.yellow.darken(50)
	colors.dark_white_yellow = colors.white_yellow.darken(20)

	colors.gray = colors.white.mix(colors.black, 90)
	colors.light_gray1 = colors.gray.lighten(90)
	colors.light_gray2 = colors.gray.lighten(80)
	colors.light_gray3 = colors.gray.lighten(70)
	colors.light_gray4 = colors.gray.lighten(60)
	colors.dark_gray1 = colors.gray.darken(60)
	colors.dark_gray2 = colors.gray.darken(50)
	colors.dark_gray3 = colors.gray.darken(20)
	colors.dark_gray4 = colors.gray.lighten(10)

	return vim.tbl_deep_extend("force", colors, palette)
end

return {
	get = generate_palette,
}
