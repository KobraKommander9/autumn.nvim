local Color = require("autumn.color")

local M = {}

local function make(base, dim, bright)
	return setmetatable({
		base = Color(base),
		dim = Color(dim),
		bright = Color(bright),
	}, {
		__index = function(t, key)
			if t[key] then
				return t[key]
			end
			return t.base[key]
		end,
	})
end

local palette = {
	white = make("#f4ebbe", "#aaa485", "#fbf7e4"),
	black = make("#272d2d", "#1b1f1f", "#525757"),
	gray = make("#aea6a6", "#797474", "#e2dada"),
	primary = make("#eb5e28", "#a4411c", "#ef7e53"),
	secondary = make("#6a8532", "#4a5d23", "#879d5b"),
	red = make("#eb2852", "#a41c39", "#ef5374"),
	green = make("#28eb58", "#1ca43d", "#53ef79"),
	yellow = make("#ebc128", "#a4871c", "#efcd53"),
	blue = make("#28b4eb", "#1c7da4", "#53c3ef"),
	magenta = make("#7f5fac", "#584278", "#987fbc"),
	cyan = make("#4bc6b9", "#348a81", "#6fd1c7"),
}

return M
