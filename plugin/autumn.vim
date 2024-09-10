if exists('g:loaded_autumn') | finish | endif

command! AutumnCompile lua require("autumn").compile()
command! AutumnInteractive lua require("autumn.interactive").attach()

let g:loaded_autumn = 1
