local files = require("autumn.files")

local M = {}

local function parse_style(style)
  if not style or style == "NONE" then
    return {}
  end

  local result = {}
  for token in string.gmatch(style, "([^,]+)") do
    result[token] = true
  end

  result.bg = result.bg and result.bg.hex
  result.fg = result.fg and result.fg.hex
  result.sp = result.sp and result.sp.hex

  return result
end

local function should_link(link)
  return link and link ~= ""
end

local function inspect(tbl)
  local list = {}
  for k, v in pairs(tbl) do
    local q = type(v) == "string" and '"' or ""
    table.insert(list, fmt("%s = %s%s%s", k, q, v, q))
  end

  table.sort(list)
  return fmt([[{ %s }]], table.concat(list, ", "))
end

function M.compile(opts)
  opts = opts or {}
  
  local config = require("autumn.config")
  local style = opts.style or config.style
  
  local spec = require("autumn.spec").load(style)
  local groups = require("autumn.group").from(spec)
  local background = spec.palette.meta.light and "light" or "dark"

  local lines = {
    fmt([[
return string.dump(function()
  local h = vim.api.nvim_set_hl 
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  vim.cmd("syntax reset")

  vim.o.termguicolors = true
  vim.g.colors_name = "%s"
  vim.o.background = "%s"]],
      style,
      background
    )
  }

  for group, attrs in pairs(editor) do
    if should_link(attrs.link) then
      table.insert(lines, fmt([[h(0, "%s", { link = "%s" })]], group, attrs.link))
    else
      local op = parse_style(attrs.style)
      table.insert(lines, fmt([[h(0, "%s", %s)]], group, inspect(op)))
    end
  end

  table.insert(lines, "end)")

  local output_path, output_file = config.get_compiled_info()
  files.ensure_dir(output_path)

  local file, err
  if vim.g.autumn_debug then
    file, err = io.open(output_file .. ".lua", "wb")
    if not file then
      vim.notify(fmt([[Unable to open debug file: %s, error: %s]], output_file .. ".lua", err), vim.log.levels.ERROR)
    else
      file:write(table.concat(lines, "\n"))
      file:close()
    end
  end

  file, err = io.open(output_file, "wb")
  if not file then
    vim.notify(fmt([[Unable to open file: %s, error: %s]], output_file, err), vim.log.levels.ERROR)
    return
  end

  local f = loadstring(table.concat(lines, "\n"), "=")
  if not f then
    local tmpfile = "/tmp/autumn_error.lua"
    vim.notify(fmt([[There is an error in your autumn config, refer to %s]], tmpfile))

    local efile = io.open(tmpfile, "wb")
    efile:write(table.concat(lines, "\n"))
    efile:close()

    dofile(tmpfile)
  end

  file:write(f())
  file:close()
end

return M
