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
Bundle 'L9'
Bundle 'scrooloose/nerdtree'
Bundle 'alfredodeza/pytest.vim'
Bundle 'pep8'
Bundle 'tpope/vim-surround'
Bundle 'pyflakes.vim'
Bundle 'kien/ctrlp.vim'
" tab navigation like firefox
:nmap <C-PageDown> :tabn<CR>
:nmap <C-PageUp> :tabp<CR>
:nmap <C-t> :tabnew<CR>
:imap <C-t> <Esc>:tabnew<CR>


set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc
"------------------------------------------------------------
" CtrlP
"------------------------------------------------------------
" Set the max files
let g:ctrlp_max_files = 10000

" Optimize file searching
if has("unix")
    let g:ctrlp_user_command = {
                \   'types': {
                \       1: ['.git/', 'cd %s && git ls-files']
                \   },
                \   'fallback': 'find %s -type f | head -' . g:ctrlp_max_files
                \ }
endif
set number
set rnu
filetype plugin indent on

autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set showtabline=2
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

exe "set <Insert>=\<Esc>[2;*~"
exe "set <Del>=\<Esc>[3;*~"
exe "set <PageUp>=\<Esc>[5;*~"
exe "set <PageDown>=\<Esc>[6;*~"
