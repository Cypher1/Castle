call plug#begin('~/.config/nvim/plugged') " Plugins go here
Plug 'altercation/vim-colors-solarized' " Colours!
Plug 'neomake/neomake'                  " Syntax and Compiler and Linter
Plug 'ervandew/supertab'                " Code Completion
Plug 'bling/vim-airline'                " Airline gui
Plug 'vim-airline/vim-airline-themes'   " Airline themes
Plug 'tpope/vim-fugitive'               " Git in Vim
Plug 'mhinz/vim-signify'                " Sign column diffs
Plug 'bitc/vim-hdevtools'               " Haskell types
call plug#end()

" GUI
syntax enable
set background=dark
colorscheme solarized
highlight Comment ctermfg=DarkMagenta
highlight SignColumn ctermbg=black
set cursorline ruler relativenumber number laststatus=2
set ttimeoutlen=50 " fast key codes
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

" Input settings
let mapleader=' '
set mouse=nicr
set clipboard+=unnamedplus
set backspace=indent,eol,start
set wildmenu wildignorecase wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.out,*.hi "tab complete filenames in commands
set gdefault smartcase incsearch nohlsearch "makes sed global, caseless, display (only the) next search item
set viminfo=
set nostartofline
set backup writebackup backupdir=/tmp/
set foldmethod=manual foldlevel=0

au BufWritePre * :mkview
au BufRead * :execute "try\n    loadview\ncatch\nendtry"
au VimResized * :silent! mode<CR>
au BufEnter * :silent! mode<CR>

" Indent
set tabstop=4 softtabstop=4 shiftwidth=4
set smarttab shiftround expandtab autoindent

" Git
nnoremap <leader>gA :Git add .<CR><CR>
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>

" Key mappings
tnoremap <Esc> <C-\><C-n>
map <leader>s :source ~/.config/nvim/init.vim<CR>:PlugClean<CR>:PlugInstall<CR>
map <leader>i <ESC>:%s/  *$//<CR>
" Move vertically on split lines
map j gj
map k gk
" Splits
set splitbelow splitright
map <silent> <leader>h :wincmd h<CR>
map <silent> <leader>j :wincmd j<CR>
map <silent> <leader>k :wincmd k<CR>
map <silent> <leader>l :wincmd l<CR>
map <leader>\ :vsp<space>
map <leader>- :sp<space>
map <leader>e :e<space>
map <leader>n :bp<CR>
map <leader>m :bn<CR>
map <leader>q :bd<CR>
map <leader>w :w<CR>
map <leader>t yy:! date >> ~/.todo; pbpaste >> ~/.todo<CR><CR>
map <leader>T :vsp ~/.todo<CR><CR>

" Eval as program / processed
au BufEnter *.sh  map <silent> <leader>p :term sh % <CR>
au BufEnter *.py  map <silent> <leader>p :term python % <CR>
au BufEnter *.hs  map <silent> <leader>p :term runhaskell -Wall -fno-warn-unused-binds % <CR>
au BufEnter *.cpp map <silent> <leader>p :term g++ % -Wall -Werror -std=c++14; ./a.out <CR>

" NeoMake
let g:neomake_verbose = 3
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_maker = {
   \ 'exe': 'clang++',
   \ 'args': ["-std=c++14", '-Wall', '-Wextra'],
   \ }
let g:neomake_haskell_enabled_makers = ['hlint']
let g:neomake_python_enabled_makers = ['pylint']
let g:neomake_markdown_enabled_makers = ['mdl']
let g:neomake_markdown_mdl_args = ["-r", "~MD007", "~MD013"]
au BufWritePre * :silent! Neomake

" Open in chrome
au BufEnter *.md       map <silent> <leader>p :!clear;exec chrome % &>/dev/null &<CR><CR>
au BufEnter *.markdown map <silent> <leader>p :!clear;exec chrome % &>/dev/null &<CR><CR>
au BufEnter *.html     map <silent> <leader>p :!clear;exec chrome % &>/dev/null &<CR><CR>

" Html options
au FileType html setl sw=2 sts=2 et
au BufWritePre,BufRead *.html :normal gg=G

" No more arrow keys
map <Up>    <NOP>
map <Down>  <NOP>
map <Left>  <<
map <Right> >>
