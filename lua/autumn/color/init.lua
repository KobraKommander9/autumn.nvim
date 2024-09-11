local hsl = require("autumn.color.hsl")

local M = {}

function M.new(base, bright, dim)
	bright = bright or 50
	dim = dim or 50

	base = hsl(base)
	bright = type(bright) == "number" and base.lighten(bright) or hsl(bright)
	dim = type(dim) == "number" and base.darken(dim) or hsl(dim)

	return setmetatable({}, {
		__index = function(_, key)
			if key == "base" then
				return base.hex
			elseif key == "bright" then
				return bright.hex
			elseif key == "dim" then
				return dim.hex
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
