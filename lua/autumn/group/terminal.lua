local M = {}

function M.get(spec, _)
	local p = spec.palette

	return {
		terminal_color_0 = p.black,
		terminal_color_8 = p.black.bright,

		terminal_color_1 = p.red,
		terminal_color_9 = p.red.bright,

		terminal_color_2 = p.green,
		terminal_color_10 = p.green.bright,

		terminal_color_3 = p.yellow,
		terminal_color_11 = p.yellow.bright,

		terminal_color_4 = p.blue,
		terminal_color_12 = p.blue.bright,

		terminal_color_5 = p.magenta,
		terminal_color_13 = p.magenta.bright,

		terminal_color_6 = p.cyan,
		terminal_color_14 = p.cyan.bright,

		terminal_color_7 = p.white,
		terminal_color_15 = p.white.bright,
	}
end

return M
