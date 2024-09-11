local hsl = require("autumn.color.hsl")

local M = {}

function M.new(base, bright, dim)
	base = hsl(base)
	bright = (bright or 50) and type(bright) == "number" and base.lighten(bright) or hsl(bright)
	dim = (dim or 50) and type(dim) == "number" and base.darken(dim) or hsl(dim)

	return setmetatable({}, {
		__index = function(_, key)
			if key == "base" then
				return base
			elseif key == "bright" then
				return bright
			elseif key == "dim" then
				return dim
			end

			return base[key]
		end,

		__newindex = function(_, _, _)
			error("Color is immutable", 2)
		end,
	})
end

setmetatable(M, {
	__call = function(_, ...)
		return M.new(...)
	end,
})

return M
