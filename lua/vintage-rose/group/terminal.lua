local M = {}

function M.get(roles, _)
	local p = roles.palette

	return {
		terminal_color_0 = { fg = roles.ui.bg.main },
		terminal_color_8 = { fg = p.purple.dim },
		terminal_color_1 = { fg = p.red.base },
		terminal_color_9 = { fg = p.primary.base },
		terminal_color_2 = { fg = p.green.dim },
		terminal_color_10 = { fg = p.green.base },
		terminal_color_3 = { fg = p.secondary.base },
		terminal_color_11 = { fg = p.yellow.base },
		terminal_color_4 = { fg = p.blue.base },
		terminal_color_12 = { fg = p.cyan.base },
		terminal_color_5 = { fg = p.purple.base },
		terminal_color_13 = { fg = p.magenta.base },
		terminal_color_6 = { fg = p.cyan.base },
		terminal_color_14 = { fg = p.blue.base },
		terminal_color_7 = { fg = roles.ui.fg.dim },
		terminal_color_15 = { fg = roles.ui.fg.main },
	}
end

return M
