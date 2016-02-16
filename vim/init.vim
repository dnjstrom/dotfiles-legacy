
" Plugins {{{
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'ludovicchabant/vim-gutentags'
Plug 'ervandew/supertab'
Plug 'Raimondi/delimitMate'
Plug 'mattn/emmet-vim'
call plug#end()
" }}}

" Plugin Configuration {{{

" CtrlP
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" SuperTab

" Emmet
" Right after opening vim, remap Shift-Tab to Emmet expansion.
" Doing it this way is necessary since SuperTab would override a normal mapping
" since it loads after vimrc.
autocmd VimEnter * imap <S-Tab> <C-Y>,

" }}}

" Theme {{{
syntax enable
set background=dark
colorscheme gruvbox

" Reset background colors to transparent
"hi Normal ctermbg=none
"hi None ctermbg=none
"
set guifont=Source\ Code\ Pro:h15
"}}}

" Enable filetype plugins.
filetype plugin on
filetype indent on

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

set incsearch " Show search results as you type
set hlsearch " Highlight matching search results

" Use the system clipboard as the default clipboard.
set clipboard=unnamed

set omnifunc=syntaxcomplete#Complete

" Easily reload the vim config.
command! Reload so $MYVIMRC

" UI fixes

" Allow for saving/quitting with lazy shift key.
command! W w
command! Q q
command! Wq wq
command! WQ wq



" Indent pasted text to match target.
nnoremap p ]p

" Make 'yank rest of line' consistent with 'delete' and 'change'.
nnoremap Y y$

" Set folding by marker for this file only.
" vim:foldmethod=marker
