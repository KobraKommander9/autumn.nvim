local M = {}

function M.build(roles, _)
	local terminal = require("vintage-rose.group.terminal").get(roles)

	return string.format(
		[[
[colors]
background = "%s"
foreground = "%s"
cursor_bg = "%s"
ansi = ["%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s"]
brights = ["%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s"]
]],
		roles.ui.bg.main,
		roles.ui.fg.main,
		roles.ui.bg.alt,
		-- ansi
		terminal.terminal_color_8.fg,
		terminal.terminal_color_9.fg,
		terminal.terminal_color_10.fg,
		terminal.terminal_color_11.fg,
		terminal.terminal_color_12.fg,
		terminal.terminal_color_13.fg,
		terminal.terminal_color_14.fg,
		terminal.terminal_color_15.fg,
		-- brights
		terminal.terminal_color_0.fg,
		terminal.terminal_color_1.fg,
		terminal.terminal_color_2.fg,
		terminal.terminal_color_3.fg,
		terminal.terminal_color_4.fg,
		terminal.terminal_color_5.fg,
		terminal.terminal_color_6.fg,
		terminal.terminal_color_7.fg
	)
end

function M.path(path)
	path = path or "~/.config/wezterm/colors/vintage-rose.toml"
	return vim.fn.expand(path)
end

return M
