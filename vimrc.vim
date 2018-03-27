" Don't try to be vi compatible
set nocompatible

" Load plugins here
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' } " dracula colorscheme
Plug 'terryma/vim-multiple-cursors' " multiple cursor mode
Plug 'matze/vim-move' " move blocks of text up and down
Plug 'scrooloose/syntastic' " syntax checker
Plug 'scrooloose/nerdtree' " file tree viewer
Plug 'tpope/vim-surround' " surround text easily
Plug 'scrooloose/nerdcommenter' " comment helper
Plug 'airblade/vim-gitgutter' " git visual helpers
Plug 'tpope/vim-repeat' " better .
Plug 'gregsexton/matchtag' " html/xml/jsx tag matching
Plug 'Xuyuanp/nerdtree-git-plugin' " git visual helpers in NERDTree
Plug 'ctrlpvim/ctrlp.vim' " fuzzy file finder
Plug 'vim-airline/vim-airline' " status bar
Plug 'mxw/vim-jsx' " better jsx support
Plug 'mileszs/ack.vim' " better grepping
Plug 'vim-scripts/mru.vim' " most recently used files
Plug 'pangloss/vim-javascript' " better js support
Plug 'othree/html5.vim' " better html support
Plug 'vim-scripts/matchit.zip' " better matching
Plug 'alvan/vim-closetag' " autoclose tags
Plug 'tpope/vim-fugitive' " git utilities
Plug 'jiangmiao/auto-pairs' " autoclose ({[ etc
Plug 'leafgarland/typescript-vim' " ts support
Plug 'ajh17/vimcompletesme' " smart tab completion
Plug 'ryanoasis/vim-devicons' " file icons

call plug#end()

" Colors
set t_Co=256
syntax on
color dracula
let g:airline_theme='dracula'

" JS Syntax
hi link jsClassProperty jsClassFuncName
hi link jsFuncCall jsClassFuncName

"  leader key
let mapleader = ","

" Security
set modelines=0

" Show relative line numbers
" set relativenumber

" Set split to below and right, more natural
set splitbelow
set splitright

" Show line numbers
set nu

" Show file stats
set ruler

" Disable error beeping and blinking
set novisualbell
set noerrorbells

" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

function! SetTab2()
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
endfunction

" Visual line movement instead of physical
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" Encoding
set encoding=utf-8

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Wildmenu for command autocomplete
set wildmenu
set wildmode=longest:full,full

" Highlight current line
set cursorline

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1

" Visualize tabs and newlines
set listchars=tab:»\ ,eol:¬,space:·
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Save on loss of focus
" au FocusLost * :wa

" Clean up trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Start NERDTree if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open NERDTree with directories
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Open NERDTree
map <leader>. :NERDTreeToggle<CR>

" Reveal current file in NERDTree
nmap <leader>/ :NERDTreeFind<CR>

" Close NERDTree if it is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Show hidden files by default in NERDTree
let NERDTreeShowHidden=1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Enable mouse
set mouse=a

" Reload unchanged file buffers if the file changes
set autoread

" JSX for .jsx and .js files
let g:jsx_ext_required = 0

" Better movement between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" TODO: Tag colors
hi link xmlEndTag xmlTag
hi link htmlEndTag htmlTag
hi link htmlTagN htmlTag
hi link htmlTagName htmlTag

" Autoclose extensions
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx"

" Ack
map <leader>a :Ack!

" If The Silver Searcher is installed, use it
if executable('ag')
    " with :Ack
    let g:ackprg='ag --nogroup --nocolor --column'

    " Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command='ag --literal --files-with-matches --nocolor --hidden --ignore .git -g "" %s'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

" Ctrlp ignore
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

" Color the 100th column to keep text a good width
set colorcolumn=100

" Movr blocks of text up and down with
let g:move_key_modifier = 0
vmap zj <Plug>MoveBlockDown
vmap zk <Plug>MoveBlockUp
nmap zj <Plug>MoveLineDown
nmap zk <Plug>MoveLineUp

" Syntax identifier
function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Backups, swaps, and undo file locations outside of working dir
if !isdirectory($HOME.'/.vim/swaps')
    silent call mkdir ($HOME.'/.vim/swaps', 'p')
endif
if !isdirectory($HOME.'/.vim/backups')
    silent call mkdir ($HOME.'/.vim/backups', 'p')
endif
if !isdirectory($HOME.'/.vim/undos')
    silent call mkdir ($HOME.'/.vim/undos', 'p')
endif
set directory=$HOME/.vim/swaps//
set backupdir=$HOME/.vim/backups//
set undodir=$HOME/.vim/undos//

set undofile
set undolevels=1000
set undoreload=10000
