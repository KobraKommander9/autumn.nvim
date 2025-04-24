local Color = require("autumn.color")

local function make(base, dim, bright)
	local c = {
		base = Color(base),
		dim = dim and Color(dim) or base:darken(50),
		bright = bright and Color(bright) or base:lighten(50),
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
	-- gray = make("#aea6a6", "#797474", "#e2dada"),

	primary = make("#eb5e28", "#a4411c", "#ef7e53"),
	secondary = make("#6a8532", "#4a5d23", "#879d5b"),

	red = make("#eb2852", "#a41c39", "#ef5374"),
	green = make("#28eb58", "#1ca43d", "#53ef79"),
	yellow = make("#ebc128", "#a4871c", "#efcd53"),
	blue = make("#28b4eb", "#1c7da4", "#53c3ef"),
	magenta = make("#7f5fac", "#584278", "#987fbc"),
	cyan = make("#4bc6b9", "#348a81", "#6fd1c7"),
}

palette.gray = make(
	palette.white.mix(palette.black, 90),
	palette.white.dim.mix(palette.black.dim, 90),
	palette.white.bright.mix(palette.black.bright, 90)
)

palette.bg0 = make(palette.gray.darken(60))
palette.bg1 = make(palette.gray.darken(50))
palette.bg2 = make(palette.gray.darken(20))
palette.bg3 = make(palette.gray.darken(10))

palette.fg0 = make(palette.gray.lighten(90))
palette.fg1 = make(palette.gray.lighten(80))
palette.fg2 = make(palette.gray.lighten(70))
palette.fg3 = make(palette.gray.lighten(60))

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
	}

	spec.syntax = {}

	spec.diag = {
		error = p.red.bright,
		warn = p.yelow.bright,
		info = p.blue.bright,
		hint = p.magenta.bright,
		ok = p.green.bright,
	}

	spec.diff = {
		add = p.green,
		delete = p.red,
		change = p.blue,
		text = p.magenta.bright,
	}

	spec.git = {
		add = p.green,
		removed = p.red.bright,
		changed = p.blue.bright,
		conflict = p.orange.bright,
		ignored = p.gray.bright,
	}

	return spec
end

return {
	palette = palette,
	generate_spec = generate_spec,
}
