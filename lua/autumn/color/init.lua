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
	bright = bright or 50
	dim = dim or 50

	local c = {
		base = hsl(base),
	}

	c.bright = type(bright) == "number" and c.base.lighten(bright) or hsl(bright)
	c.dim = type(dim) == "number" and c.base.darken(dim) or hsl(dim)

	setmetatable(c, self)
	self.__index = self

	return c
end

return M
