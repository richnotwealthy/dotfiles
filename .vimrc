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

" Plug 'valloric/youcompleteme'

call plug#end()

" Colors
set t_Co=256
syntax on
color dracula
let g:airline_theme='dracula'

"  leader key
let mapleader = ","

" Security
set modelines=0

" Show relative line numbers
set relativenumber

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

" Close NERDTree if it is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Show hidden files by default in NERDTree
let NERDTreeShowHidden=1

" Enable mouse
set mouse=a

" JSX for .jsx and .js files
" let g:jsx_ext_required = 0

" Better movement between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tab match bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" Ack
nnoremap <leader>a :Ack

" Backup and swap file locations outside of working dir
if !isdirectory($HOME.'/.vim/swaps')
    silent call mkdir ($HOME.'/.vim/swaps', 'p')
endif
if !isdirectory($HOME.'/.vim/backups')
    silent call mkdir ($HOME.'/.vim/backups', 'p')
endif
set directory=$HOME/.vim/swaps//
set backupdir=$HOME/.vim/backups//
