set incsearch             " Shows the match while typing
set hlsearch              " Highlight found searches
set ignorecase            " Search case insensitive...
set smartcase             " ... but not when search pattern contains upper case characters
set gdefault              " Use 'g' flag by default with :s/foo/bar/.
set magic                 " Use 'magic' patterns (extended regular expressions).
set number
set clipboard=unnamed
set backspace=indent,eol,start
set expandtab
set shiftwidth=4
set tabstop=4
set relativenumber
set visualbell
" set noerrorbells

map <C-h> <C-w>h
map <C-k> <C-w>k
map <C-j> <C-w>j
map <C-l> <C-w>l

" Clearing highlight with ESC
" nnoremap <silent> <ESC> :nohlsearch<CR><C-L>
" noremap <ESC> :nohlsearch<CR><C-L>
nnoremap H gT
nnoremap L gt
nnoremap d "_d
nnoremap è $
nnoremap p "0p
nnoremap P "0P
vnoremap p "0p
vnoremap P "0P
nnoremap x "0x
vnoremap x "0x
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap à ^
vnoremap d "_d
vnoremap < <gv
vnoremap > >gv
vnoremap è $
vnoremap à ^
onoremap è $
onoremap à ^

