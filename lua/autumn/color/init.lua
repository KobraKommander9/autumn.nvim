local hsl = require("autumn.color.hsl")

local M = setmetatable({}, {
	__index = function(t, key)
		if t[key] then
			return t[key]
		end
		return t.base[key]
	end,
})

function M:new(base, bright, dim)
	base = hsl(base)
	bright = bright or 50
	dim = dim or 50

	local c = {
		base = base,
		bright = type(bright) == "number" and base.lighten(bright) or hsl(bright),
		dim = type(dim) == "number" and base.darken(dim) or hsl(dim),
	}

	setmetatable(c, self)
	self.__index = self

	return c
end

return M
