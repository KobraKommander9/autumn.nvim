if exists('g:loaded_autumn') | finish | endif

command! AutumnCompile lua require("autumn").compile()

let g:loaded_autumn = 1
