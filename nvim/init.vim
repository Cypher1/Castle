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
Plug 'rhysd/vim-clang-format'           " Formatting for Code
Plug 'jlfwong/vim-arcanist'             " Arc integration
Plug 'eagletmt/neco-ghc'                " Haskell Completion
Plug 'bitc/vim-hdevtools'               " Haskell Types
Plug 'neovimhaskell/haskell-vim'        " Haskell Syntax
Plug 'itchyny/vim-haskell-indent'       " Haskell Indent
Plug 'mxw/vim-xhp'                      " Xhp indent and syntax
Plug 'hhvm/vim-hack'                    " Hack type checking
call plug#end()

" Colour Scheme
syntax enable
set background=dark
colorscheme solarized
highlight Comment ctermfg=DarkMagenta
highlight SignColumn ctermbg=black

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Status Information
set cursorline ruler relativenumber number laststatus=4
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
nmap j gj
nmap k gk
"<A-j>
nnoremap ∆ :m .+1<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
"<A-k>
nnoremap ˚ :m .-2<CR>==
inoremap ˚ <Esc>:m .-2<CR>==gi
nnoremap Q q
set nostartofline

" Key mappings
nmap <leader>r :mode<CR>
nnoremap <leader>i :%s/  *$//c<CR>gg=G<CR>
au FileType c,cpp,javascript,java nnoremap <leader>i :ClangFormat<CR>
if exists(':tnoremap')
    tnoremap <C-e> <C-\><C-n>
endif
nmap <leader>s :so ~/.config/nvim/init.vim<CR>:PlugClean<CR>:PlugInstall<CR>
" Haskell
let g:haskell_indent_disable=0
nmap <leader>t :HdevtoolsType<CR>
nmap <leader>T :HdevtoolsClear<CR>
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
nmap <leader>\ :vsp<space>
nmap <leader>- :sp<space>
nmap <leader>e :e<space>
nmap <leader>n :bn<CR>
nmap <leader>m :bp<CR>
nmap <leader>q :Bclose<CR>
nmap <leader>w :w<CR>

" Splits
set splitbelow splitright
nmap <silent> <leader>h :wincmd h<CR>
nmap <silent> <leader>j :wincmd j<CR>
nmap <silent> <leader>k :wincmd k<CR>
nmap <silent> <leader>l :wincmd l<CR>

" NeoMake
let g:neomake_rust_enabled_makers = ['cargo']
let g:neomake_haskell_enabled_makers = ['ghcmod', 'hlint']
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_maker = {
            \ 'exe': 'clang++',
            \ 'args': ["-std=c++14", '-Wall', '-Wextra'],
            \ }
let g:neomake_python_enabled_makers = ['pylint', 'flake']
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
nnoremap Q <nop>
nnoremap qq <nop>
nnoremap v <nop>
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

" Program Options
function! Chrome()
    !clear; exec chrome % &>/dev/null &
endfunction
au BufEnter *.md,*.markdown,*.html nmap <leader>p :call Chrome()<CR>

function! Vterm(...)
    execute 'vsp | term '.join(a:000, ' ')
endfunction

function! Term(...)
    execute 'sp | term '.join(a:000, ' ')
endfunction

command! -nargs=* Chrome call Chrome(<f-args>)
command! -nargs=* Vterm call Vterm(<f-args>)
command! -nargs=* Term call Term(<f-args>)

function! Repl(filetype, call)
    " echo "Setting up " a:filetype " -> " a:call
    execute 'au FileType '.a:filetype.' map <buffer><silent> <leader>p :Vterm '.a:call.'<CR>'
    execute 'au FileType '.a:filetype.' map <buffer><silent> <leader>P :Term '.a:call.'<CR>'
endfunction

call Repl("sh", "bash %")
call Repl("zsh", "zsh %")
call Repl("python", "python %")
call Repl("javascript", "node %")
call Repl("haskell", "runhaskell -Wall -fno-warn-unused-binds %")
call Repl("cpp", "g++ % -Wall -Werror -std=c++14; ./a.out")
call Repl("arduino", "processing-java --sketch=`pwd` --present")

" No more arrow keys
map <Up>    <NOP>
map <Down>  <NOP>
map <Left>  <<
map <Right> >>

" Fix resize bug
au VimResized * :silent! mode<CR>
au BufEnter * :silent! mode<CR>

" Local settings
silent! source local.vim
