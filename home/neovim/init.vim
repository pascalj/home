set completeopt-=preview
set shortmess=a
" ----

" Settings
let g:airline_theme='moonfly'
let g:moonflyWinSeparator = 2
set fillchars="horiz:━,horizup:┻,horizdown:┳,vert:┃,vertleft:┨,vertright:┣,verthoriz:╋"
let g:airline_powerline_fonts = 1
let g:netrw_list_hide = "^\\." 
let g:netrw_sort_sequence = '[\/]$,*,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$' 
let g:ctrlp_working_path_mode = "r"
let g:ag_working_path_mode="r"
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore='\v[\/]db\/migrate$'
let g:ycm_min_num_of_chars_for_completion = 99 
let g:localvimrc_ask=0
let g:localvimrc_sandbox=0
let g:pandoc#syntax#conceal#use=0
let g:pandoc#syntax#style#underline_special=0
let g:pandoc#modules#disabled = ['folding']
let g:netrw_banner = 0
let g:netrw_list_hide='.*\.swp$,*/tmp/*,*.so,*.swp,^__*,*.zip,*.git,^\.\.\=/\=$,\(^\|\s\s\)\zs\.\S\+'

let g:goyo_width = 130


set directory=$HOME/.vim/swapfiles//

" -- Mappings
let mapleader=","
nmap - :Explore<CR>
nmap _ :Hexplore<CR>
map <Leader>n :noh<CR>
map <Leader>j :Make!<CR>
map <C-p> :GFiles<CR>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <C-b> :pyf /usr/share/clang/clang-format.py<cr>

" statusbar
set laststatus=2

" invisibles
nmap <leader>l :set list!<CR>
nmap <leader>p :set invpaste paste?<CR>
nmap <S-TAB> <<
nmap <TAB> >>
vmap <S-TAB> <gv
vmap <TAB> >gv
nmap <CR> o<Esc>


" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on
  filetype plugin indent on
   
  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
   
  " Customisations based on house-style (arbitrary)
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType cpp setlocal sw=2 tabstop=2
  autocmd FileType cpp let g:ale_sign_column_always = 1
  set signcolumn=yes
   
  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml

  " Focus
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
endif

hi clear

if exists("syntax_on")
  syntax reset
endif


" highlight only current buffer/window
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

set cursorline
set number 
set incsearch
set hlsearch
set autoindent
set expandtab
set noshowmode
set splitbelow
set splitright
let g:bufferline_echo = 0
set termguicolors

syntax on

colorscheme moonfly

lua << EOF
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
end

require'lspconfig'.clangd.setup{on_attach = on_attach}
EOF
