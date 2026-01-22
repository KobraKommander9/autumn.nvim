local M = {}

function M.new(base, dim, bg)
	local c = { base = base, dim = dim, bg = bg }

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
