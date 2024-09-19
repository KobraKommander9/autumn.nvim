local Color = require("autumn.color")
local colors = require("autumn.palette.colors")

local meta = {
  name = "autumn",
  light = false,
}

local palette = colors({
  white = Color.new("#f4ebbe"),
  black = Color.new("#272d2d"),
  red = Color.new("#800e13"),
  orange = Color.new("#f27f34"),
  yellow = Color.new("#edd83d"),
  green = Color.new("#799431"),
  blue = Color.new("#1c77c3"),
  purple = Color.new("#846b8a", 30),
  pink = Color.new("#d65780", 10),
  magenta = Color.new("#a23b72", 40),
  cyan = Color.new("#4bc6b9"),

  primary = Color.new("#eb5e28"),
  secondary = Color.new("#6a8532"),
})

palette.gray = Color.new(palette.white.mix(palette.black, 90))

palette.comment = palette.gray.lighten(60).hex

palette.bg0 = palette.gray.darken(60).hex
palette.bg1 = palette.gray.darken(50).hex
palette.bg2 = palette.gray.darken(20).hex
palette.bg3 = palette.gray.lighten(10).hex

palette.fg0 = palette.gray.lighten(90).hex
palette.fg1 = palette.gray.lighten(80).hex
palette.fg2 = palette.gray.lighten(70).hex
palette.fg3 = palette.gray.lighten(60).hex

palette.primary1 = palette.primary.lighten(10).hex
palette.primary2 = palette.primary.lighten(20).hex

palette.secondary1 = palette.secondary.lighten(20).hex
palette.secondary2 = palette.secondary.lighten(40).hex

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

    p0 = p.primary.base,
    p1 = p.primary1,
    p2 = p.primary2,

    s0 = p.secondary.base,
    s1 = p.secondary1,
    s2 = p.secondary2,

    sel0 = p.gray.bright,
  }

  spec.syntax = {
    bracket = p.white.base,
    builtin0 = p.pink.bright,    -- builtin variable
    builtin1 = spec.p1,          -- builtin type
    builtin2 = p.magenta.bright, -- builtin const
    comment = p.comment,
    conditional = spec.p1,       -- conditional and loop
    const = p.magenta.bright,    -- constants, imports, boolean
    dep = spec.fg3,              -- deprecated
    field = p.orange.base,
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
    variable = p.white.base,
  }

  spec.diag = {
    error = p.red.bright,
    warn = p.yellow.bright,
    info = p.orange.bright,
    hint = p.blue.bright,
    ok = p.green.bright,
  }

  spec.diff = {
    add = p.green.base,
    delete = p.red.bright,
    change = p.blue.bright,
    text = p.cyan.dim,
  }

  spec.git = {
    add = p.green.base,
    removed = p.red.bright,
    changed = p.blue.bright,
    conflict = p.orange.base,
    ignored = p.comment,
  }

  return spec
end

return {
  meta = meta,
  palette = palette,
  generate_spec = generate_spec,
}
