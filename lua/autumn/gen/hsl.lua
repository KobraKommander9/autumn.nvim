local M = {}

local utils = {
	math = require("autumn.gen.math"),
	rgb = require("autumn.gen.rgb"),
}

-------------------------------------------------------------------------------
-- Converters

function M.rgb_to_hsl(rgb)
	local r, g, b = rgb.r / 255, rgb.g / 255, rgb.b / 255
	local max, min = math.max(r, g, b), math.min(r, g, b)
	local h, s, l

	l = (max + min) / 2

	if max == min then
		h, s = 0, 0
	else
		local d = max - min
		s = l > 0.5 and d / (2 - max - min) or d / (max + min)

		if max == r then
			h = (g - b) / d + (g < b and 6 or 0)
		elseif max == g then
			h = (b - r) / d + 2
		elseif max == b then
			h = (r - g) / d + 4
		end

		h = h / 6
	end

	return {
		h = h,
		s = s,
		l = l,
	}
end

function M.hsl_to_rgb(hsl)
	local r, g, b
	local h, s, l = hsl.h, hsl.s, hsl.l

	if s == 0 then
		r, g, b = l, l, l
	else
		local function hue_to_rgb(p, q, t)
			if t < 0 then
				t = t + 1
			end
			if t > 1 then
				t = t - 1
			end
			if t < 1 / 6 then
				return p + (q - p) * 6 * t
			end
			if t < 1 / 2 then
				return q
			end
			if t < 2 / 3 then
				return p + (q - p) * (2 / 3 - t) * 6
			end
			return p
		end

		local q = l < 0.5 and l * (1 + s) or l + s - l * s
		local p = 2 * l - q

		r = hue_to_rgb(p, q, h + 1 / 3)
		g = hue_to_rgb(p, q, h)
		b = hue_to_rgb(p, q, h - 1 / 3)
	end

	return {
		r = utils.math.round(r * 255),
		g = utils.math.round(g * 255),
		b = utils.math.round(b * 255),
	}
end

function M.hex_to_hsl(hex)
	local hsl = M.rgb_to_hsl(utils.rgb.from_hex(hex))

	return {
		h = utils.math.round(hsl.h * 360),
		s = utils.math.round(hsl.s * 100),
		l = utils.math.round(hsl.l * 100),
	}
end

function M.hsl_to_hex(hsl)
	hsl = {
		h = hsl.h / 360,
		s = hsl.s / 100,
		l = hsl.l / 100,
	}

	return utils.rgb.to_hex(M.hsl_to_rgb(hsl))
end

-------------------------------------------------------------------------------
-- Operations

local function clamp(color)
	return {
		h = utils.math.round(color.h % 360),
		s = utils.math.round(utils.math.clamp(color.s, 0, 100)),
		l = utils.math.round(utils.math.clamp(color.l, 0, 100)),
	}
end

local function make_lerp_fn(color, key)
	return function(percent)
		if type(percent) ~= "number" then
			error("must provide number to hsl modifiers", 0)
		end

		local new_color = {
			h = color.h,
			s = color.s,
			l = color.l,
		}

		local min, max = 0, 100
		local lerp_space = percent < min and new_color[key] or (max - new_color[key])
		new_color[key] = new_color[key] + (lerp_space * percent / 100)

		return new_color
	end
end

local function op_lighten(color)
	return make_lerp_fn(color, "l")
end

local function op_darken(color)
	return function(percent)
		if type(percent) ~= "number" then
			error("must provide number to hsl modifiers", 0)
		end

		return make_lerp_fn(color, "l")(-percent)
	end
end

local function op_mix(color)
	return function(target, weight)
		assert(weight, "must provide weight to mix")
		weight = utils.math.clamp(weight, 0, 100) / 100

		local cv_wt = 1 - weight
		local tv_wt = 1 - cv_wt

		local cv = {
			x = math.cos(color.h / 180 * math.pi) * color.s,
			y = math.sin(color.h / 180 * math.pi) * color.s,
			z = color.l,
		}

		local tv = {
			x = math.cos(target.h / 180 * math.pi) * target.s,
			y = math.sin(target.h / 180 * math.pi) * target.s,
			z = target.l,
		}

		local rv = {
			x = ((cv.x * cv_wt) + (tv.x * tv_wt)) / 1,
			y = ((cv.y * cv_wt) + (tv.y * tv_wt)) / 1,
			z = ((cv.z * cv_wt) + (tv.z * tv_wt)) / 1,
		}

		return {
			h = math.atan2(rv.y, rv.x) * 180 / math.pi,
			s = math.sqrt(rv.x * rv.x + rv.y * rv.y),
			l = rv.z,
		}
	end
end

local function op_readable(color)
	return function()
		return {
			h = color.h,
			s = color.s,
			l = color.l >= 50 and 0 or 100,
		}
	end
end

-------------------------------------------------------------------------------
-- HSL

local function decorate_hsl(hsl)
	hsl = clamp(hsl)

	local op_fns = {
		mix = op_mix,
		lighten = op_lighten,
		darken = op_darken,
		readable = op_readable,
	}

	return setmetatable({}, {
		__index = function(_, key)
			if key == "h" then
				return hsl.h
			end
			if key == "s" then
				return hsl.s
			end
			if key == "l" then
				return hsl.l
			end
			if key == "hsl" then
				return { h = hsl.h, s = hsl.s, l = hsl.l }
			end
			if key == "hex" then
				return M.hsl_to_hex(hsl)
			end
			if key == "rgb" then
				return M.hsl_to_rgb(hsl)
			end

			if op_fns[key] then
				return function(...)
					local altered_color = op_fns[key](hsl)(...)
					return decorate_hsl(altered_color)
				end
			end

			local ops = ""
			for op, _ in pairs(op_fns) do
				ops = ops .. " " .. op
			end
			ops = ops .. " h s l hex hsl"
			error("Invalid hsl operation: '" .. key .. "', valid operations:" .. ops, 2)
		end,

		__newindex = function(_, _, _)
			error("Member setting disabled", 2)
		end,

		__tostring = function(color)
			return M.hsl_to_hex(color)
		end,

		__concat = function(lhs, rhs)
			return tostring(lhs) .. tostring(rhs)
		end,

		__call = function()
			return hsl
		end,
	})
end

local function hsl(hue_or_hex, saturation, light)
	local hue, hex_str = hue_or_hex, hue_or_hex
	local color

	if type(hex_str) == "string" then
		color = utils.convert.hex_to_hsl(hex_str)
	else
		if type(hue) ~= "number" or type(saturation) ~= "number" or type(light) ~= "number" then
			error("hsl() expects either a hex string or three numbers", 2)
		end

		color = { h = hue, s = saturation, l = light }
	end

	return decorate_hsl(color)
end

setmetatable(M, {
	__call = function(...)
		return hsl(...)
	end,
})

return M
