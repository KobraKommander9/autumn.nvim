local hsl = require("autumn.color.hsl")

local M = {}

function M.new(base, bright, dim)
	local c = setmetatable({}, {
		__index = function(self, key)
			if self[key] then
				return self[key]
			end

			return self.base[key]
		end,
	})

	bright = bright or 50
	dim = dim or 50

	c.base = hsl(base)
	c.bright = type(bright) == "number" and c.base.lighten(bright) or hsl(bright)
	c.dim = type(dim) == "number" and c.base.darken(dim) or hsl(dim)

	return c
end

return M
