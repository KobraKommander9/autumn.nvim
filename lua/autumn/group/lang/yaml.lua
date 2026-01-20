local M = {}

function M.get(spec, _, _)
	local p = spec.palette
	local syn = spec.syntax

	return {
		["@key.yaml"] = { fg = spec.secondary },
		["@boolean.yaml"] = { fg = p.green.dim },
		["@tag.yaml"] = { fg = spec.primary },
		["@anchor.yaml"] = { fg = p.cyan.dim },
		["@parameter.yaml"] = { fg = syn.variable },
	}
end

return M
