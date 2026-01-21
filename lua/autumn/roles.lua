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
			accent = p.bg3, -- high constrast (folds, visual search)
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
		builtin = {
			fg = p.blue.base,
			style = get_style(styles.builtins),
		},

		comment = {
			fg = roles.ui.fg.subtle,
			style = get_style(styles.comments, "italic"),
		},

		constant = {
			fg = p.purple.base,
			style = get_style(styles.constants),
		},

		control = {
			fg = p.primary.dim,
			style = get_style(styles.flows),
		},

		field = {
			fg = p.fg2,
			style = get_style(styles.fields),
		},

		func = {
			fg = p.secondary.base,
			style = get_style(styles.functions),
		},

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

		type = {
			fg = p.secondary.base,
			style = get_style(styles.types),
		},

		variable = {
			fg = roles.ui.fg.main,
			style = get_style(styles.variables),
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

		-- punctuation
		bracket = {
			fg = roles.ui.fg.main,
		},

		punctuation = {
			fg = roles.ui.fg.dim,
		},

		-- contracts / modules
		container = {
			interface = {
				fg = p.magenta.dim,
				style = get_style(styles.interfaces),
			},

			module = {
				fg = p.magenta.base,
				style = get_style(styles.modules),
			},
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
	}

	return roles
end

return M
