local M = {}

function M.clamp(val, min, max)
  return math.min(max, math.max(min, val))
end

function M.round(val)
  return math.floor(val + 0.5)
end

return M
