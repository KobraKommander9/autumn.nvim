local M = {}

function M.get(spec, _)
	local p = spec.palette

	return {
		AutumnWhite = { fg = p.white.hex },
		AutumnBlack = { fg = p.black.hex },
		AutumnGray = { fg = p.gray.hex },

		AutumnPrimary = { fg = p.primary.hex },
		AutumnSecondary = { fg = p.secondary.hex },

		AutumnRed = { fg = p.red.hex },
		AutumnGreen = { fg = p.green.hex },
		AutumnYellow = { fg = p.yellow.hex },
		AutumnBlue = { fg = p.blue.hex },
		AutumnMagenta = { fg = p.magenta.hex },
		AutumnCyan = { fg = p.cyan.hex },
	}
end

return M
