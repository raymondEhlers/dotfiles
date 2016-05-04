" Set nocompatible to use vim defaults rather than vi defaults. This should be done first to avoid issues
" when the defaults are changed.
set nocompatible

" Required for vundle
filetype off

" Download vundle if necessary
" Based on: http://erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
let installedVundle=0
if !isdirectory(expand("~/.vim/bundle/Vundle.vim/.git"))
    echo "Installing vundle"
    echo ""
    silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
    let installedVundle=1
endif

" Sets the runtime path to invlude Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Setup plugins
" Must have Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Other plugins
" Git support
"Plugin 'tpope/vim-fugitive'
" Enables tab to complete
Plugin 'ervandew/supertab'
" Auto close pairs
Plugin 'jiangmiao/auto-pairs'
" Vim-tags to handle ctags generation
" As of 3-16-2016, it does not work because it forces a buffer redraw on every change
"Plugin 'szw/vim-tags'
" Tagbar to handle ctags in the lcoal file
Plugin 'majutsushi/tagbar'

" All are reasonable colorschemes
" lapis
Plugin 'andrwb/vim-lapis256'
" elda
Plugin 'lxmzhv/vim', {'name': 'elda'}
" muon
Plugin 'gregsexton/Muon'
" wolfpack
Plugin 'carlson-erik/wolfpack'
" darkSea
Plugin 'atelierbram/vim-colors_duotones'
" Colorscheme tests!
" OceanDeep
"Plugin 'vim-scripts/oceandeep'
" kalisi-dark
"Plugin 'freeo/vim-kalisi'
" Wombat256
"Plugin 'MPiccinato/wombat256'
" peaksea
"Plugin 'jlesquembre/peaksea'
" flattr
"Plugin 'blindFS/flattr.vim'
" vt_tmux (pt_black)
"Plugin 'yantze/pt_black'

" Determine which plugins to disable, if any. I am using the existance of a locally compiled git
" as a proxy for if this is the ATLAS cluster where this is incompatible
"if isdirectory(expand("$MYINSTALL/git/")) 
if $NERSC_HOST == "pdsf" || $HOSTNAME == "atlas01" || $HOME =~ "fas" || $HOME =~ "hep"
	" Setup the colorscheme. 
	" The cursor line looks terrible when the colors are not supported correctly
	set nocursorline
	try
		colorscheme darkdotSnapshot
	catch
		colorscheme ron 
	endtry
else
	" Only load when not on the above hosts
	Plugin 'godlygeek/CSApprox'
	Plugin 'Lokaltog/vim-easymotion'
    Plugin 'mileszs/ack.vim'

endif

" Install plugins
if installedVundle == 1
    echo "Installing Vundles, please ignore key map error messages"
    echo ""
    :PluginInstall
endif

" Finish Vundle setup
call vundle#end()
filetype plugin indent on

" Set backspace to work as expected.
set backspace=indent,eol,start

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
" Expand tabs as spaces, since everyone seems to be doing that right now
set expandtab
set tabstop=4
set shiftwidth=4

" View "tab" as 4 spaces, but write the files with tab as 2 spaces to confirm
" with others. See: https://stackoverflow.com/a/14517418 . The functions are
" needed to allow filetype detection (it did not work inline). They are
" inspired by https://stackoverflow.com/a/6496995 .
" This only applies to files containing "aliphysics" or "aliroot" in the path
" since that is where I tend to encounter two space indentation.
" The buffer view is saved so that it can be restored. This is done because
" the substitute command can change the buffer. See: https://stackoverflow.com/a/4776436 and
" https://stackoverflow.com/a/19763761 .
"
" Doubles the whitespace that was already there
fun! DoubleWhitespace()
    let winview=winsaveview()
    if &ft == 'cpp'
        %substitute/^ \+/&&/e
    endif
    " Restore the buffer view
    call winrestview(winview)
endfun
"
" Remove extra whitespace added when opening the buffer
fun! HalfWhitespace()
    " Save the buffer view so that it can be restored. The substitute command
    " can change the buffer
    let winview=winsaveview()
    if &ft == 'cpp'
        %substitute/^\( \+\)\1/\1/e
    endif
    " Restore the buffer view
    call winrestview(winview)
endfun
" Calls the functions when buffers are processed.
" (I think) this relies on the fact that the buffer is set to save when vim
" switches to another buffer.
autocmd BufReadPost,BufWritePost  */aliphysics/*,*/aliroot/*,*/code/alice/* silent call DoubleWhitespace()
autocmd BufWritePre               */aliphysics/*,*/aliroot/*,*/code/alice/* silent call HalfWhitespace()

" Return to previous line that was being edited See: http://stackoverflow.com/a/774599
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g`\"" | endif
endif

" Set tab settings for python, markdown, and latex
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype markdown setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 spell spelllang=en_us
autocmd Filetype tex setlocal spell spelllang=en_us

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
" Changes how backspaces are used
set magic

" Auto-update the open file if it is changed from outside of vim
" Vim must run some external command like !ls for the file to update
set autoread

" Show matching punctuation, and blink for two tenths of a second
set showmatch
set mat=2

" Remove include from autocompletion search to avoid wasting time searching. Once a function is used once,
" It will be rememberd
set complete-=i

" Automatically writes the file if invoking make, change buffers, etc...
set autowrite

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
" Matches parenthesis and brackets
nnoremap <tab> %
vnoremap <tab> %

" Reselect just pasted text
nnoremap <leader>v V`]

" Open corresponding html with browser after markdown
" http://tuxion.com/2011/09/30/vim-makeprg.html
nnoremap <leader>b :!open %<.html &<CR><CR>

" Open tagbar
nnoremap <leader>t :TagbarToggle<CR>

" Add to tags path so that it can find tags stored in .git/tags
" It stops searching at the home directory ("~")
" For more info, see: https://stackoverflow.com/a/5019111
" Handled by vim-tags
set tags+=./.git/tags;~

" Auto completion via omnicomplete
" Should be tested further
" For more info, see: http://vim.wikia.com/wiki/C%2B%2B_code_completion
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

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

" Set make command based on what files are available
" First deal with C/C++
if filereadable("../build/Makefile")
	set makeprg=(cd\ %:p:h\ &&\ cd\ ../build/\ &&\ make\ $*\ &&\ cd\ ../src/)
"elseif filereadable("../train/rebuild.sh")
"	set makeprg=(cd\ ../train/\ &&\ ./rebuild.sh\ &&\ cd\ ../rehlers/)
endif
" Now deal with markdown
autocmd BufNewFile,BufRead *.md,*.rst setlocal makeprg=(pandoc\ --self-contained\ -S\ -c\ $HOME/.dotfiles/buttondown.css\ -o\ %<.html\ %)

" Set the colorscheme
" darkdot
"colorscheme darkdot
" Setup line highlighting
"set cursorline
"
" lapis256
colorscheme lapis256
set nocursorline
