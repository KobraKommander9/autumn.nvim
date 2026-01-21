local M = {}

local function get_style(opt, def)
	return opt and opt or (def or "NONE")
end

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
			style = get_style(styles.types),
		},

		builtin_func = {
			fg = p.blue.base,
			style = get_style(styles.functions),
		},

		builtin_var = {
			fg = p.primary.dim,
			style = get_style(styles.variables),
		},

		-- comments
		comment = {
			fg = roles.ui.fg.subtle,
			style = get_style(styles.comments, "italic"),
		},

		-- conditionals / loops
		control = {
			fg = p.primary.dim,
			style = get_style(styles.flows),
		},

		-- constants / imports
		constant = {
			fg = p.purple.base,
			style = get_style(styles.constants),
		},

		module = {
			fg = p.magenta.base,
			style = get_style(styles.modules),
		},

		-- fields / object properties
		field = {
			fg = p.fg2,
			style = get_style(styles.fields),
		},

		func = {
			fg = p.secondary.base,
			style = get_style(styles.functions),
		},

		ident = {
			fg = p.fg1,
			style = get_style(styles.identifiers, "italic"),
		},

		interface = {
			fg = p.magenta.dim,
			style = get_style(styles.interfaces),
		},

		param = {
			fg = p.fg0,
			style = get_style(styles.parameters, "italic"),
		},

		-- keywords / operators / statements
		keyword = {
			fg = p.primary.base,
			style = get_style(styles.keywords, "bold"),
		},

		operator = {
			fg = p.primary.dim,
			style = get_style(styles.operators),
		},

		statement = {
			fg = p.primary.base,
			style = get_style(styles.statements),
		},

		tag = {
			fg = p.primary.base,
			style = get_style(styles.keywords, "bold"),
		},

		-- data atoms
		boolean = {
			fg = p.purple.base,
			style = get_style(styles.booleans),
		},

		number = {
			fg = p.purple.base,
			style = get_style(styles.numbers),
		},

		string = {
			fg = p.cyan.base,
			style = get_style(styles.strings),
		},

		string_sp = {
			fg = p.cyan.dim,
			style = get_style(styles.strings),
		},

		-- types
		type = {
			fg = p.secondary.base,
			style = get_style(styles.types),
		},

		variable = {
			fg = roles.ui.fg.main,
			style = get_style(styles.variables),
		},

		-- meta
		preproc = {
			fg = p.magenta.dim,
			style = get_style(styles.preprocs),
		},

		regex = {
			fg = p.yellow.base,
		},

		-- status
		deprecated = {
			fg = p.fg3,
			style = get_style(styles.deprecated, "strikethrough"),
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
			style = get_style(styles.documentation, "italic"),
		},

		msg = {
			fg = p.fg1,
		},
	}

	roles.semantic = {
		error = {
			fg = p.red.base,
			style = get_style(styles.diagnostics, "italic,underline"),
		},

		warn = {
			fg = p.yellow.base,
			style = get_style(styles.diagnostics, "italic,underline"),
		},

		info = {
			fg = p.blue.base,
			style = get_style(styles.diagnostics, "italic,underline"),
		},

		hint = {
			fg = p.cyan.base,
			style = get_style(styles.diagnostics, "italic,underline"),
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
			style = get_style(styles.links, "underline"),
		},

		quote = {
			fg = p.fg0,
			style = "italic",
		},

		raw = { fg = p.cyan.base },

		underlined = {
			style = get_style(styles.links, "underline"),
		},
	}

	return roles
end

return M
