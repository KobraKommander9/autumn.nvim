local M = {}

function M.get(spec, _)
	local p = spec.palette

	return {
		terminal_color_0 = p.black.hex,
		terminal_color_8 = p.black.bright.hex,

		terminal_color_1 = p.red.hex,
		terminal_color_9 = p.red.bright.hex,

		terminal_color_2 = p.green.hex,
		terminal_color_10 = p.green.bright.hex,

		terminal_color_3 = p.yellow.hex,
		terminal_color_11 = p.yellow.bright.hex,

		terminal_color_4 = p.blue.hex,
		terminal_color_12 = p.blue.bright.hex,

		terminal_color_5 = p.magenta.hex,
		terminal_color_13 = p.magenta.bright.hex,

		terminal_color_6 = p.cyan.hex,
		terminal_color_14 = p.cyan.bright.hex,

		terminal_color_7 = p.white.hex,
		terminal_color_15 = p.white.bright.hex,
	}
end

return M
