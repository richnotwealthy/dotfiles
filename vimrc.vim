" Don't try to be vi compatible
set nocompatible

" Load plugins here
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'dracula/vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'matze/vim-move'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-repeat'
Plug 'gregsexton/matchtag'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'mxw/vim-jsx'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/mru.vim'
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'vim-scripts/matchit.zip'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'leafgarland/typescript-vim'

" Plug 'valloric/youcompleteme'

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
set listchars=tab:▸\ ,eol:¬
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

" Enable mouse
set mouse=a

" Reload unchanged file buffers if the file changes
set autoread

" JSX for .jsx and .js files
" let g:jsx_ext_required = 0

" Better movement between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tab match bracket pairs
map <Tab> %

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

" Color the 120th column to keep text a good width
set colorcolumn=100

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
