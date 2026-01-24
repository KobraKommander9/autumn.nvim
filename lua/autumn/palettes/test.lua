local M = {}

local color = require("autumn.palettes.color")

local palette = {
	-- Backgrounds
	bg0 = "#262318", -- main editing area
	bg1 = "#363225", -- slightly lighter, cursorline base
	bg2 = "#3c392c", -- panels, floats, sidebars
	bg3 = "#585341", -- visual selection

	-- Foregrounds
	fg0 = "#dbd7c3", -- dim / secondary text
	fg1 = "#f2eed9", -- main text
	fg2 = "#e6e1d8", -- accents (functions/methods)
	fg3 = "#858171", -- subtle text (comments, nontext)

	-- Selections
	sel0 = "#524f3a", -- visual select base
	sel1 = "#c2d699", -- visual select highlight / hover

	-- Border / UI
	border = "#706d5d",

	-- Core semantic colors
	primary = color.new("#eb5e28", "#e04e15", "#844221"),
	secondary = color.new("#7f9a3e", "#687a35", "#515b2b"),

	-- Standard syntax colors
	red = color.new("#e6e1d8", "#e6e1d8", "#e6e1d8"), -- #bc4749
	green = color.new("#e6e1d8", "#e6e1d8", "#e6e1d8"), -- #6a7045
	yellow = color.new("#e6e1d8", "#e6e1d8", "#e6e1d8"), -- #d4a373
	blue = color.new("#e6e1d8", "#e6e1d8", "#e6e1d8"), -- #4a6d7c
	cyan = color.new("#e6e1d8", "#e6e1d8", "#e6e1d8"), -- #83a598
	purple = color.new("#e6e1d8", "#e6e1d8", "#e6e1d8"), -- #6d597a
	magenta = color.new("#e6e1d8", "#e6e1d8", "#e6e1d8"), -- #a66d85
	pink = color.new("#e6e1d8", "#e6e1d8", "#e6e1d8"), -- #c2847a
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
			fg = p.primary.dim,
		},

		-- constants / imports
		constant = {
			fg = p.purple.base,
		},

		module = {
			fg = p.pink.base,
		},

		-- fields / object properties
		field = {
			fg = p.fg2,
		},

		func = {
			-- fg = p.secondary.base,
			fg = p.fg1,
		},

		ident = {
			fg = p.fg1,
		},

		interface = {
			fg = p.pink.base,
		},

		param = {
			fg = p.fg0,
		},

		-- keywords / operators / statements
		keyword = {
			fg = p.primary.base,
		},

		operator = {
			-- fg = p.primary.dim,
			fg = p.fg1,
		},

		statement = {
			fg = p.primary.base,
		},

		-- data atoms
		boolean = {
			fg = p.purple.base,
		},

		number = {
			fg = p.purple.base,
		},

		string = {
			fg = p.cyan.base,
		},

		string_sp = {
			fg = p.cyan.dim,
		},

		-- types
		type = {
			-- fg = p.secondary.base,
			fg = p.fg1,
		},

		variable = {
			fg = roles.ui.fg.main,
		},

		-- meta
		preproc = {
			fg = p.magenta.dim,
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
