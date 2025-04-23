local M = {}

function M.get(spec, _)
	-- local diag = spec.diag
	-- local diff = spec.diff
	-- local syn = spec.syntax

	return {
		Normal = { bg = spec.bg1.hex, fg = spec.fg1.hex },
		NormalFloat = { bg = spec.bg0.hex },
		NormalNC = { link = "Normal" },

		EndOfBuffer = { fg = spec.bg1.hex },
	}
end

return M
