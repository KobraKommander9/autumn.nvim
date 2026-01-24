local M = {}

function M.get(spec, _, _)
	local p = spec.palette
	local syn = spec.syntax

	return {
		-- ["@string.json"] = { fg = syn.string },
		-- ["@number.json"] = { fg = p.purple.base },
		-- ["@boolean.json"] = { fg = p.green.dim },
		-- ["@null.json"] = { fg = p.yellow.dim },
		-- ["@key.json"] = { fg = spec.secondary },
	}
end

return M
