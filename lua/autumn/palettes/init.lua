local M = {}

local color = require("autumn.palettes.color")

local palette = {
	-- Backgrounds
	bg0 = "#262318", -- main editing area
	bg1 = "#322f25", -- slightly lighter, cursorline base
	bg2 = "#3c392c", -- panels, floats, sidebars
	bg3 = "#585341", -- visual selection
	bg4 = "#423d2b", -- surfaces (diff changes, lsp hover background)

	-- Foregrounds
	fg0 = "#b8b4a0", -- dim / secondary text
	fg1 = "#f2eed9", -- main text
	fg2 = "#d69981", -- accents (functions/methods)
	fg3 = "#616355", -- subtle text (comments, nontext)

	-- Selections
	sel0 = "#4a2b30", -- visual select base
	sel1 = "#8c4351", -- visual select highlight / hover

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
	magenta = color.new("#ad8ee6"),
	pink = color.new("#f7768e", "#965b67", "#3d262a"),
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
			surface = p.bg4,
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

		border = p.border,

		gutter = {
			bg = p.bg0,
			fg = p.fg3, -- line numbers
			active = p.primary.dim, -- current line number
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
			style = color.get_style(styles.types),
		},

		builtin_func = {
			fg = p.primary.base,
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
			fg = p.primary.base,
			style = color.get_style(styles.flows),
		},

		-- constants / imports
		constant = {
			fg = roles.ui.fg.main,
			style = color.get_style(styles.constants),
		},

		module = {
			fg = p.purple.dim,
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
			fg = p.purple.dim,
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
			fg = p.fg0,
			style = color.get_style(styles.operators),
		},

		statement = {
			fg = p.primary.base,
			style = color.get_style(styles.statements),
		},

		-- data atoms
		boolean = {
			fg = p.cyan.base,
			style = color.get_style(styles.booleans),
		},

		number = {
			fg = p.cyan.base,
			style = color.get_style(styles.numbers),
		},

		string = {
			fg = p.green.base,
			style = color.get_style(styles.strings),
		},

		string_sp = {
			fg = p.green.dim,
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
			fg = p.magenta.base,
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
			fg = roles.ui.fg.normal,
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

		added = {
			fg = p.green.base,
		},

		changed = {
			fg = p.yellow.base,
		},

		removed = {
			fg = p.red.base,
		},
	}

	roles.diff = {
		header = {
			fg = roles.syntax.type.fg,
			style = "bold",
		},

		meta = {
			fg = roles.ui.fg.subtle,
		},

		fragment = {
			fg = roles.syntax.module.fg,
		},

		old_file = { fg = roles.semantic.removed.fg },
		new_file = { fg = roles.semantic.added.fg },

		add = { bg = p.secondary.dim },
		delete = { bg = p.primary.dim },
		change = { bg = roles.ui.bg.surface },

		added = roles.semantic.added,
		changed = roles.semantic.changed,
		removed = roles.semantic.removed,

		plus = {
			fg = roles.semantic.added.fg,
			bg = p.green.dim,
			style = "bold",
		},

		minus = {
			fg = roles.semantic.removed.fg,
			bg = p.primary.dim,
			style = "bold",
		},

		text = {
			fg = p.cyan.base,
			bg = p.sel0,
			style = "bold",
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
