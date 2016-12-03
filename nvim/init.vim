" Plugins
call plug#begin('~/.config/nvim/plugged') " Plugins go here
Plug 'altercation/vim-colors-solarized' " Colours!
Plug 'neomake/neomake'                  " Syntax and Compiler and Linter
Plug 'bling/vim-airline'                " Airline gui
Plug 'vim-airline/vim-airline-themes'   " Airline themes
Plug 'tpope/vim-fugitive'               " Git in Vim
Plug 'mhinz/vim-signify'                " Sign column diffs
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Completion
Plug 'zchee/deoplete-clang'             " Completion for C(++)
Plug 'rhysd/vim-clang-format'           " Formatting for Code
Plug 'eagletmt/neco-ghc'                " Completion for Haskell
Plug 'bitc/vim-hdevtools'               " Types for Haskell
Plug 'junegunn/fzf', { 'div': '~/.fzf', 'do': './install -all' }
Plug 'tmhedberg/matchit'                " % Match based jumping
Plug 'chrisbra/csv.vim'                 " Tables
Plug 'neovimhaskell/haskell-vim'        " Haskell syntax
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
set gdefault smartcase ignorecase incsearch nohlsearch

" Manage folds
set foldmethod=manual foldlevel=0
au BufWritePre * :mkview
au BufRead * :try|loadview|catch|endtry

" Move (and move text) vertically on split lines
map j gj
map k gk
"<A-j>
nnoremap ∆ :m .+1<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
"<A-k>
nnoremap ˚ :m .-2<CR>==
inoremap ˚ <Esc>:m .-2<CR>==gi
nnoremap Q q
set nostartofline

" Key mappings
map <leader>r :mode<CR>
nnoremap <leader>i :%s/  *$//c<CR>gg=G<CR>
au FileType c,cpp,javascript,java nnoremap <leader>i :ClangFormat<CR>
tnoremap <Esc> <C-\><C-n>
map <leader>s :so ~/.config/nvim/init.vim<CR>:PlugClean<CR>:PlugInstall<CR>
" Deoplete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Write as sudo
cmap w!! w !sudo tee % >/dev/null

" Indent
set tabstop=4 softtabstop=4 shiftwidth=4
set smarttab shiftround expandtab autoindent copyindent

" Git
nnoremap <leader>g :Gstatus<CR><CR>
nnoremap <leader>c :Gcommit<CR>
nnoremap <leader>b :Gblame<CR>
nnoremap <leader>v :Gmove

" Control files
map <leader>\ :vsp<space>
map <leader>- :sp<space>
map <leader>e :e<space>
map <leader>n :bn<CR>
map <leader>m :bp<CR>
map <leader>q :bd<CR>
map <leader>w :w<CR>

" Splits
set splitbelow splitright
map <silent> <leader>h :wincmd h<CR>
map <silent> <leader>j :wincmd j<CR>
map <silent> <leader>k :wincmd k<CR>
map <silent> <leader>l :wincmd l<CR>

" NeoMake
let g:neomake_rust_enabled_makers = ['cargo']
let g:neomake_haskell_enabled_makers = ['ghcmod', 'hlint']
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_maker = {
            \ 'exe': 'clang++',
            \ 'args': ["-std=c++14", '-Wall', '-Wextra'],
            \ }
let g:neomake_python_enabled_makers = ['pylint']
let g:neomake_markdown_enabled_makers = ['mdl']
let g:neomake_markdown_mdl_args = ["-r", "~MD007", "~MD013"]
au BufWritePre * :silent! Neomake " Includes auto tidy for html etc

function! LocationNext()
    try
        lnext
    catch
        try | lfirst | catch | endtry
    endtry
endfunction

nnoremap <leader>e :call LocationNext()<CR>

au FocusGained,BufEnter * :silent! !

" Cpp add template files
au BufNewFile,BufRead *.tem set filetype=cpp

" Html Options
au FileType html,css,javascript setl sw=2 sts=2 et
au BufRead,BufNewFile *.md,gitcommit,*.txt setlocal spell
au BufWritePre,BufRead *.html :normal gg=G
:iabbrev </ </<C-X><C-O>
" Open in chrome
au BufEnter *.md       map <leader>p :!clear;exec chrome % &>/dev/null &<CR><CR>
au BufEnter *.markdown map <leader>p :!clear;exec chrome % &>/dev/null &<CR><CR>
au BufEnter *.html     map <leader>p :!clear;exec chrome % &>/dev/null &<CR><CR>

" Program Options
au BufEnter *.sh  map <silent> <leader>p :vsp \| term sh % <CR>
au BufEnter *.py  map <silent> <leader>p :vsp \| term python % <CR>
au BufEnter *.js  map <silent> <leader>p :vsp \| term node % <CR>
au BufEnter *.hs  map <silent> <leader>p :vsp \| term runhaskell -Wall -fno-warn-unused-binds % <CR>
au BufEnter *.cpp map <silent> <leader>p :vsp \| term g++ % -Wall -Werror -std=c++14; ./a.out <CR>
au BufEnter *.pde map <silent> <leader>p :vsp \| term processing-java --sketch=`pwd` --present 2&> .log & <CR>

" No more arrow keys
map <Up>    <NOP>
map <Down>  <NOP>
map <Left>  <<
map <Right> >>

" Fix resize bug
au VimResized * :silent! mode<CR>
au BufEnter * :silent! mode<CR>
