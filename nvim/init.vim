" Plugins
call plug#begin('~/.config/nvim/plugged') " Plugins go here
Plug 'altercation/vim-colors-solarized' " Colours!
Plug 'neomake/neomake'                  " Syntax and Compiler and Linter
Plug 'bling/vim-airline'                " Airline gui
Plug 'vim-airline/vim-airline-themes'   " Airline themes
Plug 'xolox/vim-misc'                   " xolox dependency
Plug 'xolox/vim-session'                " Sessions
Plug 'tpope/vim-fugitive'               " Git in Vim
Plug 'mhinz/vim-signify'                " Sign column diffs
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Completion
Plug 'zchee/deoplete-clang'             " Completion for C(++)
Plug 'eagletmt/neco-ghc'                         " Completion for Haskell
call plug#end()

" Colour Scheme
syntax enable
set background=dark
colorscheme solarized
highlight Comment ctermfg=DarkMagenta
highlight SignColumn ctermbg=black

" Status Information
set cursorline ruler relativenumber number laststatus=2
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
set list listchars=tab:>.,trail:.,extends:#,nbsp:.

" Input settings
let mapleader=' '
set mouse=nicr
set ttimeoutlen=50 " fast key codes
set clipboard+=unnamedplus
set backspace=indent,eol,start
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = "/usr/local/Cellar/llvm37/3.7.1/lib/llvm-3.7/lib/libclang.dylib"
set sessionoptions-=options
let g:session_command_aliases = 1

" Change vim options
" Handle buffer backups and closing
set backup writebackup backupdir=/tmp/ hidden

" Tab complete filenames in commands
set wildmenu wildignorecase wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.hi,*.gch

"makes sed global, caseless, display (only the) next search item
set gdefault smartcase incsearch nohlsearch

" Manage folds
set foldmethod=manual foldlevel=0
au BufWritePre * :mkview
au BufRead * :try|loadview|catch|endtry

" Move vertically on split lines
map j gj
map k gk
set nostartofline

" Key mappings
tnoremap <Esc> <C-\><C-n>
map <leader>s :so ~/.config/nvim/init.vim<CR>:PlugClean<CR>:PlugInstall<CR>
"Deoplete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

function! AutoFormat()
    let l:save = winsaveview() " Save cursor
    %s/\t/    /e               " Tabs to spaces
    %s/\s\s*$//e               " Remove trailing spaces
    %s/){/) {/ce               " Enforce styles
    %s/{ \([^/]\)/{\1/ce       " Enforce styles
    %s/\([^/ ]\) }/\1}/ce      " Enforce styles
    execute "normal gg=G"
    call winrestview(l:save)   " Reset cursor
endfunction
nnoremap <leader>i :call AutoFormat()<CR>

" Write as sudo
cmap w!! w !sudo tee % >/dev/null

" Indent
set tabstop=4 softtabstop=4 shiftwidth=4
set smarttab shiftround expandtab autoindent copyindent

" Git
nnoremap <leader>gA :Git add .<CR><CR>
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gb :Gblame<CR>

" Control files
map <leader>\ :vsp<space>
map <leader>- :sp<space>
map <leader>e :e<space>
map <leader>n :bn<CR>
map <leader>m :bp<CR>
map <leader>q :bd<CR>
map <leader>w :w<CR>

" NERD Tree Options
let NERDTreeQuitOnOpen = 1
map <leader>f :NERDTreeToggle<CR>

" Splits
set splitbelow splitright
map <silent> <leader>h :wincmd h<CR>
map <silent> <leader>j :wincmd j<CR>
map <silent> <leader>k :wincmd k<CR>
map <silent> <leader>l :wincmd l<CR>

" NeoMake
let g:neomake_haskell_enabled_makers = ['ghcmod']
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_maker = {
   \ 'exe': 'clang++',
   \ 'args': ["-std=c++14", '-Wall', '-Wextra'],
   \ }
let g:neomake_haskell_enabled_makers = ['ghcmod']
let g:neomake_python_enabled_makers = ['pylint']
let g:neomake_markdown_enabled_makers = ['mdl']
let g:neomake_markdown_mdl_args = ["-r", "~MD007", "~MD013"]
au BufWritePre * :silent! Neomake

function! LocationNext()
  try
    lnext
  catch
    try | lfirst | catch | endtry
  endtry
endfunction

nnoremap <leader>e :call LocationNext()<CR>

" Cpp add template files
au BufNewFile,BufRead *.tem set filetype=cpp

" Html Options
au FileType html setl sw=2 sts=2 et
au BufWritePre,BufRead *.html :normal gg=G
:iabbrev </ </<C-X><C-O>
" Open in chrome
au BufEnter *.md       map <leader>p :!clear;exec chrome % &>/dev/null &<CR><CR>
au BufEnter *.markdown map <leader>p :!clear;exec chrome % &>/dev/null &<CR><CR>
au BufEnter *.html     map <leader>p :!clear;exec chrome % &>/dev/null &<CR><CR>

" Program Options
au BufEnter *.sh  map <silent> <leader>p :term sh % <CR>
au BufEnter *.py  map <silent> <leader>p :term python % <CR>
au BufEnter *.hs  map <silent> <leader>p :term runhaskell -Wall -fno-warn-unused-binds % <CR>
au BufEnter *.cpp map <silent> <leader>p :term g++ % -Wall -Werror -std=c++14; ./a.out <CR>

" No more arrow keys
map <Up>    <NOP>
map <Down>  <NOP>
map <Left>  <<
map <Right> >>

" Fix resize bug
au VimResized * :silent! mode<CR>
au BufEnter * :silent! mode<CR>
