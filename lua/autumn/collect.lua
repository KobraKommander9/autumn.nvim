local M = {}

function M.deep_extend(...)
	local lhs = {}
	for _, rhs in ipairs({ ... }) do
		for k, v in pairs(rhs) do
			if type(lhs[k]) == "table" and type(v) == "table" then
				lhs[k] = M.deep_extend(lhs[k], v)
			else
				lhs[k] = v
			end
		end
	end
end

return M
