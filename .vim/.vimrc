" For autocomplete, attempt to use clang_complete. However, it may be a pain to install clang until ROOT 6
" Set make command 
set makeprg=(cd\ %:p:h\ &&\ cd\ ../build/\ &&\ make\ $*\ &&\ cd\ ../src/)

" Automatically change to the directory of the current buffer (this makes part of the make command
" redundant, but it is better to be safe)
set autochdir

" Set dark background (although this shouldn't be required if colorschemes are used(?))
set background=dark

" Creates an interactive shell when running commands with !. Therefore, .bashrc is executed.
" However, this is less than ideal, as it sends vim to the background. Run fg to return to vim.
set shellcmdflag=-ic

" Tells vim to use 256 colors in the terminal. This may or may not be required based on the system
" However, it is necessary on the ATLAS cluster
set t_Co=256

" Set tab width to 4 spaces
set tabstop=4
set shiftwidth=4

" Enable line numbers
set number

" Search options
" Highlight search matches and match as search continues
set hlsearch
set incsearch
set ignorecase
set smartcase

" Auto-update the open file if it is changed from outside of vim
" Vim must run some external command like !ls for the file to update
set autoread

" Show matching punctuation, and blink for two tenths of a second
set showmatch
set mat=2

" Autoidenting
set cindent

" Highlight current line
set cursorline

" Remove include from autocompletion search to avoid wasting time searching. Once a function is used once,
" It will be rememberd
set complete-=i

" Determine the colorscheme based on what is available
" Perhaps a little presumptuous, but I export most of the time, ~/.vim will either be the appropriate location
" or it will be symlinked. In either of those cases, it should be fine.
if filereadable(expand("~/.vim/plugin/CSApprox.vim")) 
	colorscheme darkdot
else
	" The cursor line looks terrible when the colors are not supported correctly
	set nocursorline
	try
		colorscheme darkdotSnapshot
	catch
		colorscheme ron 
	endtry
endif

" Turns off highlighting of the search when enter is pressed. This seems somewhat heavy handed,
" but it's super convenient, so I'm going to worry about it for now
:nnoremap <CR> :nohlsearch<CR><CR>
