local Color = require("autumn.color")
local colors = require("autumn.palette.colors")

local meta = {
	name = "autumn",
	light = false,
}

local palette = colors({
	white = Color("#f4ebbe"),
	black = Color("#272d2d"),
	red = Color("#800e13"),
	orange = Color("#f27f34"),
	yellow = Color("#edd83d"),
	green = Color("#799431"),
	blue = Color("#1c77c3"),
	purple = Color("#846b8a", { bm = 30 }),
	pink = Color("#d65780", { bm = 10 }),
	magenta = Color("#a23b72", { bm = 40 }),
	cyan = Color("#4bc6b9"),

	primary = Color("#eb5e28"),
	secondary = Color("#6a8532"),
})

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

		p0 = p.primary,
		p1 = p.primary1,
		p2 = p.primary2,

		s0 = p.secondary,
		s1 = p.secondary1,
		s2 = p.secondary2,
	}

	spec.syntax = {
		bracket = p.white,
		builtin0 = p.pink.bright, -- builtin variable
		builtin1 = spec.p1, -- builtin type
		builtin2 = p.magenta.bright, -- builtin const
		comment = p.comment,
		conditional = spec.p1, -- conditional and loop
		const = p.magenta.bright, -- constants, imports, boolean
		dep = spec.fg3, -- deprecated
		field = p.orange,
		func = spec.s2,
		ident = spec.s1,
		keyword = spec.p2,
		number = p.magenta.bright,
		operator = spec.p2,
		preproc = spec.p0,
		regex = p.blue.bright,
		statement = spec.p2,
		string = p.green.bright,
		type = spec.p1,
		variable = p.white,
	}

	spec.diag = {
		error = p.red.bright,
		warn = p.yellow.bright,
		info = p.blue.bright,
		hint = p.purple.bright,
		ok = p.green.bright,
	}

	spec.diff = {
		add = p.green,
		delete = p.red.bright,
		change = p.blue.bright,
		text = p.cyan.dim,
	}

	spec.git = {
		add = p.green,
		removed = p.red.bright,
		changed = p.blue.bright,
		conflict = p.orange,
		ignored = p.comment,
	}

	return spec
end

return {
	meta = meta,
	palette = palette,
	generate_spec = generate_spec,
}
