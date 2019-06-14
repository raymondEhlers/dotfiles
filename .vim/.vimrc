" Set nocompatible to use vim defaults rather than vi defaults. This should be done first to avoid issues
" when the defaults are changed.
set nocompatible

" Setup vim-plug
" Install it if necessary
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Begin setup
call plug#begin('~/.vim/plugged')
" Setup plugins

" Use Airline for status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Git support (needed for airline)
Plug 'tpope/vim-fugitive'
" Virtualenv information (needed for airline)
Plug 'plytophogy/vim-virtualenv'

" Linting
Plug 'w0rp/ale'

" Tab completion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
" Needed for vim8 compatibility
Plug 'roxma/vim-hug-neovim-rpc', !has('nvim') ? {} : { 'on': [] }
" Word completion from the current buffer.
Plug 'ncm2/ncm2-bufword'
" Path completions relative to the current buffer location.
Plug 'ncm2/ncm2-path'
" Grab words from other tmux panes. Note that `ncm2-tmux` does the same thing, but this
" was the original project. This is really cool and convenient, but it seems to really
" slow down vim :-( So it's disabled for now
"Plug 'wellle/tmux-complete.vim'
" Python
Plug 'ncm2/ncm2-jedi'
" C++
Plug 'ncm2/ncm2-pyclang'
" Markdown subscope detection
Plug 'ncm2/ncm2-markdown-subscope'

" Enables tab to complete
"Plug 'ervandew/supertab'
" Auto close pairs
"Plug 'jiangmiao/auto-pairs'
" Vim-tags to handle ctags generation
" As of 3-16-2016, it does not work because it forces a buffer redraw on every change
"Plug 'szw/vim-tags'
" Latex helper
Plug 'lervag/vimtex'

" Improve syntax highlighting
" Python
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'Vimjas/vim-python-pep8-indent'
" C++
Plug 'vim-jp/vim-cpp'
Plug 'octol/vim-cpp-enhanced-highlight'
" Pandoc integration
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Clang-format support
Plug 'rhysd/vim-clang-format'
Plug 'kana/vim-operator-user'
" Better markdown highlighting
" (tabular) is required for the markdown highlighting
"Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
" Julia support
"Plug 'JuliaEditorSupport/julia-vim'

" All are reasonable colorschemes
" lapis
Plug 'andrwb/vim-lapis256'
" elda
"Plug 'lxmzhv/vim', {'name': 'elda'}
" muon
Plug 'gregsexton/Muon'
" wolfpack
Plug 'carlson-erik/wolfpack'
" darkSea
Plug 'atelierbram/vim-colors_duotones'
" night-owl
Plug 'haishanh/night-owl.vim'
" papercolor
Plug 'NLKNguyen/papercolor-theme'
" onedark
Plug 'joshdick/onedark.vim'
" Colorscheme tests!
" OceanDeep
"Plug 'vim-scripts/oceandeep'
" kalisi-dark
"Plug 'freeo/vim-kalisi'
" Wombat256
"Plug 'MPiccinato/wombat256'
" peaksea
"Plug 'jlesquembre/peaksea'
" flattr
"Plug 'blindFS/flattr.vim'
" vt_tmux (pt_black)
"Plug 'yantze/pt_black'

" Some plugins need to be disabled on remote systems due to compatibility issues.
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
    "Plug 'godlygeek/CSApprox'
    Plug 'Lokaltog/vim-easymotion'
    Plug 'mileszs/ack.vim'
endif

" Finish vim-plug setup
call plug#end()
filetype plugin indent on

" Setup airline
let g:airline_theme = 'powerlineish'
" Use powerline fonts
let g:airline_powerline_fonts = 1
" Always show statusline
set laststatus=2

" Setup ncm2
" Enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text
" injection into the current line (noinsert).
set completeopt=noinsert,menuone,noselect
" Clang path. Careful! This depends on the path on macOS.
let g:ncm2_pyclang#library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
" Allow use of jump to declaration
autocmd FileType c,cpp nnoremap <buffer> gd :<c-u>call ncm2_pyclang#goto_declaration()<cr>

