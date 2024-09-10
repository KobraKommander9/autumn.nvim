local function reload()
  for name, _ in pairs(package.loaded) do
    if name:match("^autumn") then
      if not name:match("config") then
        package.loaded[name] = nil
      end
    end
  end
end

return setmetatable({}, {
  __call = function(_)
    reload()
  end,
})
