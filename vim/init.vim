set langmenu=en_US.UTF-8

" Plugins {{{
call plug#begin()

" Backend features
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Shougo/neomru.vim'

" Looks
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'lifepillar/vim-solarized8'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0ng/vim-hybrid'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'jnurmine/Zenburn'
Plug 'tomasr/molokai'
Plug 'zeis/vim-kolor'

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'ludovicchabant/vim-gutentags'
Plug 'ternjs/tern_for_vim'
Plug 'eagletmt/neco-ghc'
Plug 'Shougo/neco-vim'
Plug 'vim-ruby/vim-ruby'
Plug 'craigemery/vim-autotag'
Plug 'majutsushi/tagbar'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

" Snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'mxw/vim-jsx'
Plug 'kchmck/vim-coffee-script'
Plug 'wavded/vim-stylus'
Plug 'othree/yajs.vim' " es6
Plug 'othree/es.next.syntax.vim' " es7+
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
Plug 'vim-scripts/haskell.vim'
Plug 'vim-scripts/cabal.vim'

" Features
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
" Plug 'ervandew/supertab'

" Editor
Plug 'tmhedberg/matchit'
Plug 'Raimondi/delimitMate'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
Plug 'ap/vim-css-color'
Plug 'qwertologe/nextval.vim'

" Configuration
Plug 'editorconfig/editorconfig-vim'

" Linting
Plug 'scrooloose/syntastic'

" Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'

call plug#end()
" }}}

" Plugin Configuration {{{

" Neosnippets
let g:neosnippet#snippets_directory='~/.dotfiles/vim/snippets'

" NERDTree
map <leader>n :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1


" Emmet
" Right after opening vim, remap Shift-Tab to Emmet expansion.
" Doing it this way is necessary since SuperTab would override a normal mapping
" since it loads after vimrc.
autocmd VimEnter * imap <S-Tab> <C-Y>,

" vim-jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay=50

"
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" Syntastic recomended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height=3
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let syntastic_mode_map = { 'passive_filetypes': ['html', 'hbs'] }
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['rubocop', 'mri']

" Ack.vim
if executable('ag')
let g:ackprg = 'ag -i -Q --vimgrep'
endif

" Easymotion
" let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0

" Tabularize
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>
nmap <leader>a, :Tabularize /,\zs<CR>
vmap <leader>a, :Tabularize /,\zs<CR>

" Denite
let g:denite_source_history_yank_enable=1
if executable('ag')
  let g:denite_source_grep_command='ag'
  let g:denite_source_grep_default_opts='--hidden --nocolor --nogroup -S -U'
  let g:denite_source_grep_recursive_opt=''
  let g:denite_source_rec_async_command = ['ag', '--follow', '--nogroup', '--nocolor', '--hidden', '-g', '']
  call denite#custom#var("file_rec", "command", ['ag', '--follow', '--nogroup', '--nocolor', '--hidden', '-g', ''])
endif
" call denite#filters#matcher_default#use(['matcher_fuzzy'])
" call denite#filters#sorter_default#use(['sorter_rank'])

autocmd FileType Denite call s:denite_settings()
function! s:denite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(denite_move_to_next_line)
  imap <buffer> <C-k>   <Plug>(denite_move_to_previous_line)
endfunction

nnoremap <leader><space> :Denite file_rec<cr>
nnoremap <leader>p :Denite buffer<cr>
nnoremap <leader>r :Denite outline<cr>
nnoremap <leader>/ :Denite line<cr>
" nnoremap <leader>/ :Denite -buffer-name=ag -no-empty -no-split -auto-preview grep:.<cr>

nmap <silent> <unique> + <Plug>nextvalInc
nmap <silent> <unique> - <Plug>nextvalDec

let g:tern#command = ["/Users/dstr/.nvm/versions/node/v7.9.0/bin/node", '/Users/dstr/.dotfiles/vim/plugged/tern_for_vim/node_modules/tern/bin/tern', '--no-port-file']

"}}}

" Theme {{{
syntax enable
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set background=light
"let g:gruvbox_italic=1
"let g:gruvbox_contrast_dark='medium'
"let g:gruvbox_sign_column='bg0'
colorscheme base16-github
"highlight CursorLine guibg=#32302f
"highlight CursorLineNr guibg=#32302f
"highlight Folded guibg=#32302f
"}}}

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


"set colorcolumn=81

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
"autocmd InsertEnter * :nohlsearch | redraw


" Indent pasted text to match target.
nnoremap p ]p

" Make 'yank rest of line' consistent with 'delete' and 'change'.
nnoremap Y y$

" Fix inconsist shift meaning for forward and backwards movements.
nnoremap , ;
nnoremap ; ,

" Set settings and keymaps for split windows
set splitbelow
set splitright

" Workaround for https://github.com/christoomey/vim-tmux-navigator#it-doesnt-work-in-neovim-specifically-c-h
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

set laststatus=2 " Always show statusline

nnoremap å <C-]>

" Haskell bindings
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

" Set folding by marker for this file only.
" vim:foldmethod=marker
