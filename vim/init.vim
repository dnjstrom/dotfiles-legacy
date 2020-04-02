set langmenu=en_US.UTF-8

call plug#begin()
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-repeat'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-unimpaired'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-surround'
Plug 'ElmCast/elm-vim'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'othree/yajs.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mxw/vim-jsx'
Plug 'sbdchd/neoformat'
Plug 'terryma/vim-multiple-cursors'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-signify'
Plug 'jiangmiao/auto-pairs'
Plug 'chrisbra/Colorizer'
Plug 'jacoborus/tender.vim'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
call plug#end()


set termguicolors
syntax enable

set background=dark
colorscheme base16-snazzy
let g:airline_theme='base16'

set shell=/bin/bash

" Enable filetype plugins.
filetype plugin on
filetype indent on

set cursorline
set number " Show line numbers in left gutter
set ruler " Display the current line and column
set showmatch " Highlight matching brackets
set nowrap " Don't soft wrap lines
set noerrorbells visualbell t_vb= " Disable all errorbells
set mouse=a " Enable using the mouse

" Allow modelines at the top or bottom of files.
set modeline
set modelines=5

" Enable autocompletion of vim-commands.
set wildmenu
set wildmode=longest:list,full
set wildignore+=*/node_modules/*
set wildignore+=*/bower_components/*

" Use 2 spaces for indentation.
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Don't actually close unsaved buffers, just hide them while
" you edit the other buffer.
set hidden

set incsearch " Show search results as you type
set hlsearch " Highlight matching search results
set nohlsearch "Don't hilight search results

" Use the system clipboard as the default clipboard.
set clipboard=unnamed

" Turn on autocompletion
set omnifunc=syntaxcomplete#Complete

" Use an intuitive horizontal scroll
set sidescroll=1

" Persistent undo
set undofile
set undodir=$HOME/.vim/undo//
set undolevels=1000
set undoreload=10000

" Global backup directory
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/backup//

" Define how files are saved in order to support file watchers
set backupcopy=yes


" Use space as the leader key.
map <space> <leader>

nnoremap j gj
nnoremap k gk

" Clear highlights
map <leader>c :nohl<CR>

" Easily reload the vim config.
command! Reload so $MYVIMRC

" UI fixes

" Allow for saving/quitting with lazy shift key.
command! W w
command! Q q
command! Wq wq
command! WQ wq


" Automatically clear search highlights when entering insert mode.
autocmd InsertEnter * :nohlsearch | redraw


" Indent pasted text to match target.
nnoremap p ]p

" Make 'yank rest of line' consistent with 'delete' and 'change'.
nnoremap Y y$

" Set settings and keymaps for split windows
set splitbelow
set splitright

" Workaround for https://github.com/christoomey/vim-tmux-navigator#it-doesnt-work-in-neovim-specifically-c-h
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

set laststatus=2 " Always show statusline

nnoremap å <C-]>

" Plugin specic settings
let g:ycm_semantic_triggers = {
     \ 'elm' : ['.'],
     \}

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

map <leader>f :NERDTreeFind<CR>
map <leader>n :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1

map <leader> <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-s2)

let g:jsx_ext_required = 0

augroup fmt
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END
