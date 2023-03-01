set incsearch             " Shows the match while typing
set hlsearch              " Highlight found searches
set ignorecase            " Search case insensitive...
set smartcase             " ... but not when search pattern contains upper case characters
set gdefault              " Use 'g' flag by default with :s/foo/bar/.
set magic                 " Use 'magic' patterns (extended regular expressions).
set number
set clipboard=unnamed
set relativenumber
set visualbell
set noerrorbells

map <C-h> <C-w>h
map <C-k> <C-w>k
map <C-j> <C-w>j
map <C-l> <C-w>l

" Clearing highlight with ESC
nnoremap <silent> <ESC> :nohlsearch<CR><C-L>
nnoremap H gT
nnoremap L gt
nnoremap d "_d
vnoremap d "_d
vnoremap < <gv
vnoremap > >gv

