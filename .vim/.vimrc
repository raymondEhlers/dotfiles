" Set nocompatible to use vim defaults rather than vi defaults. This should be done first to avoid issues
" when the defaults are changed.
set nocompatible

" Set backspace to work as expected.
set backspace=indent,eol,start

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

" Enable syntax highlighting
syntax on

" Set tab width to 4 spaces
set tabstop=4
set shiftwidth=4

" Set tab settings for python
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Enable line numbers
set number

" Enable ruler to show location in the file
set ruler

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

" Determine plugins to disable
let g:pathogen_disabled = []

" Determine which plugins to disable, if any. I am using the existance of a locally compiled git
" as a proxy for if this is the ATLAS cluster where this is incompatible
"if isdirectory(expand("$MYINSTALL/git/")) 
if $NERSC_HOST == "pdsf" || $HOSTNAME == "atlas01"
	call add(g:pathogen_disabled, 'CSApprox')
	call add(g:pathogen_disabled, 'tagbar')
endif

" Temporary test with minibufexplorer disabled
call add(g:pathogen_disabled, 'minibufexplorer')

" Initialize pathogen
execute pathogen#infect()
execute pathogen#helptags()

" Determine the colorscheme based on what is available
" Match returns the index if it is found
if match(g:pathogen_disabled, 'CSApprox') < 0
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
nnoremap <CR> :nohlsearch<CR><CR>
