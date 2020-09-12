" Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" Plug 'fatih/vim-go'
Plug 'christoomey/vim-tmux-navigator'
Plug 'wellle/context.vim'
if has('nvim')
  Plug 'neovim/nvim-lsp'
  Plug 'nvim-lua/completion-nvim'
  Plug 'steelsojka/completion-buffers'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'nvim-treesitter/completion-treesitter'
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"  Plug 'Shougo/deoplete-lsp'
endif
call plug#end()

" Set base settings
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
set smartindent
set shiftwidth=2 " number of spaces when shift indenting
set tabstop=2 " number of visual spaces per tab
set softtabstop=2 " number of spaces in tab when editing
set expandtab " tab to spaces
set nu
set rnu
set cursorline  " highlight current line
set noruler
set noshowmode
set hidden
set showmatch
set incsearch
set hlsearch
set title
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*.bak,*.pyc,*.class
set visualbell
set noerrorbells
set vb t_vb=
set nobackup
set noswapfile
set smarttab
set splitbelow
set splitright
set laststatus=2
set ai "Auto indent
set backspace=indent,eol,start
set linebreak

" Code
syntax on
filetype plugin indent on

" Themes/Colors
color dracula
let g:airline_theme = 'dracula'
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#branch#enabled = 1

" Keybindings

" Navigation
if has('nvim')
  nnoremap <M-j> :m .+1<CR>
  nnoremap <M-k> :m .-2<CR>==
  inoremap <M-j> <Esc>:m .+1<CR>==gi
  inoremap <M-k> <Esc>:m .-2<CR>==gi
  vnoremap <M-j> :m '>+1<CR>gv=gv
  vnoremap <M-k> :m '<-2<CR>gv=gv
endif
nnoremap j gj
nnoremap k gk

" Buffer Navigation
map <C-Left> <Esc>:bprev<CR>
map <C-Right> <Esc>:bnext<CR>

" Leader
let mapleader=","
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Modes
inoremap <C-s> <Esc>:w<CR>
nnoremap <C-s> :w<CR>
inoremap jk <Esc>
inoremap kj <Esc>

" Miscellaneous
nmap 0 ^
cmap w!! w !sudo tee % >/dev/null
noremap <leader>, <esc>:w<cr>

" Modifications
:nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
:vnoremap <leader>" <esc>m`'<i"<esc>A"<esc>``

" Searching
map <space> /
nmap <silent> ,/ :nohlsearch<CR>
map <C-space> ?
nmap <silent> <leader><space> :nohlsearch<CR>
nnoremap <silent> <leader>f :GFiles<CR>

" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --vimgrep
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
  map <leader><space> :Ag<space>
endif

" LSP
if has('nvim')
  let g:python3_host_prog = '~/pyenvs/neovim/env/bin/python'

lua <<EOF
    local nvim_lsp = require'nvim_lsp'
    nvim_lsp.pyls.setup{}
    nvim_lsp.gopls.setup{
      root_dir = nvim_lsp.util.root_pattern('.git');
    }
    nvim_lsp.rust_analyzer.setup{}
    require'nvim-treesitter.configs'.setup{}
EOF

  " Use <Tab> and <S-Tab> to navigate through popup menu
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  " Set completeopt to have a better completion experience
  set completeopt=menuone,noinsert,noselect

  " Avoid showing message extra message when using completion
  set shortmess+=c

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  set signcolumn=yes

  " lua require'nvim_lsp'.gopls.setup{on_attach=require'completion'.on_attach}
  autocmd BufEnter * lua require'completion'.on_attach()

  let s:lsp_chain_config = [
    \ {'complete_items': ['lsp']},
    \ {'mode': '<c-p>'},
    \ {'mode': '<c-n>'},
    \ {'mode': 'file'},
  \ ]
  let g:completion_chain_complete_list = {
    \ 'default': [
      \ {'complete_items': ['buffers']},
      \ {'mode': '<c-p>'},
      \ {'mode': '<c-n>'}
    \ ],
    \ 'go': s:lsp_chain_config,
    \ 'python': s:lsp_chain_config,
    \ 'cpp': s:lsp_chain_config,
    \ 'rust': s:lsp_chain_config
  \ }

  autocmd Filetype python,go setl omnifunc=v:lua.vim.lsp.omnifunc
  nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
  nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
  nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
endif

