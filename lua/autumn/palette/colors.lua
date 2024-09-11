local Color = require("autumn.color")

local M = setmetatable({}, {
	__index = function(t, key)
		if t[key] then
			return t[key]
		end
		return t.palette[key]
	end,
})

function M:new(colors)
	local palette = vim.deepcopy(colors)

	setmetatable(palette, {
		__index = self,
	})
	self.__index = self

	palette:generate()

	return palette
end

function M:generate()
	self.gray = Color(self.white.mix(self.black, 90))

	self.comment = Color(self.gray.lighten(60))

	self.bg0 = Color(self.gray.darken(60))
	self.bg1 = Color(self.gray.darken(50))
	self.bg2 = Color(self.gray.darken(20))
	self.bg3 = Color(self.gray.lighten(10))

	self.fg0 = Color(self.gray.lighten(90))
	self.fg1 = Color(self.gray.lighten(80))
	self.fg2 = Color(self.gray.lighten(70))
	self.fg3 = Color(self.gray.lighten(60))

	self.primary1 = Color(self.primary.lighten(10))
	self.primary2 = Color(self.primary.lighten(20))
	self.secondary1 = Color(self.secondary.lighten(20))
	self.secondary2 = Color(self.secondary.lighten(40))
end

function M:extend(palette)
	local names = {
		"white",
		"black",
		"red",
		"orange",
		"yellow",
		"green",
		"blue",
		"purple",
		"pink",
		"magenta",
		"cyan",

		"primary",
		"secondary",
	}

	for key, color in pairs(palette) do
		if vim.tbl_contains(names, key) then
			self[key].extend(color)
		end
	end

	self:generate()

	return self
end

setmetatable(M, {
	__call = function(_, colors)
		return M:new(colors)
	end,
})

return M
