local M = {}

local color = require("autumn.palettes.color")

local palette = {
	-- Backgrounds
	bg0 = "#1a1d16", -- main editing area
	bg1 = "#23281e", -- slightly lighter, cursorline base
	bg2 = "#2a2f23", -- panels, floats, sidebars
	bg3 = "#38422f", -- visual selection

	-- Foregrounds
	fg0 = "#b8b2a7", -- dim / secondary text
	fg1 = "#e6e1d8", -- main text
	fg2 = "#6b8fa3", -- accents (functions/methods)
	fg3 = "#8f8a80", -- subtle text (comments, nontext)

	-- Selections
	sel0 = "#38422f", -- visual select base
	sel1 = "#414d36", -- visual select highlight / hover

	-- Border / UI
	border = "#3a372f",

	-- Core semantic colors
	primary = color.new("#eb5e28", "#7a341e", "#5f3a1c"),
	secondary = color.new("#7f9a3e", "#4f6430", "#3b4a21"),

	-- Standard syntax colors
	red = color.new("#c14f3b", "#7a2f28", "#4a1f1c"),
	green = color.new("#9bbf4f", "#5f7a2e", "#2f4a21"),
	yellow = color.new("#d6a45a", "#8f6437", "#4a4720"),
	blue = color.new("#6b8fa3", "#3d5e6e", "#2d4a57"),
	cyan = color.new("#5f9ea0", "#386869", "#2a5052"),
	purple = color.new("#7f5fac", "#4d3b74", "#352c4d"),
	magenta = color.new("#b36b7d", "#724653", "#543640"),
	pink = color.new("#f990a7", "#a65a6b", "#733f50"),
}

function M.get(p, styles)
	styles = styles or {}

	local roles = {}

	roles.ui = {
		bg = {
			main = p.bg0, -- standard editor background
			alt = p.bg1, -- sidebar / inactive windows
			float = p.bg2, -- popus, hover docs
			visual = p.bg3, -- high constrast (folds, visual search)
		},

		fg = {
			main = p.fg1, -- primary text
			dim = p.fg0, -- secondary/description text
			subtle = p.fg3, -- hidden/non-text (whitespaces/ eob)
		},

		selection = {
			bg = p.sel0,
			active = p.sel1, -- focused selection or "current match"
		},

		border = {
			base = p.border,
			focus = p.sel1,
		},

		gutter = {
			bg = p.bg0,
			fg = p.fg3, -- line numbers
			active = p.fg0, -- current line number
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
			fg = p.secondary.base,
			style = color.get_style(styles.types),
		},

		builtin_func = {
			fg = p.blue.base,
			style = color.get_style(styles.functions),
		},

		builtin_var = {
			fg = p.primary.dim,
			style = color.get_style(styles.variables),
		},

		-- comments
		comment = {
			fg = roles.ui.fg.subtle,
			style = color.get_style(styles.comments, "italic"),
		},

		-- conditionals / loops
		control = {
			fg = p.primary.dim,
			style = color.get_style(styles.flows),
		},

		-- constants / imports
		constant = {
			fg = p.purple.base,
			style = color.get_style(styles.constants),
		},

		module = {
			fg = p.magenta.base,
			style = color.get_style(styles.modules),
		},

		-- fields / object properties
		field = {
			fg = p.fg2,
			style = color.get_style(styles.fields),
		},

		func = {
			fg = p.secondary.base,
			style = color.get_style(styles.functions),
		},

		ident = {
			fg = p.fg1,
			style = color.get_style(styles.identifiers, "italic"),
		},

		interface = {
			fg = p.magenta.dim,
			style = color.get_style(styles.interfaces),
		},

		param = {
			fg = p.fg0,
			style = color.get_style(styles.parameters, "italic"),
		},

		-- keywords / operators / statements
		keyword = {
			fg = p.primary.base,
			style = color.get_style(styles.keywords, "bold"),
		},

		operator = {
			fg = p.primary.dim,
			style = color.get_style(styles.operators),
		},

		statement = {
			fg = p.primary.base,
			style = color.get_style(styles.statements),
		},

		tag = {
			fg = p.primary.base,
			style = color.get_style(styles.keywords, "bold"),
		},

		-- data atoms
		boolean = {
			fg = p.purple.base,
			style = color.get_style(styles.booleans),
		},

		number = {
			fg = p.purple.base,
			style = color.get_style(styles.numbers),
		},

		string = {
			fg = p.cyan.base,
			style = color.get_style(styles.strings),
		},

		string_sp = {
			fg = p.cyan.dim,
			style = color.get_style(styles.special, "italic"),
		},

		-- types
		type = {
			fg = p.secondary.base,
			style = color.get_style(styles.types),
		},

		variable = {
			fg = roles.ui.fg.main,
			style = color.get_style(styles.variables),
		},

		-- meta
		preproc = {
			fg = p.magenta.dim,
			style = color.get_style(styles.preprocs),
		},

		regex = {
			fg = p.yellow.base,
		},

		-- status
		deprecated = {
			fg = p.fg3,
			style = color.get_style(styles.deprecated, "strikethrough"),
		},
	}

	roles.emphasis = {
		high = { fg = p.primary.base, style = "bold" },
		medium = { fg = p.primary.dim },
		low = { fg = p.fg0 },
		muted = { fg = p.fg3, style = "italic" },
	}

	roles.info = {
		documentation = {
			fg = roles.ui.fg.normal,
			style = color.get_style(styles.documentation, "italic"),
		},

		msg = {
			fg = p.fg1,
		},
	}

	roles.semantic = {
		error = {
			fg = p.red.base,
			style = color.get_style(styles.diagnostics, "italic,underline"),
		},

		warn = {
			fg = p.yellow.base,
			style = color.get_style(styles.diagnostics, "italic,underline"),
		},

		info = {
			fg = p.blue.base,
			style = color.get_style(styles.diagnostics, "italic,underline"),
		},

		hint = {
			fg = p.cyan.base,
			style = color.get_style(styles.diagnostics, "italic,underline"),
		},

		ok = {
			fg = p.green.base,
			style = color.get_style(styles.diagnostics, "italic,underline"),
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
		bold = { style = "bold" },

		heading = {
			fg = p.primary.base,
			style = "bold",
		},

		italic = { style = "italic" },

		link = {
			fg = p.blue.base,
			style = color.get_style(styles.links, "underline"),
		},

		quote = {
			fg = p.fg0,
			style = "italic",
		},

		raw = { fg = p.cyan.base },

		underlined = {
			style = color.get_style(styles.links, "underline"),
		},
	}

	return roles
end

M.palette = palette

return M
