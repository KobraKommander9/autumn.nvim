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

function M.get_style(opt, def)
	return opt and opt or (def or "NONE")
end

return M