" Recommendations from the authro of ncm2:
" Suppress 'match x of y', 'The only match' and 'Pattern not found' messages
set shortmess+=c"'
" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>
" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Configure ale
" Ale
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8']}

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

" Color settings
" Tells vim to use 256 colors in the terminal. This may or may not be required based on the system
set t_Co=256
" Enable 24-bit color if available
" This seems to break the colorscheme in nvim (as of May 2019), so we disable it for now.
"if (has("termguicolors"))
"    set termguicolors
"endif

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
autocmd BufReadPost,BufWritePost  */AliPhysics/*,*/AliRoot/*,*/code/alice/* silent call DoubleWhitespace()
autocmd BufWritePre               */AliPhysics/*,*/AliRoot/*,*/code/alice/* silent call HalfWhitespace()

" Return to previous line that was being edited See: http://stackoverflow.com/a/774599
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g`\"" | endif
endif

" Set tab settings for python, markdown, and latex
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype markdown setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 spell spelllang=en_us

" Enable spell checking in latex and git commits
autocmd Filetype tex setlocal spell spelllang=en_us
autocmd Filetype gitcommit setlocal spell spelllang=en_us

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
" It will be remembered
"set complete-=i

" Automatically writes the file if invoking make, change buffers, etc...
set autowrite

" Turns off highlighting of the search when enter is pressed. This seems somewhat heavy handed,
" but it's super convenient, so I'm not going to worry about it for now
nnoremap <CR> :nohlsearch<CR><CR>

" These remaps are taken from: http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" Makes j and k move by file line instead of screen line
nnoremap j gj
nnoremap k gk

" Configure vimtex errors to ignore. These will also show up due to Debian and
" OS X vim not being configured to include ClientServer
let g:vimtex_echo_ignore_wait = 1

" Configure markdown syntax highlighting
" Math
"let g:vim_markdown_math = 1
" Highlight YAML at the top of the file
"let g:vim_markdown_frontmatter = 1

" Set the desired latex engine for vim-pandoc
let g:pandoc#command#latex_engine = "pdflatex"

" Set pandoc formatting and textwidth
" A is a smart autoformatting mode
" 110 seems to be reasonable when using the main laptop screen
let g:pandoc#formatting#mode = "hA"
let g:pandoc#formatting#textwidth = 110

" Remap leader to something easier to use
"let mapleader = " "
let mapleader = ";"

" Remap the % key to something easier to hit
" Matches parenthesis and brackets
nnoremap <tab> %
vnoremap <tab> %

" Reselect just pasted text
nnoremap <leader>v V`]

" Open corresponding html with browser after markdown
" http://tuxion.com/2011/09/30/vim-makeprg.html
nnoremap <leader>b :!open %<.html &<CR><CR>

" Add to tags path so that it can find tags stored in .git/tags
" It stops searching at the home directory ("~")
" For more info, see: https://stackoverflow.com/a/5019111
" Handled by vim-tags
set tags+=./.git/tags;~

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
"    set makeprg=(cd\ ../train/\ &&\ ./rebuild.sh\ &&\ cd\ ../rehlers/)
endif
" Now deal with markdown
autocmd BufNewFile,BufRead *.md,*.rst setlocal makeprg=(pandoc\ --self-contained\ -S\ -c\ $HOME/.dotfiles/buttondown.css\ -o\ %<.html\ %)
" Latex
autocmd BufNewFile,BufRead *.tex setlocal makeprg=(pdflatex\ %)

" Clang-format
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" Allow to use = with clang-format. See: https://vi.stackexchange.com/a/6536
autocmd FileType c,cpp,objc map <buffer> = <Plug>(operator-clang-format)

" Set the colorscheme
" darkdot
"colorscheme darkdot
" Setup line highlighting
"set cursorline
"
" lapis256
colorscheme onedark
set nocursorline
