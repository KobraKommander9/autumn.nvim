local M = {}

function M.get(
	_ --[[ spec ]],
	_ --[[ config ]],
	_ --[[ opts ]]
)
	return {
		LazyButtonActive = { link = "TabLineSel" },
		LazyDimmed = { link = "LineNr" },
		LazyProp = { link = "LineNr" },
	}
end

return M
