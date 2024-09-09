local hsl = require("autumn.gen.hsl")

local meta = {
	name = "autumn",
  light = false,
}

local palette = {
	white = hsl("#f4ebbe"),
	black = hsl("#272d2d"),
	red = hsl("#800e13"),
	orange = hsl("#f27f34"),
	yellow = hsl("#edd83d"),
	green = hsl("#799431"),
	blue = hsl("#1c77c3"),
	purple = hsl("#846b8a"),
	pink = hsl("#d65780"),
	magenta = hsl("#a23b72"),
  cyan = hsl("#4bc6b9"),

	primary0 = hsl("#eb5e28"),
	secondary0 = hsl("#6a8532"),
}

palette.gray = palette.white.mix(palette.black, 90)

palette.comment = palette.gray.lighten(60)

palette.bg0 = palette.gray.darken(60)
palette.bg1 = palette.gray.darken(50)
palette.bg2 = palette.gray.darken(20)
palette.bg3 = palette.gray.lighten(10)

palette.fg0 = palette.gray.lighten(90)
palette.fg1 = palette.gray.lighten(80)
palette.fg2 = palette.gray.lighten(70)
palette.fg3 = palette.gray.lighten(60)

palette.primary1 = palette.primary0.lighten(10)
palette.primary2 = palette.primary0.lighten(20)
palette.secondary1 = palette.secondary0.lighten(20)
palette.secondary2 = palette.secondary0.lighten(40)

palette.light_red = palette.red.lighten(50)
palette.light_orange = palette.orange.lighten(50)
palette.light_yellow = palette.yellow.lighten(50)
palette.light_green = palette.green.lighten(50)
palette.light_blue = palette.blue.lighten(50)
palette.light_purple = palette.purple.lighten(30)
palette.light_pink = palette.pink.lighten(10)
palette.light_magenta = palette.magenta.lighten(40)

palette.dark_cyan = palette.cyan.darken(50)

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

    p0 = p.primary0,
    p1 = p.primary1,
    p2 = p.primary2,

    s0 = p.secondary0,
    s1 = p.secondary1,
    s2 = p.secondary2,
  }

  spec.syntax = {
    bracket = p.white,
    builtin0 = p.light_pink, -- builtin variable
    builtin1 = spec.p1, -- builtin type
    builtin2 = p.light_magenta, -- builtin const
    comment = p.comment,
    conditional = spec.p1, -- conditional and loop
    const = p.light_magenta, -- constants, imports, boolean
    dep = spec.fg3, -- deprecated
    field = p.orange,
    func = spec.s2,
    ident = spec.s1,
    keyword = spec.p2,
    number = p.light_magenta,
    operator = spec.p2,
    preproc = spec.p0,
    regex = p.light_blue,
    statement = spec.p2,
    string = p.light_green,
    type = spec.p1,
    variable = p.white,
  }

  spec.diag = {
    error = p.light_red,
    warn = p.light_yellow,
    info = p.light_blue,
    hint = p.light_purple,
    ok = p.light_green,
  }

  spec.diff = {
    add = p.green,
    delete = p.light_red,
    change = p.light_blue,
    text = p.dark_cyan,
  }

  spec.git = {
    add = p.green,
    removed = p.light_red,
    changed = p.light_blue,
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
