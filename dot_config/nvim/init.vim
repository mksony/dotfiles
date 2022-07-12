if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
Plug 'filipdutescu/renamer.nvim', { 'branch': 'master' }
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

inoremap jk <ESC> 

" nnoremap <SPACE> <Nop>
let mapleader = " "

syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set cursorline
set nowrap
set smartcase
set nobackup
" Set relative line numbers only in insert mode
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup ENDnoswapfile 
set hlsearch
set ignorecase
set incsearch
set termguicolors
set timeoutlen=1000
set ttimeoutlen=5

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Use new regular expression engine
set re=0

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Show matching brackets when text indicator is over them
set showmatch 

" Set 7 lines to the cursor - when moving vertically using j/k

set wrap "Wrap lines
let g:markdown_folding = 0

" Smart way to move between windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" greatest remap ever
xnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
vnoremap <leader>d "_d

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Fast saving
nmap <leader>s :w!<cr>

nnoremap <M-k> <CMD>m .-2<CR>
nnoremap <M-j> <CMD>m .+1<CR>
nnoremap <M-h> <<
nnoremap <M-l> >>

inoremap <M-h> <CMD>normal <<<CR>
inoremap <M-l> <CMD>normal >><CR>
inoremap <M-k> <CMD>m .-2<CR>
inoremap <M-j> <CMD>m .+1<CR>

vnoremap <M-k> :m '<-2<CR>gv
vnoremap <M-j> :m '>+1<CR>gv
vnoremap <M-h> <gv
vnoremap <M-l> >gv


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Fast editing and reloading of vimrc configs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>v :e! ~/.config/nvim/init.vim<cr>
map <leader><leader>v :e! ~/.config/nvim/lua/lsp.lua<cr>
autocmd! bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
autocmd BufWritePre *.ts,*.tsx,*.lua,*.html,*.css,*.scss,*.graphql,*.js,*.jsx,*.json,*.md,*.yaml,*.yml,*.vue,*.rs lua vim.lsp.buf.formatting(nil, 200)

highlight ColorColumn ctermbg=0 guibg=lightgrey

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
let g:vimwiki_map_prefix = '<Leader><Leader>w'
set completeopt=menu,menuone,noselect

call plug#begin(stdpath('data') . '/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
" main one
" Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
" Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
" Install nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'machakann/vim-highlightedyank'
Plug 'vimwiki/vimwiki'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'HerringtonDarkholme/yats.vim' " TS syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim' 
Plug 'mustache/vim-mustache-handlebars'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'folke/trouble.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'wellle/targets.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
" Plug 'tami5/lspsaga.nvim', {'branch': 'nvim6.0'}
" Plug 'tami5/lspsaga.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-live-grep-raw.nvim'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'tami5/sqlite.lua'
Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'rmagatti/auto-session'
" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'github/copilot.vim'
Plug 'filipdutescu/renamer.nvim', { 'branch': 'master' }
Plug 'simrat39/rust-tools.nvim'
Plug 'Pocco81/AutoSave.nvim'

call plug#end()

lua require'nvim-treesitter.configs'.setup { indent = { enable = true }, highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

autocmd vimenter * ++nested colorscheme gruvbox

let g:coq_settings = { 'auto_start':  'shut-up', 'keymap.jump_to_mark': '' }

lua << EOF
require 'lsp'
require 'plugins/evil_lualine'
require 'plugins/telescope'
require 'plugins/lspsaga'

-- vim.lsp.set_log_level("debug")
EOF

lua <<EOF
if vim.fn.has('nvim-0.5.1') == 1 then
    vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
    vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
    vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
    vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
    vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
    vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
    vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
else
    local bufnr = vim.api.nvim_buf_get_number(0)

    vim.lsp.handlers['textDocument/references'] = function(_, _, result)
        require('lsputil.locations').references_handler(nil, result, { bufnr = bufnr }, nil)
    end

    vim.lsp.handlers['textDocument/definition'] = function(_, method, result)
        require('lsputil.locations').definition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/declaration'] = function(_, method, result)
        require('lsputil.locations').declaration_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/typeDefinition'] = function(_, method, result)
        require('lsputil.locations').typeDefinition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/implementation'] = function(_, method, result)
        require('lsputil.locations').implementation_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/documentSymbol'] = function(_, _, result, _, bufn)
        require('lsputil.symbols').document_handler(nil, result, { bufnr = bufn }, nil)
    end

    vim.lsp.handlers['textDocument/symbol'] = function(_, _, result, _, bufn)
        require('lsputil.symbols').workspace_handler(nil, result, { bufnr = bufn }, nil)
    end
end
EOF
" nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
" vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>

" nnoremap <silent> gH <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>

" nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>

" nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" nnoremap <silent> gh <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>

" nnoremap <silent><leader>rn <cmd>lua require('lspsaga.rename').rename()<CR>

" nnoremap <silent><leader>ld <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>

" nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>

" nnoremap <silent> [d <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
" nnoremap <silent> ]d <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fa <cmd>lua require("telescope").extensions.live_grep_raw.live_grep_raw()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fr <cmd>lua require('telescope').extensions.frecency.frecency()<cr>
nnoremap <leader>lws <cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>
nnoremap <leader>lds <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
" nnoremap <leader>ca <cmd>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor())<cr>
" vnoremap <silent><leader>ca :<C-U>lua require('telescope.builtin').lsp_range_code_actions()<CR>
" vmap <leader>ca <cmd>lua require('telescope.builtin').lsp_range_code_actions(require('telescope.themes').get_cursor())<cr>

" clear quickfix list
nnoremap <leader>l <cmd>call setqflist([])<cr>

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

au BufNewFile ~/vimwiki/diary/*.md :silent 0r !~/.vim/bin/generate-vimwiki-diary-template '%'

let g:camelcasemotion_key = '<leader>'

set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set signcolumn=auto

" PLUGIN: FZF
nnoremap <silent> <leader>b :Buffers<CR>
" nnoremap <silent> <C-f> :Files<CR>
" nnoremap <silent> <leader>f :Rg<CR>
nnoremap <silent> <leader>/ :BLines<CR>
nnoremap <silent> <leader>' :Marks<CR>
nnoremap <silent> <leader>g :Commits<CR>
nnoremap <silent> <leader>H :Helptags<CR>
nnoremap <silent> <leader>hh :History<CR>
nnoremap <silent> <leader>h: :History:<CR>
nnoremap <silent> <leader>h/ :History/<CR>
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.vim/fzf-history'
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
let g:fzf_layout = { 'down': '50%' }

" Trouble
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" Symbols Outline

nnoremap <silent> <C-s> <cmd>SymbolsOutline<cr>
