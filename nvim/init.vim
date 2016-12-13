" Plugins
call plug#begin('~/.config/nvim/plugged') " Plugins go here
Plug 'altercation/vim-colors-solarized' " Colours!
Plug 'bling/vim-airline'                " Airline gui
Plug 'vim-airline/vim-airline-themes'   " Airline themes
Plug 'tpope/vim-fugitive'               " Git in Vim
Plug 'mhinz/vim-signify'                " Sign column diffs
Plug 'rbgrouleff/bclose.vim'            " Close properly
Plug 'tmhedberg/matchit'                " % Match based jumping
Plug 'chrisbra/csv.vim'                 " Tables
Plug 'neomake/neomake'                  " Syntax and Compiler and Linter
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Completion
Plug 'zchee/deoplete-clang'             " Completion for C(++)
Plug 'rhysd/vim-clang-format'           " Formatting for Code
Plug 'eagletmt/neco-ghc'                " Haskell Completion
Plug 'bitc/vim-hdevtools'               " Haskell Types
Plug 'neovimhaskell/haskell-vim'        " Haskell Syntax
Plug 'itchyny/vim-haskell-indent'       " Haskell Indent
Plug 'mxw/vim-xhp'                      " Xhp indent and syntax
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
if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif
map <leader>s :so ~/.config/nvim/init.vim<CR>:PlugClean<CR>:PlugInstall<CR>
" Haskell
let g:haskell_indent_disable=0
map <leader>t :HdevtoolsType<CR>
map <leader>T :HdevtoolsClear<CR>
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
map <leader>q :Bclose<CR>
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
nnoremap ¬ :lopen<CR>
"<A-L>
nnoremap ˙ :lclose<CR>
"<A-H>

au FocusGained,BufEnter * :silent! !

" Cpp add template files
au BufNewFile,BufRead *.tem set filetype=cpp

" Html Options
au FileType html,css,javascript setl sw=2 sts=2 et
au BufRead,BufNewFile *.md,gitcommit,*.txt setlocal spell
au BufWritePre,BufRead *.html :normal gg=G
:iabbrev </ </<C-X><C-O>
" Open in chrome
function! Chrome()
    !clear; exec chrome % &>/dev/null &
endfunction
au BufEnter *.md,*.markdown,*.html map <leader>p :call Chrome()<CR>

" Program Options
function! Vterm(filetype, call)
    execute 'au FileType '.a:filetype.' map <buffer><silent> <leader>p :vsp \| term '.a:call.'<CR>'
    execute 'au FileType '.a:filetype.' map <buffer><silent> <leader>P :sp \| term '.a:call.'<CR>'
endfunction

call Vterm("sh", "sh %")
call Vterm("python", "python %")
call Vterm("javascript", "node %")
call Vterm("haskell", "runhaskell -Wall -fno-warn-unused-binds %")
call Vterm("cpp", "g++ % -Wall -Werror -std=c++14; ./a.out ")
call Vterm("arduino", "processing-java --sketch=`pwd` --present")

" No more arrow keys
map <Up>    <NOP>
map <Down>  <NOP>
map <Left>  <<
map <Right> >>

" Fix resize bug
au VimResized * :silent! mode<CR>
au BufEnter * :silent! mode<CR>
