local hsl = require("autumn.color.hsl")

local Color = setmetatable({}, {
	__index = function(self, key)
		if key == "dim" then
			return self.dim
		elseif key == "bright" then
			return self.bright
		end

		return self.base[key]
	end,

	__tostring = function(c)
		return tostring(c.base)
	end,

	__concat = function(lhs, rhs)
		return tostring(lhs) .. tostring(rhs)
	end,

	__call = function(self)
		return self
	end,
})

function Color:new(color, opts)
	local result = {
		base = hsl(color),
	}

	local bright_mod = opts and opts.bm or 50
	local dim_mod = opts and opts.dm or 50

	local bright = opts and opts.bright or result.base.lighten(bright_mod)
	local dim = opts and opts.dim or result.base.darken(dim_mod)

	result.bright = bright
	result.dim = dim

	setmetatable(result, {
		__index = self,
	})
	self.__index = self

	return result
end

function Color:extend(color)
	local opts = {}

	if type(color) == "table" then
		opts.dim = color.dim and hsl(color.dim)
		opts.bright = color.bright and hsl(color.bright)
		color = color.base or color
	end

	return Color:new(color, opts)
end

local M = {}

setmetatable(M, {
	__call = function(_, ...)
		return Color:new(...)
	end,
})

return M
