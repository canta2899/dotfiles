syntax on
set ruler                               " Show the line and column numbers of the cursor.
set formatoptions+=o
set textwidth=0                         " Hard-wrap long lines as you type them.
set modeline                            " Enable modeline. set linespace=0                         " Set line-spacing to minimum.
set nojoinspaces                        " Prevents inserting two spaces after punctuation on a join (J)
set splitbelow                          " Horizontal split below current.
set splitright                          " Vertical split to right of current.
if !&scrolloff 
    set scrolloff=3                     " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
    set sidescrolloff=5                 " Show next 5 columns while side-scrollin.
endif
set display+=lastline
set nostartofline                       " Do not jump to first character with page commands.
set noerrorbells                        " No beeps
set backspace=indent,eol,start          " Makes backspace key more powerful.
set showcmd                             " Show me what I'm typing
set showmode                            " Show current mode.
set noswapfile                          " Don't use swapfile
set nobackup            	            " Don't create annoying backup files
set encoding=utf-8                      " Set default encoding to UTF-8
set autowrite                           " Automatically save before :next, :make etc.
set autoread                            " Automatically reread changed files without asking me anything
set laststatus=2
set fileformats=unix,dos,mac            " Prefer Unix over Windows over OS 9 formats
" set showmatch                         " Do not show matching brackets by flickering
set incsearch                           " Shows the match while typing
set hlsearch                            " Highlight found searches
set ignorecase                          " Search case insensitive...
set smartcase                           " ... but not when search pattern contains upper case characters
set autoindent
set tabstop=4 shiftwidth=4 expandtab
set gdefault                            " Use 'g' flag by default with :s/foo/bar/.
set magic                               " Use 'magic' patterns (extended regular expressions).
set number
set mouse=a
set clipboard=unnamed
set smartindent
set undodir=~/.config/nvim/undodir      "Persistent undo
set undofile
set wrap
set rtp+=/usr/local/opt/fzf

nmap te :tabedit .<Return>

nmap ss :split .<Return>
nmap sv :vsplit .<Return>

nmap <S-Tab> :tabprev<Return>
nmap <Tab> :tabnext<Return>

map <Space> <C-w>w
map s<left> <C-w>h
map s<up> <C-w>k
map s<down> <C-w>j
map s<right> <C-w>l

map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l

" Splits resizing
nnoremap <silent> <S-Up> :resize -1<CR>
nnoremap <silent> <S-Down> :resize +1<CR>
nnoremap <silent> <S-left> :vertical resize +1<CR>
nnoremap <silent> <S-right> :vertical resize -1<CR>
nnoremap <silent> <S-Tab> gT<CR>
nnoremap H gT
nnoremap L gt

" Language
map <leader>oi :setlocal spell spelllang=it<CR>

set spelllang=it

" autocmd BufWritePre <buffer> <cmd>EslintFixAll<CR>

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes

Plug 'ctrlpvim/ctrlp.vim'

Plug 'neovim/nvim-lspconfig'

Plug 'sheerun/vim-polyglot'

Plug 'junegunn/vim-easy-align'

Plug 'SirVer/ultisnips'

Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Plug 'fatih/vim-go', { 'tag': '*' }

" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'catppuccin/nvim'

Plug 'nvim-lualine/lualine.nvim'

Plug 'kyazdani42/nvim-web-devicons'

" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'karb94/neoscroll.nvim'

Plug 'godlygeek/tabular'

Plug 'plasticboy/vim-markdown'

Plug 'akinsho/toggleterm.nvim'

Plug 'windwp/nvim-autopairs'

" Initialize plugin system
call plug#end()
"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)

" Image snippet

function! AddImage()
    " Latex image insertion snippet
    r~/.config/nvim/snippets/add-image.txt
endfunction

nmap aimg :call AddImage()<CR>

" Disable markdown folding
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0
" let g:vim_markdown_auto_insert_bullets = 0

lua <<EOF
    require("toggleterm").setup{
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 20
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = '<C-t>',
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = '3', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      persist_size = true,
      direction = 'float',
      close_on_exit = true, -- close the terminal window when the process exits
      shell = vim.o.shell, -- change the default shell
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'single',
        -- winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        }
      }
    }

    require('nvim-autopairs').setup{}

    local catppuccin = require("catppuccin")

    -- configure it
    require("catppuccin").setup {
        transparent_background = true,
        term_colors = false,
        styles = {
            comments = "italic",
            functions = "NONE",
            keywords = "italic",
            strings = "NONE",
            variables = "NONE",
        },
        integrations = {
            treesitter = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = "italic",
                    hints = "italic",
                    warnings = "italic",
                    information = "italic",
                },
                underlines = {
                    errors = "underline",
                    hints = "underline",
                    warnings = "underline",
                    information = "underline",
                },
            },
            lsp_trouble = false,
            lsp_saga = false,
            gitgutter = false,
            gitsigns = false,
            telescope = false,
            nvimtree = {
                enabled = false,
                show_root = false,
            },
            which_key = false,
            indent_blankline = {
                enabled = false,
                colored_indent_levels = false,
            },
            dashboard = false,
            neogit = false,
            vim_sneak = false,
            fern = false,
            barbar = false,
            bufferline = false,
            markdown = false,
            lightspeed = false,
            ts_rainbow = false,
            hop = false,
        }
    }

    -- require'lspconfig'.pyright.setup{}
    -- require'lspconfig'.eslint.setup{}



    require('lualine').setup {
        options = {
            theme = 'catppuccin'
        }
    }

    require('neoscroll').setup()

EOF

colorscheme catppuccin

