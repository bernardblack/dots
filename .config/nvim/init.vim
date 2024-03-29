"
"     ▄   ▄███▄   ████▄     ▄   ▄█ █▀▄▀█ 
"      █  █▀   ▀  █   █      █  ██ █ █ █ 
"  ██   █ ██▄▄    █   █ █     █ ██ █ ▄ █ 
"  █ █  █ █▄   ▄▀ ▀████  █    █ ▐█ █   █ 
"  █  █ █ ▀███▀           █  █   ▐    █  
"  █   ██                  █▐        ▀   
"                          ▐             
"    
call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'folke/lsp-colors.nvim'
Plug 'gruvbox-community/gruvbox'
Plug 'tomasiser/vim-code-dark'
Plug 'marko-cerovac/material.nvim'
Plug 'sainnhe/gruvbox-material'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ekalinin/Dockerfile.vim'
Plug 'airblade/vim-gitgutter'
Plug 'sansyrox/vim-python-virtualenv'
"Plug 'pearofducks/ansible-vim'
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
Plug 'jremmen/vim-ripgrep'
Plug 'chrisbra/csv.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/rainbow_parentheses.vim'
"Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set mouse=a
set nocompatible            
set encoding=UTF-8
set number
set relativenumber
set tabstop=4 
set softtabstop=4 
set shiftwidth=4
set expandtab
set nowrap
set autoindent
set smartindent
set incsearch
set hlsearch
set ignorecase
set smartcase
set hidden
set splitbelow splitright
set noshowmode

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vimspector_enable_mappings = 'HUMAN'
let g:python3_host_prog='/usr/bin/python3'

"let g:gruvbox_contrast_dark='hard'
"colorscheme gruvbox
"let g:airline_theme = 'gruvbox'

"let g:codedark_italics = 1
"let g:airline_theme = 'codedark'
"colorscheme codedark

"let g:material_style = 'darker'
"colorscheme material

let g:gruvbox_material_diagnostic_virtual_text = 'colored'
let g:gruvbox_material_diagnostic_line_highlight = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_transparent_background = 1
"let g:airline_theme = 'gruvbox_material'
colorscheme gruvbox-material

"let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let NERDTreeShowHidden = 1

let mapleader = " "

let RainbowParentheses = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-b> :bnext<CR>

map <C-D> :VimspectorReset<CR>
map <C-T> :NERDTreeToggle<CR>

au BufRead,BufNewFile *.yml set filetype=yaml.ansible
au BufRead,BufNewFile *.yaml set filetype=yaml.ansible
au BufRead,BufNewFile docker-compose*.{yaml,yml}* set ft=yaml.docker-compose
au BufRead,BufNewFile *.csv,*.dat set filetype=csv

set tags=tags
autocmd BufWritePost *.py silent! !ctags -R --exclude=.git --exclude=.idea > /dev/null;

autocmd ColorScheme * runtime plugin/diagnostic.vim

augroup run_code
    autocmd FileType python nnoremap <buffer> <C-R> :sp<CR> :term python3 %<CR> :startinsert<CR>
    autocmd FileType bash nnoremap <buffer> <C-R>  :sp<CR> :term bash %<CR> :startinsert<CR>
augroup END


set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig').pylsp.setup {
    capabilities = capabilities
  }
  -- lsp-colors
require("lsp-colors").setup({})
EOF
