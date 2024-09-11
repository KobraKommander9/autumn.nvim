local hsl = require("autumn.color.hsl")

local M = {}

local new_color

local function op_extend(color)
	return function(other)
		if type(other) == "string" then
			return new_color(other)
		end

		local opts = {
			dim = other.dim,
			bright = other.bright,
		}

		return new_color(other.base or color, opts)
	end
end

local function decorate_color(color)
	local op_fns = {
		extend = op_extend,
	}

	return setmetatable({}, {
		__index = function(_, key)
			if key == "bright" then
				return color.bright
			elseif key == "dim" then
				return color.dim
			elseif color.base[key] then
				return color.base[key]
			elseif color[key] then
				return color[key]
			end

			if op_fns[key] then
				return function(...)
					local altered_color = op_fns[key](color)(...)
					return decorate_color(altered_color)
				end
			end

			local ops = ""
			for op, _ in pairs(op_fns) do
				ops = ops .. " " .. op
			end
			ops = ops .. " bright dim base"
			error("Invalid color operation: '" .. key .. "'", 2)
		end,

		__tostring = function(c)
			return tostring(c.base)
		end,

		__concat = function(lhs, rhs)
			return tostring(lhs) .. tostring(rhs)
		end,

		__call = function()
			return color
		end,
	})
end

new_color = function(color, opts)
	local result = {
		base = hsl(color),
	}

	local bright_mod = opts and opts.bm or 50
	local dim_mod = opts and opts.dm or 50

	local bright = opts and opts.bright or result.base.lighten(bright_mod)
	local dim = opts and opts.dim or result.base.darken(dim_mod)

	result.bright = bright
	result.dim = dim

	return decorate_color(result)
end

setmetatable(M, {
	__call = function(_, ...)
		return new_color(...)
	end,
})

return M
