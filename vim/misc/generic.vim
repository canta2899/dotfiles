" Customization for vanilla nvim

syntax on
set ruler                               " Show the line and column numbers of the cursor.
set formatoptions+=o
set textwidth=0                         " Hard-wrap long lines as you type them.
set modeline                            " Enable modeline. set linespace=0
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

" map <Space> <C-w>w  it's annoying if you also map space as leader 
map <C-h> <C-w>h
map <C-k> <C-w>k
map <C-j> <C-w>j
map <C-l> <C-w>l

" Clearing highlight with Ctrl + L
"nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

nnoremap <ESC> :noh <CR><C-L>

" Splits resizing
nnoremap <silent> <S-Up> :resize -1<CR>
nnoremap <silent> <S-Down> :resize +1<CR>
nnoremap <silent> <S-left> :vertical resize +1<CR>
nnoremap <silent> <S-right> :vertical resize -1<CR>
nnoremap <silent> <S-Tab> gT<CR>
nnoremap H gT
nnoremap L gt
nnoremap d "_d
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap n nzzzv
nnoremap N Nzzzv
vnoremap < <gv
vnoremap > >gv

" Language
map <leader>oi :setlocal spell spelllang=it<CR>

set spelllang=it

