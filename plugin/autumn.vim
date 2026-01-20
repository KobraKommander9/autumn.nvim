if !has('nvim') | finish | endif

if exists('g:loaded_autumn') | finish | endif

let g:loaded_autumn = 1

command! AutumnCompile lua require("autumn").compile({ notify = true })
command! AutumnReload lua require("autumn").reload({ notify = true })
