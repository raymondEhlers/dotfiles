" Set nocompatible to use vim defaults rather than vi defaults. This should be done first to avoid issues
" when the defaults are changed.
set nocompatible

" Required for vundle
filetype off

" Sets the runtime path to invlude Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Setup plugins
" Must have Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Other plugins
Plugin 'tpope/vim-fugitive'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/CSApprox'
Plugin 'majutsushi/tagbar'
Plugin 'git://git.code.sf.net/p/atp-vim/code', {'name': 'atp-vim'}
Plugin 'Lokaltog/vim-easymotion'
"Plugin 'fholgado/minibufexpl.vim'

" Determine which plugins to disable, if any. I am using the existance of a locally compiled git
" as a proxy for if this is the ATLAS cluster where this is incompatible
"if isdirectory(expand("$MYINSTALL/git/")) 
if $NERSC_HOST == "pdsf" || $HOSTNAME == "atlas01"
	" If we are on these hosts, we need to remove the plugins.
	" We can do this via the runtime path
	set runtimepath-=~/.vim/bundle/CSApprox
	set runtimepath-=~/.vim/bundle/tagbar
	set runtimepath-=~/.vim/bundle/minibufexpl.vim

	" Also setup the colorscheme. 
	" The cursor line looks terrible when the colors are not supported correctly
	set nocursorline
	try
		colorscheme darkdotSnapshot
	catch
		colorscheme ron 
	endtry
else
	colorscheme darkdot
endif

" Finish Vundle setup
call vundle#end()
filetype plugin indent on

" Set backspace to work as expected.
set backspace=indent,eol,start

" Set make command 

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
autocmd Filetype markdown setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 spell spelllang=en_us

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

" Highlight current line
set cursorline

" Remove include from autocompletion search to avoid wasting time searching. Once a function is used once,
" It will be rememberd
set complete-=i

" Turns off highlighting of the search when enter is pressed. This seems somewhat heavy handed,
" but it's super convenient, so I'm not going to worry about it for now
nnoremap <CR> :nohlsearch<CR><CR>

" These remaps are taken from: http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" Makes j and k move by file line instead of screen line
nnoremap j gj
nnoremap k gk

" Remap leader to something easier to use
let mapleader = " "

" Remap the % key to something easier to hit
nnoremap <tab> %
vnoremap <tab> %

" Reselect just pasted text
nnoremap <leader>v V`]

" Open corresponding html with browser after markdown
" http://tuxion.com/2011/09/30/vim-makeprg.html
nnoremap <Leader>b :!chromium-browser %<.html &<CR><CR>

" Folding settings
" http://smartic.us/2009/04/06/code-folding-in-vim/
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Ensure .md is actually considered markdown...
au BufRead,BufNewFile *.md set filetype=markdown

" Deal with stupidity regarding tmux, backspace and PDSF
" ^V = ctrl-v and <BS> is the backspace key (^? currently)
" http://vimdoc.sourceforge.net/htmldoc/options.html#:fixdel
if $NERSC_HOST == "pdsf" && $TMUX != ""
	set t_kb=
endif

" Configure latex to use a build directory
let b:atp_OutDir = 'build/'

" Set make command based on what files are available
" First deal with C/C++
if filereadable("../build/Makefile")
	set makeprg=(cd\ %:p:h\ &&\ cd\ ../build/\ &&\ make\ $*\ &&\ cd\ ../src/)
elseif filereadable("../train/rebuild.sh")
	set makeprg=(cd\ ../train/\ &&\ ./rebuild.sh\ &&\ cd\ ../rehlers/)
endif
" Now deal with markdown
autocmd BufNewFile,BufRead *.md setlocal makeprg=(pandoc\ -o\ %<.html\ %)
