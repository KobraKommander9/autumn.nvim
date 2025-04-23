local hsl = require("autumn.color.hsl")

local M = {}

setmetatable(M, {
	__call = function(_, ...)
		return hsl(...)
	end,
})

return M
