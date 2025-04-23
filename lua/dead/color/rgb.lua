local M = {}

function M.to_hex(rgb)
	return string.format("#%02X%02X%02X", rgb.r, rgb.g, rgb.b)
end

function M.from_hex(hex_str)
	local hex = "[abcdef0-9][abcdef0-9]"
	local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
	hex_str = string.lower(hex_str)

	assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

	local r, g, b = string.match(hex_str, pat)
	r, g, b = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)

	return {
		r = r,
		g = g,
		b = b,
	}
end

return M
