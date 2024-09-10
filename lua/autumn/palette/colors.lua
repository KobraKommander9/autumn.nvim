local hsl = require("autumn.color.hsl")

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
  self.gray = self.white:mix(self.black, 90)

  self.comment = self.gray:lighten(60)

  self.bg0 = self.gray:darken(60)
  self.bg1 = self.gray:darken(50)
  self.bg2 = self.gray:darken(20)
  self.bg3 = self.gray:lighten(10)

  self.fg0 = self.gray:lighten(90)
  self.fg1 = self.gray:lighten(80)
  self.fg2 = self.gray:lighten(70)
  self.fg3 = self.gray:lighten(60)

  self.primary1 = self.primary0:lighten(10)
  self.primary2 = self.primary0:lighten(20)
  self.secondary1 = self.secondary0:lighten(20)
  self.secondary2 = self.secondary0:lighten(40)

  self.light_red = self.red:lighten(50)
  self.light_orange = self.orange:lighten(50)
  self.light_yellow = self.yellow:lighten(50)
  self.light_green = self.green:lighten(50)
  self.light_blue = self.blue:lighten(50)
  self.light_purple = self.purple:lighten(30)
  self.light_pink = self.pink:lighten(10)
  self.light_magenta = self.magenta:lighten(40)

  self.dark_cyan = self.cyan:darken(50)
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
      self[key] = hsl(color)
    end
  end

  self:generate()

  return self
end

setmetatable(M, {
  __call = function(_, colors)
    return M:new(colors)
  end
})

return M
