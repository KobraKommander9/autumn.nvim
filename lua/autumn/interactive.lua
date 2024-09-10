local M = {}

local function get_filetype()
  return vim.bo and vim.bo.filetype or vim.eval("&filetype")
end

function M.attach()
  vim.g.autumn_debug = true
  local group = vim.api.nvim_create_augroup("AutumnInteractive", { clear = false })
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = "<buffer>",
    callback = M.execute,
  })
end

function M.execute()
  local source_method = get_filetype() == "lua" and "luafile" or "source"
  local name = vim.g and vim.g.colors_name or vim.eval("g:colors_name")

  require("autumn.config").reset()
  vim.cmd(fmt([[%s %% colorscheme %s doautoall ColorScheme]], source_method, name))
end

return M
