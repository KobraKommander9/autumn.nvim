local M = {}

function M.get(_, _, _)
	return {
		LazyButtonActive = { link = "TabLineSel" },
		LazyDimmed = { link = "LineNr" },
		LazyProp = { link = "LineNr" },
	}
end

return M
