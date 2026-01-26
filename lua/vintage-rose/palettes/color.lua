local M = {}

function M.new(base, dim, bg)
	local c = { base = base }

	c.dim = dim and dim or base
	c.bg = bg and bg or base

	return setmetatable(c, {
		__tostring = function(t)
			return t.base
		end,
	})
end

return M
