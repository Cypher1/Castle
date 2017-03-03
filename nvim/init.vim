" Plugins
call plug#begin('~/.config/nvim/plugged') " Plugins go here
Plug 'altercation/vim-colors-solarized' " Colours!
Plug 'bling/vim-airline'                " Airline gui
Plug 'vim-airline/vim-airline-themes'   " Airline themes
Plug 'tpope/vim-fugitive'               " Git in Vim
Plug 'mhinz/vim-signify'                " Sign column diffs
Plug 'rbgrouleff/bclose.vim'            " Close properly
Plug 'tmhedberg/matchit'                " % Match based jumping
Plug 'neomake/neomake'                  " Syntax and Compiler and Linter
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Completion
Plug 'rhysd/vim-clang-format'           " Formatting for Code
Plug 'jlfwong/vim-arcanist'             " Arc integration
Plug 'eagletmt/neco-ghc'                " Haskell Completion
Plug 'bitc/vim-hdevtools'               " Haskell Types
Plug 'neovimhaskell/haskell-vim'        " Haskell Syntax
Plug 'itchyny/vim-haskell-indent'       " Haskell Indent
Plug 'mxw/vim-xhp'                      " Xhp indent and syntax
Plug 'adimit/prolog.vim'                " Prolog
Plug 'hhvm/vim-hack'                    " Hack type checking
Plug 'roxma/vim-window-resize-easy'     " Resize windows
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
set mouse=ncr
set ttimeoutlen=50 " fast key codes
set clipboard+=unnamedplus
set backspace=indent,eol,start
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = "/usr/local/Cellar/llvm37/3.7.1/lib/llvm-3.7/lib/libclang.dylib"
set sessionoptions-=options
let g:session_command_aliases = 1
set foldmethod=manual foldlevel=0

" Tab (Indent and Completion)
set tabstop=2 softtabstop=2 shiftwidth=2
set smarttab shiftround expandtab autoindent copyindent
set wildmenu wildignorecase wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.hi,*.gch
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
nnoremap <leader>i :%s/  *$//c<CR>gg=G<CR>

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

" File Writes
set backup writebackup backupdir=/tmp/ hidden
cmap w!! w !sudo tee % >/dev/null

" NeoMake
let g:neomake_rust_enabled_makers = ['cargo']
let g:neomake_haskell_enabled_makers = ['ghcmod', 'hlint']
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_maker = {'exe': 'clang++',
            \ 'args': ["-std=c++14", '-Wall', '-Wextra'] }
let g:neomake_python_enabled_makers = ['pylint', 'flake']
let g:neomake_markdown_enabled_makers = ['mdl']
let g:neomake_markdown_mdl_args = ["-r", "~MD007", "~MD013"]
let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_javascript_eslint_maker = {
    \ 'exe': split(system('npm bin'), '\n')[0].'/eslint',
    \ 'args': ['-f', 'compact'],
    \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
    \ '%W%f: line %l\, col %c\, Warning - %m'
    \ }

nnoremap ¬ :lopen<CR>
"<A-L>
nnoremap ˙ :lclose<CR>
"<A-H>

augroup vim
  autocmd!
  au BufWritePost $MYVIMRC source $MYVIMRC
  au BufWritePre * :mkview
  au BufRead * :try|loadview|catch|endtry
  au BufWritePre * :silent! Neomake " Includes auto tidy for html etc
augroup END

" Splits
set splitbelow splitright
nmap <silent> <leader>h :wincmd h<CR>
nmap <silent> <leader>j :wincmd j<CR>
nmap <silent> <leader>k :wincmd k<CR>
nmap <silent> <leader>l :wincmd l<CR>

" Run as Program
function! Chrome()
    !clear; exec chrome % &>/dev/null &
endfunction
function! Vterm(...)
    execute 'vsp | term '.join(a:000, ' ')
endfunction
function! Term(...)
    execute 'sp | term '.join(a:000, ' ')
endfunction

nmap <leader>p <NOP>
" function! Repl(filetype, call)
"   execute 'au FileType '.a:filetype.' nmap <buffer><silent> <leader>p :Vterm '.a:call.'<CR>'
"   execute 'au FileType '.a:filetype.' nmap <buffer><silent> <leader>P :Term '.a:call.'<CR>'
" endfunction

function! Repl(call)
  nmap <buffer><silent> <leader>p :execute 'Vterm '.a:call
  nmap <buffer><silent> <leader>P :execute 'Term '.a:call
endfunction

if exists(':tnoremap')
    tnoremap <C-e> <C-\><C-n>
endif

" Haskell
let g:haskell_indent_disable=0
nmap <leader>t :HdevtoolsType<CR>
nmap <leader>T :HdevtoolsClear<CR>

augroup Cpp
  autocmd!
  au BufNewFile,BufRead *.tem set filetype=cpp
  au FileType c,cpp,javascript,java nnoremap <leader>i :ClangFormat<CR>
augroup END

augroup Html
  autocmd!
  au FileType html,css,javascript setl sw=2 sts=2 et
  au BufRead,BufNewFile *.md,gitcommit,*.txt setlocal spell
  au BufEnter *.md,*.markdown,*.html nmap <leader>p :call Chrome()<CR>
  au FileType html iabbrev </ </<C-X><C-O>
augroup END

" Git
nnoremap <leader>g :Gstatus<CR><CR>
nnoremap <leader>c :Gcommit<CR>
nnoremap <leader>b :Gblame<CR>
nnoremap <leader>v :Gmove

" Control buffers/tabs
nmap <leader>\ :vsp<space>
nmap <leader>- :sp<space>
nmap <leader>e :e<space>
nmap <leader>n :bn<CR>
nmap <leader>m :bp<CR>
nmap <leader>q :Bclose<CR>
nmap <leader>w :w<CR>

" Repls
command! -nargs=* Chrome call Chrome(<f-args>)
command! -nargs=* Vterm call Vterm(<f-args>)
command! -nargs=* Term call Term(<f-args>)

augroup Repls
  autocmd!
  au Filetype sh         call Repl("bash %")
  au Filetype zsh        call Repl("zsh %")
  au Filetype python     call Repl("python %")
  au Filetype javascript call Repl("node %")
  au Filetype haskell    call Repl("runhaskell -Wall -fno-warn-unused-binds %")
  au Filetype cpp        call Repl("g++ % -Wall -Werror -std=c++14; ./a.out")
  au Filetype arduino    call Repl("processing-java --sketch=`pwd` --present")
  au Filetype prolog     call Repl("swipl -s %")
augroup END
let g:filetype_pl="prolog"

" No more arrow keys
map <Up>    <NOP>
map <Down>  <NOP>
map <Left>  <<
map <Right> >>

" Local settings
silent! source local.vim
