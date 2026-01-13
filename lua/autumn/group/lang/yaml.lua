local M = {}

function M.get(spec, _, _)
	local syn = spec.syntax

	return {
		["@variable.member.yaml"] = { fg = syn.field },
	}
end

return M
