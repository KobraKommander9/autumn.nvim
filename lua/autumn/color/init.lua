local hsl = require("autumn.color.hsl")

local M = {}

M.__index = function(self, key)
	if self[key] then
		return self[key]
	end

	return self.base[key]
end

M.__call = function(self)
	return self.base
end

function M.new(base, bright, dim)
	local self = setmetatable({}, M)

	bright = bright or 50
	dim = dim or 50

	self.base = hsl(base)
	self.bright = type(bright) == "number" and self.base.lighten(bright) or hsl(bright)
	self.dim = type(dim) == "number" and self.base.darken(dim) or hsl(dim)

	return self
end

return M
