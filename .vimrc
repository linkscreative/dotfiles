filetype off
filetype plugin indent on
syntax on
set nocompatible               " be iMproved
"set t_Co=256
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

set modelines=0

Bundle 'gmarik/vundle'
Bundle 'python.vim'
Bundle 'tpope/vim-fugitive'
"let g:Powerline_symbols = 'fancy'

set number
set rnu
filetype plugin indent on

autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set encoding=utf-8
set scrolloff=3
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2

"nnoremap / /\v
"vnoremap / /\v
"set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85
nnoremap j gj
nnoremap k gk
nnoremap ; :
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

command! W w !sudo tee % > /dev/null
