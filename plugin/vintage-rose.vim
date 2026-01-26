if !has('nvim') | finish | endif

if exists('g:loaded_vintage_rose') | finish | endif

let g:loaded_vintage_rose = 1

command! VintageRoseCompile lua require("vintage-rose").compile({ notify = true })
command! VintageRoseReload lua require("vintage-rose").reload({ notify = true })

command! VintageRoseExportWezterm lua require("vintage-rose").export({ export = "wezterm" })
