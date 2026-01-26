local M = {}

function M.build(roles, groups)
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
		groups.terminal_color_8,
		groups.terminal_color_9,
		groups.terminal_color_10,
		groups.terminal_color_11,
		groups.terminal_color_12,
		groups.terminal_color_13,
		groups.terminal_color_14,
		groups.terminal_color_15,
		-- brights
		groups.terminal_color_0,
		groups.terminal_color_1,
		groups.terminal_color_2,
		groups.terminal_color_3,
		groups.terminal_color_4,
		groups.terminal_color_5,
		groups.terminal_color_6,
		groups.terminal_color_7
	)
end

function M.path(path)
	path = path or "~/.config/wezterm/colors/vintage-rose.toml"
	return vim.fn.expand(path)
end

return M
