local M = {}

local function color(base, dim, bg)
	local c = { base = base, dim = dim, bg = bg }

	return setmetatable(c, {
		__index = function(t, key)
			return rawget(t, key)
		end,
		__tostring = function(t)
			return t.base
		end,
	})
end

local palette = {
	-- Backgrounds (green gradient)
	bg0 = "#1a1d16", -- main editing area
	bg1 = "#23281e", -- slightly lighter, cursorline base
	bg2 = "#2a2f23", -- panels, floats, sidebars
	bg3 = "#38422f", -- visual selection

	-- Foregrounds
	fg0 = "#b8b2a7", -- dim / secondary text
	fg1 = "#e6e1d8", -- main text
	fg2 = "#6b8fa3", -- blue accents (functions/methods)
	fg3 = "#8f8a80", -- subtle text (comments, nontext)

	-- Selections
	sel0 = "#38422f", -- visual select base
	sel1 = "#414d36", -- visual select highlight / hover

	-- Border / UI
	border = "#3a372f",

	-- Core semantic colors
	primary = color("#eb5e28", "#7a341e", "#5f3a1c"), -- orange (keywords, control flow)
	secondary = color("#7f9a3e", "#4f6430", "#3b4a21"), -- olive green (types, traits)

	-- Standard syntax colors
	red = color("#c14f3b", "#7a2f28", "#4a1f1c"),
	green = color("#9bbf4f", "#5f7a2e", "#2f4a21"),
	yellow = color("#d6a45a", "#8f6437", "#4a4720"),
	blue = color("#6b8fa3", "#3d5e6e", "#2d4a57"),
	cyan = color("#5f9ea0", "#386869", "#2a5052"),
	purple = color("#7f5fac", "#4d3b74", "#352c4d"),
	magenta = color("#b36b7d", "#724653", "#543640"),
	pink = color("#f990a7", "#a65a6b", "#733f50"),
}

local function generate_spec(p)
	local spec = {
		bg0 = p.bg0,
		bg1 = p.bg1,
		bg2 = p.bg2,
		bg3 = p.bg3,

		fg0 = p.fg0,
		fg1 = p.fg1,
		fg2 = p.fg2,
		fg3 = p.fg3,

		sel0 = p.sel0,
		sel1 = p.sel1,

		border = p.border,

		primary = p.primary.base,
		secondary = p.secondary.base,
	}

	spec.syntax = {
		-- punctuation / brackets
		bracket = p.fg1.base,

		-- builtins
		builtin0 = p.blue.base, -- builtin variable
		builtin1 = p.secondary.base, -- builtin type
		builtin2 = p.purple.base, -- builtin const

		-- comments
		comment = p.fg3,

		-- conditionals / loops
		conditional = p.primary.base, -- keywords, if/else, loops

		-- constants / imports
		const = p.magenta.base, -- constants, enums, imports
		dep = p.fg0, -- deprecated symbols

		-- fields / object properties
		field = p.secondary.base, -- fields
		func = p.pink.base, -- function names
		ident = p.fg1, -- variable identifiers

		-- keywords / operators / statements
		keyword = p.primary.base, -- keywords
		operator = p.fg1, -- operators
		statement = p.green.dim, -- statements (control flow)

		-- numbers / booleans
		number = p.purple.base, -- numbers, booleans

		-- preprocessor, regex
		preproc = p.secondary.base, -- preprocessor directives
		regex = p.blue.dim, -- regex literals

		-- strings / types
		string = p.cyan.base, -- string literals
		type = p.secondary.base, -- types, classes, titles
		variable = p.fg1, -- plain variables
	}

	spec.diag = {
		error = p.red.base,
		warn = p.yellow.base,
		info = p.blue.base,
		hint = p.cyan.base,
		ok = p.green.base,
	}

	spec.diff = {
		add = p.green.bg,
		delete = p.red.bg,
		change = p.blue.bg,
		text = p.cyan.bg,
	}

	spec.git = {
		added = p.green.base,
		removed = p.red.base,
		changed = p.yellow.base,
		conflict = p.purple.base,
		ignored = p.fg3,
	}

	return spec
end

M.palette = palette
M.generate_spec = generate_spec

return M
