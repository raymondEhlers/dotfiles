" Neovim configuration
" We rely on the base .vimrc, and then do soem neovim specific modifications
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set termguicolors

" Setup python to use the nvim virtualenv
let g:python3_host_prog = stdpath('config').'/venv/bin/python'
