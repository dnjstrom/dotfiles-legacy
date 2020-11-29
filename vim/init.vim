set langmenu=en_US.UTF-8

call plug#begin()

" Features
Plug 'neovim/nvim-lspconfig'
Plug 'scrooloose/nerdtree'
Plug 'sbdchd/neoformat'
Plug 'w0rp/ale'
Plug 'tpope/vim-repeat'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'nvim-lua/completion-nvim'

" Tmux integration
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'

" Visualization
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-signify'
Plug 'chrisbra/Colorizer'

" Javascript
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'mxw/vim-jsx'

" Typescript
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'

" Themes
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline-themes'

call plug#end()


set termguicolors
syntax enable

set background=dark
colorscheme base16-snazzy
hi Normal guibg=NONE ctermbg=NONE

let g:airline_theme='base16'
let g:airline_powerline_fonts = 1

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
set nohlsearch " Don't hilight search results

" Use the system clipboard as the default clipboard.
set clipboard=unnamed

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

set autoread

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

inoremap § <ESC>
vnoremap § <ESC>

" Set settings and keymaps for split windows
set splitbelow
set splitright

set laststatus=2 " Always show statusline


" Plugin specic settings
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Automatically format on save
augroup fmt
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END

function MyNerdToggle()
  if &filetype == 'nerdtree'
      :NERDTreeToggle
  else
      :NERDTreeFind
  endif
endfunction

nnoremap <leader><space> :call MyNerdToggle()<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1

map <leader> <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-s2)

" Easy movement in quickfix window
noremap <A-n> :cn<CR>
noremap ‘ :cn<CR>
noremap <A-p> :cn<CR>
noremap π :cp<CR>


" Language servers
lua <<EOF
require'lspconfig'.tsserver.setup{}
EOF

autocmd Filetype javascript setlocal omnifunc=v:lua.vim.lsp.omnifunc

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>

" Autocompletion
autocmd BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
