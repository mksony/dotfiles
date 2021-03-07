inoremap jk <ESC> 

nnoremap <SPACE> <Nop>
let mapleader = " "

set number 
set noswapfile 
set hlsearch
set ignorecase
set incsearch

call plug#begin('~/.vim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-highlightedyank'

call plug#end()
