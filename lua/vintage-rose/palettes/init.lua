local M = {}

local function get_style(opt, def)
	return opt and opt or (def or "NONE")
end

local function default_roles(p, styles)
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
			style = get_style(styles.types),
		},

		builtin_func = {
			fg = p.primary.base,
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
			fg = p.primary.base,
			style = get_style(styles.flows),
		},

		-- constants / imports
		constant = {
			fg = roles.ui.fg.main,
			style = get_style(styles.constants),
		},

		module = {
			fg = p.purple.dim,
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
			fg = p.purple.dim,
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
			fg = p.fg0,
			style = get_style(styles.operators),
		},

		statement = {
			fg = p.primary.base,
			style = get_style(styles.statements),
		},

		-- data atoms
		boolean = {
			fg = p.cyan.base,
			style = get_style(styles.booleans),
		},

		number = {
			fg = p.cyan.base,
			style = get_style(styles.numbers),
		},

		string = {
			fg = p.green.base,
			style = get_style(styles.strings),
		},

		string_sp = {
			fg = p.green.dim,
			style = get_style(styles.special, "italic"),
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
			fg = p.magenta.base,
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
			fg = roles.ui.fg.normal,
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

		ok = {
			fg = p.green.base,
			style = get_style(styles.diagnostics, "italic,underline"),
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

function M.load(opts)
	opts = opts or {}
	opts.palette = opts.palette and opts.palette or "dark"

	local p = require("vintage-rose.palettes." .. opts.palette)
	local palette = p.palette
	local roles = default_roles(palette, opts.styles)

	local get = p.get or function(_)
		return {}
	end

	roles = vim.tbl_deep_extend("force", roles, get(palette), opts.overrides or {})
	roles.palette = palette

	return require("vintage-rose.palettes.serializer").make(roles)
end

return M
