local M = {}

local function get_style(opt, def)
	return opt and opt or (def or "NONE")
end

function M.get(p, styles)
	styles = styles or {}

	local roles = {}

	roles.ui = {
		bg = {
			base = p.bg0,
			raised = p.bg1,
			panel = p.bg2,
			selection = p.bg3,
		},

		fg = {
			normal = p.fg1,
			dim = p.fg0,
			subtle = p.fg3,
			cool = p.fg2,
		},

		border = {
			normal = p.border,
			focus = p.sel1,
		},
	}

	roles.emphasis = {
		high = {
			fg = p.primary.base,
			style = get_style(styles.emphasis_high, "bold"),
		},

		medium = {
			fg = p.primary.dim,
			style = get_style(styles.emphasis_medium),
		},

		low = {
			fg = p.fg3,
			style = get_style(styles.emphasis_low),
		},

		muted = {
			fg = p.fg0,
			style = get_style(styles.emphasis_muted, "italic"),
		},
	}

	roles.text = {
		comment = {
			fg = roles.ui.fg.subtle,
			style = get_style(styles.comments, "italic"),
		},

		dim = {
			fg = roles.ui.fg.dim,
		},

		documentation = {
			fg = roles.ui.fg.normal,
			style = get_style(styles.documentation, "italic"),
		},

		normal = {
			fg = roles.ui.fg.normal,
		},

		punctuation = {
			fg = roles.ui.fg.normal,
		},

		subtle = {
			fg = roles.ui.fg.subtle,
		},

		quote = {
			fg = p.cyan.base,
			style = get_style(styles.quotes, "italic"),
		},
	}

	roles.code = {
		contract = {
			interface = {
				fg = p.magenta.dim,
				style = get_style(styles.contracts),
			},

			module = {
				fg = p.magenta.base,
				style = get_style(styles.contracts),
			},
		},

		control = {
			flow = {
				fg = p.primary.dim,
				style = get_style(styles.flows),
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
		},

		system = {
			builtin = {
				base = {
					fg = p.blue.base,
					style = get_style(styles.preprocs),
				},

				dim = {
					fg = p.blue.dim,
					style = get_style(styles.preprocs),
				},
			},

			data = {
				boolean = {
					fg = p.purple.base,
					style = get_style(styles.booleans),
				},

				constant = {
					fg = p.purple.base,
					style = get_style(styles.constants),
				},

				number = {
					fg = p.purple.base,
					style = get_style(styles.numbers),
				},

				string = {
					fg = p.cyan.base,
					style = get_style(styles.strings),
				},
			},
		},

		user = {
			type = {
				base = {
					fg = p.secondary.base,
					style = get_style(styles.types),
				},

				dim = {
					fg = p.secondary.dim,
					style = get_style(styles.types),
				},
			},

			field = {
				fg = roles.ui.normal,
				style = get_style(styles.fields),
			},

			func = {
				fg = p.secondary.base,
				style = get_style(styles.functions),
			},

			variable = {
				fg = roles.ui.fg.normal,
				style = get_style(styles.variables),
			},
		},
	}

	roles.info = {
		base = {
			fg = p.blue.base,
		},

		link = {
			fg = p.blue.base,
			style = get_style(styles.links, "italic,underline"),
		},
	}

	roles.diagnostics = {
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
	}

	roles.diff = {
		add = {
			fg = p.green.dim,
		},

		del = {
			fg = p.red.dim,
		},

		change = {
			fg = p.yellow.dim,
		},

		text = {
			fg = p.primary.dim,
		},
	}

	return roles
end

return M
