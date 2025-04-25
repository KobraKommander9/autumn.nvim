local C = require("autumn.color")

local function make(base, dim, bright)
	local c = {
		base = C(base),
		dim = dim and C(dim) or base.darken(50),
		bright = bright and C(bright) or base.lighten(50),
	}

	return setmetatable({}, {
		__index = function(_, key)
			if c[key] then
				return c[key]
			end
			return c.base[key]
		end,
	})
end

local palette = {
	white = make("#f4ebbe", "#aaa485", "#fbf7e4"),
	black = make("#272d2d", "#1b1f1f", "#525757"),

	primary = make("#eb5e28", "#a4411c", "#ef7e53"),
	secondary = make("#6a8532", "#4a5d23", "#879d5b"),

	red = make("#eb2852", "#a41c39", "#ef5374"),
	green = make("#28eb58", "#1ca43d", "#53ef79"),
	yellow = make("#ebc128", "#a4871c", "#efcd53"),
	blue = make("#28b4eb", "#1c7da4", "#53c3ef"),
	magenta = make("#7f5fac", "#584278", "#987fbc"),
	cyan = make("#4bc6b9", "#348a81", "#6fd1c7"),
	pink = make("#f990a7", "#ae6474", "#faa6b8"),
}

palette.gray = make(
	palette.white.mix(palette.black, 90),
	palette.white.dim.mix(palette.black.dim, 90),
	palette.white.bright.mix(palette.black.bright, 90)
)

palette.bg0 = make(palette.gray.darken(60))
palette.bg1 = make(palette.gray.darken(50))
palette.bg2 = make(palette.gray.darken(20))
palette.bg3 = make(palette.gray.lighten(10))
palette.bg4 = make(palette.gray.lighten(20))

palette.fg0 = make(palette.gray.lighten(90))
palette.fg1 = make(palette.gray.lighten(80))
palette.fg2 = make(palette.gray.lighten(70))
palette.fg3 = make(palette.gray.lighten(60))

palette.comment = make(palette.bg1.mix(palette.fg1, 40))

local function generate_spec(p)
	local spec = {
		bg0 = p.bg0.hex, -- dark bg (status line and float)
		bg1 = p.bg1.hex, -- default bg
		bg2 = p.bg2.hex, -- lighter bg (colorcolumn folds)
		bg3 = p.bg3.hex, -- lighter bg (cursor line)
		bg4 = p.bg4.hex, -- conceal, border fg

		fg0 = p.fg0.hex, -- lighter fg
		fg1 = p.fg1.hex, -- default fg
		fg2 = p.fg2.hex, -- darker fg (status line)
		fg3 = p.fg3.hex, -- darker fg (line numbers, fold columns)

		p0 = p.primary.hex,
		p1 = p.primary.dim.hex,
		p2 = p.primary.bright.hex,

		s0 = p.secondary.hex,
		s1 = p.secondary.dim.hex,
		s2 = p.secondary.bright.hex,

		sel0 = p.gray.bright.hex, -- popup bg, visual selection bg
		sel1 = p.white.bright.hex, -- popup sel bg, search bg
	}

	spec.syntax = {
		bracket = spec.p0, -- brackets and punctuation
		builtin0 = spec.p0, -- builtin variable
		builtin1 = spec.p0, -- builtin type
		builtin2 = spec.p0, -- builtin const
		builtin3 = spec.p0, -- not used
		comment = spec.p0, -- comment
		conditional = spec.p0, -- conditional and loop
		const = spec.p0, -- constants, imports, and booleans
		dep = spec.p0, -- deprecated
		field = spec.p0, -- field
		func = spec.p0, -- functions and titles
		ident = spec.p0, -- identifiers
		keyword = spec.p0, -- keywords
		number = spec.p0, -- numbers
		operator = spec.p0, -- operators
		preproc = spec.p0, -- preprocessor
		regex = spec.p0, -- regex
		statement = spec.p0, -- statements
		string = spec.p0, -- strings
		type = spec.p0, -- types
		variable = spec.p0, -- variables
		-- bracket = spec.fg2, -- brackets and punctuation
		-- builtin0 = p.red.hex, -- builtin variable
		-- builtin1 = spec.p0, -- builtin type
		-- builtin2 = p.cyan.hex, -- builtin const
		-- builtin3 = p.red.bright.hex, -- not used
		-- comment = p.comment.hex, -- comment
		-- conditional = p.magenta.bright.hex, -- conditional and loop
		-- const = p.cyan.hex, -- constants, imports, and booleans
		-- dep = spec.fg3, -- deprecated
		-- field = spec.s0, -- field
		-- func = spec.s2, -- functions and titles
		-- ident = spec.p0, -- identifiers
		-- keyword = p.magenta.hex, -- keywords
		-- number = p.cyan.hex, -- numbers
		-- operator = spec.fg2, -- operators
		-- preproc = p.pink.hex, -- preprocessor
		-- regex = p.yellow.hex, -- regex
		-- statement = p.magenta.hex, -- statements
		-- string = p.blue.hex, -- strings
		-- type = p.yellow.hex, -- types
		-- variable = p.white.hex, -- variables
	}

	spec.diag = {
		error = p.red.bright.hex,
		warn = p.yellow.bright.hex,
		info = p.blue.bright.hex,
		hint = p.magenta.bright.hex,
		ok = p.green.bright.hex,
	}

	spec.diag_bg = {
		error = C(spec.bg1).mix(C(spec.diag.error), 15).hex,
		warn = C(spec.bg1).mix(C(spec.diag.warn), 15).hex,
		info = C(spec.bg1).mix(C(spec.diag.info), 15).hex,
		hint = C(spec.bg1).mix(C(spec.diag.hint), 15).hex,
		ok = C(spec.bg1).mix(C(spec.diag.ok), 15).hex,
	}

	spec.diff = {
		add = C(spec.bg1).mix(p.green.bright, 45).hex,
		delete = C(spec.bg1).mix(p.red.bright, 45).hex,
		change = C(spec.bg1).mix(p.blue.bright, 45).hex,
		text = C(spec.bg1).mix(p.cyan.bright, 90).hex,
	}

	spec.git = {
		add = p.green.hex,
		removed = p.red.bright.hex,
		changed = p.blue.bright.hex,
		conflict = p.yellow.bright.hex,
		ignored = p.gray.bright.hex,
	}

	return spec
end

return {
	palette = palette,
	generate_spec = generate_spec,
}
