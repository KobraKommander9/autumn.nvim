local M = {}

local color = require("autumn.palettes.color")

local palette = {
	-- Backgrounds
	bg0 = "#262318", -- main editing area
	bg1 = "#322f25", -- slightly lighter, cursorline base
	bg2 = "#3c392c", -- panels, floats, sidebars
	bg3 = "#585341", -- visual selection

	-- Foregrounds
	fg0 = "#dbd7c3", -- dim / secondary text
	fg1 = "#f2eed9", -- main text
	fg2 = "#d69981", -- accents (functions/methods)
	fg3 = "#858171", -- subtle text (comments, nontext)

	-- Selections
	sel0 = "#4a2b30", -- visual select base
	sel1 = "#8c4351", -- visual select highlight / hover
	sel2 = "#52363b", -- references

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
	magenta = color.new("#c678dd"),
	pink = color.new("#f7768e", "#965b67", "#3d262a"),
}

function M.get(p)
	local roles = {}

	roles.ui = {
		bg = {
			main = p.bg0,
			alt = p.bg1,
			float = p.bg2,
			visual = p.bg3,
		},

		fg = {
			main = p.fg1,
			dim = p.fg0,
			subtle = p.fg3,
		},

		selection = {
			bg = p.sel0,
			active = p.sel1,
			reference = p.sel2,
		},

		border = p.border,

		gutter = {
			bg = p.bg0,
			fg = p.fg3,
			active = p.primary.dim,
		},
	}

	roles.syntax = {
		-- punctuation
		bracket = {
			fg = roles.ui.fg.main,
		},

		punctuation = {
			fg = roles.ui.fg.dim,
		},

		-- builtins
		builtin_type = {
			fg = p.primary.base,
		},

		builtin_func = {
			fg = p.primary.base,
		},

		builtin_var = {
			fg = p.primary.base,
		},

		-- comments
		comment = {
			fg = roles.ui.fg.subtle,
		},

		-- conditionals / loops
		control = {
			fg = p.primary.base,
		},

		-- constants / imports
		constant = {
			fg = p.cyan.base,
		},

		module = {
			fg = p.purple.dim,
		},

		-- fields / object properties
		field = {
			fg = p.fg2,
		},

		func = {
			fg = p.secondary.base,
		},

		ident = {
			fg = p.fg1,
		},

		interface = {
			fg = p.purple.dim,
		},

		param = {
			fg = p.fg0,
		},

		-- keywords / operators / statements
		keyword = {
			fg = p.primary.base,
		},

		operator = {
			fg = p.secondary.dim,
		},

		statement = {
			fg = p.primary.base,
		},

		-- data atoms
		boolean = {
			fg = p.cyan.base,
		},

		number = {
			fg = p.cyan.base,
		},

		string = {
			fg = p.green.base,
		},

		string_sp = {
			fg = p.green.dim,
		},

		-- types
		type = {
			fg = p.secondary.base,
		},

		variable = {
			fg = roles.ui.fg.main,
		},

		-- meta
		preproc = {
			fg = p.magenta.base,
		},

		regex = {
			fg = p.yellow.base,
		},

		-- status
		deprecated = {
			fg = p.fg3,
		},
	}

	roles.emphasis = {
		high = { fg = p.primary.base },
		medium = { fg = p.primary.dim },
		low = { fg = p.fg0 },
		muted = { fg = p.fg3 },
	}

	roles.info = {
		documentation = {
			fg = roles.ui.fg.normal,
		},

		msg = {
			fg = roles.ui.fg.normal,
		},
	}

	roles.semantic = {
		error = {
			fg = p.red.base,
		},

		warn = {
			fg = p.yellow.base,
		},

		info = {
			fg = p.blue.base,
		},

		hint = {
			fg = p.cyan.base,
		},

		ok = {
			fg = p.green.base,
		},

		changed = {
			fg = p.yellow.base,
		},

		deleted = {
			fg = p.red.base,
		},

		success = {
			fg = p.green.base,
		},
	}

	roles.markup = {
		heading = {
			fg = p.primary.base,
		},

		link = {
			fg = p.blue.base,
		},

		quote = {
			fg = p.fg0,
		},

		raw = { fg = p.cyan.base },
	}

	return roles
end

M.palette = palette

return M
