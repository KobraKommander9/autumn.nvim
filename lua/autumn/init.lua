local config = require("autumn.config")
local fmt = string.format

local M = {}

function M.compile()
  local spec = require("autumn.palette.autumn")
  local editor = require("autumn.group.editor").get(spec.generate_spec(spec.palette), config.options)

  local lines = {
    fmt(
      [[
      return string.dump(function()
      local h = vim.api.nvim_set_hl 
      if vim.g.colors_name then
        vim.cmd("hi clear")
      end
      vim.cmd("syntax reset")

      vim.o.termguicolors = true
      vim.g.colors_name = "%s"
      vim.o.background = "%s"
      ]],
      spec.meta.name,
      spec.meta.light and "light" or "dark"
    )
  }

  local parse_style = function(style)
    if not style or style == "NONE" then
      return {}
    end

    local result = {}
    for token in string.gmatch(style, "([^,]+)") do
      result[token] = true
    end

    return result
  end

  local should_link = function(link)
    return link and link ~= ""
  end

  local inspect = function(tbl)
    local list = {}
    for k, v in pairs(tbl) do
      local q = type(v) == "string" and '"' or ""
      table.insert(list, fmt("%s = %s%s%s", k, q, v, q))
    end

    table.sort(list)
    return fmt([[{ %s }]], table.concat(list, ", "))
  end

  for group, attrs in pairs(editor) do
    if should_link(attrs.link) then
      table.insert(lines, fmt([[h(0, "%s", { link = "%s" })]], group, attrs.link))
    else
      local op = parse_style(attrs.style)
      op.bg = attrs.bg and attrs.bg.hex
      op.fg = attrs.fg and attrs.fg.hex
      op.sp = attrs.sp and attrs.sp.hex
      table.insert(lines, fmt([[h(0, "%s", %s)]], group, inspect(op)))
    end
  end

  table.insert(lines, "end)")

  local output_path, output_file = config.get_compiled_info()
  if vim.fn.isdirectory(output_path) == 0 then
    vim.fn.mkdir(output_path, "p")
  end

  local file, err
  if config.options.debug then
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

local did_setup = false
local lock = false

function M.load(opts)
  if lock then
    return
  end

  if not did_setup then
    M.setup()
  end

  opts = opts or {}

  local _, compiled_file = config.get_compiled_info(opts)
  lock = true

  local f = loadfile(compiled_file)
  if not f then
    M.compile()
    f = loadfile(compiled_file)
  end

  f()

  lock = false
end

function M.setup(opts)
  did_setup = true
  opts = vim.tbl_deep_extend("force", config.options, opts or {})

  local cached_path = config.options.compile_path .. "/cache"
  local cached_file = io.open(cached_path, "r")

  local cached
  if cached_file then
    cached = cached_file:read()
    cached_file:close()
  end

  local git_path = debug.getinfo(1).source:sub(2, -23) .. "/.git"
  local git = vim.fn.getftime(git_path)
  local hash = require("autumn.hash")(opts) .. (git == -1 and git_path or git)
  
  if cached ~= hash then
    M.compile()
    local file = io.open(cached_path, "wb")
    if file then
      file:write(hash)
      file:close()
    end
  end
end

return M
