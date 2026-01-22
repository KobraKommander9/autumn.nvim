local M = {}

local color = require("autumn.palettes.color")

local palette = {
	-- Backgrounds
	bg0 = "#141311",
	bg1 = "#191815",
	bg2 = "#272621",
	bg3 = "#57544a",

	-- Foregrounds
	fg0 = "#f3f1ed",
	fg1 = "#dbd7cf",
	fg2 = "#c4bdb1",
	fg3 = "#aca393",

	-- Selections
	sel0 = "#3c3e3a",
	sel1 = "#fbf7e4",

	-- Border / UI
	border = "#746b5b",

	-- Core semantic colors
	primary = color.new("#ef7e53", "#eb5e28", "#a4411c"),
	secondary = color.new("#879d5b", "#6a8532", "#4a5d23"),

	-- Standard syntax colors
	red = color.new("#ef5374", "#eb2852", "#a41c39"),
	green = color.new("#53ef79", "#28eb58", "#1ca43d"),
	yellow = color.new("#efcd53", "#ebc128", "#a4871c"),
	blue = color.new("#53c3ef", "#28b4eb", "#1c7da4"),
	cyan = color.new("#6fd1c7", "#4bc6b9", "#348a81"),
	purple = color.new("#987fbc", "#7f5fac", "#584278"),
	magenta = color.new("#cd53fb", "#c128fb", "#871caf"),
	pink = color.new("#faa6b8", "#f990a7", "#ae6474"),
}

function M.get(p)
	local roles = {}

	roles.ui = {
		bg = {
			main = p.bg1, -- Old spec.bg1 (Default BG)
			alt = p.bg0, -- Old spec.bg0 (Sidebar/Status)
		},
	}

	roles.syntax = {
		bracket = {
			fg = p.sel1,
		},

		punctuation = {
			fg = p.sel1,
		},

		builtin_type = {
			fg = p.yellow.base,
		},

		builtin_func = {
			fg = p.blue.base,
		},

		builtin_var = {
			fg = p.blue.base,
		},

		field = {
			fg = p.secondary.base,
		},

		func = {
			fg = p.pink.dim,
		},

		ident = {
			fg = p.pink.dim,
		},

		interface = {
			fg = p.primary.base,
		},

		keyword = {
			fg = p.primary.dim,
		},

		operator = {
			fg = p.sel1,
		},

		statement = {
			fg = p.green.base,
		},

		tag = {
			fg = p.primary.dim,
		},

		string = {
			fg = p.cyan.dim,
		},

		string_sp = {
			fg = p.blue.dim,
		},

		type = {
			fg = p.primary.base,
		},

		preproc = {
			fg = p.secondary.dim,
		},

		regex = {
			fg = p.blue.dim,
		},

		module = {
			fg = p.magenta.dim,
		},
	}

	roles.markup = {
		raw = {
			fg = p.cyan.dim,
		},
	}

	return roles
end

M.palette = palette

return M
