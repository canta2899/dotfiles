set incsearch             " Shows the match while typing
set hlsearch              " Highlight found searches
set ignorecase            " Search case insensitive...
set smartcase             " ... but not when search pattern contains upper case characters
set gdefault              " Use 'g' flag by default with :s/foo/bar/.
set magic                 " Use 'magic' patterns (extended regular expressions).
set number
set clipboard=unnamed
set relativenumber

map s<left> <C-w>h
map s<up> <C-w>k
map s<down> <C-w>j
map s<right> <C-w>l

map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l

" Clearing highlight with ESC
nnoremap <silent> <ESC> :nohlsearch<CR><C-L>
nnoremap H gT
nnoremap L gt
nnoremap d "_d
vnoremap < <gv
vnoremap > >gv

