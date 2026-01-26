local M = {}

M.meta = {
	__tostring = function(t)
		local tokens = {}

		for k, v in pairs(t) do
			if type(v) ~= "function" then
				local key = type(k) == "string" and string.format("[%q]", k) or string.format("[%s]", k)
				local value

				if type(v) == "table" then
					value = tostring(v)
				elseif type(v) == "string" then
					value = string.format("%q", v)
				else
					value = tostring(v)
				end

				table.insert(tokens, string.format("%s = %s", key, value))
			end
		end

		return "{ " .. table.concat(tokens, ", ") .. " }"
	end,
}

function M.make(tbl)
	if type(tbl) ~= "table" then
		return tbl
	end

	setmetatable(tbl, M.meta)

	for _, v in pairs(tbl) do
		if type(v) == "table" then
			M.make(v)
		end
	end

	return tbl
end

return M
