" Plugin {{{
call plug#begin('~/.config/nvim/plugged') " Plugins go here
Plug 'altercation/vim-colors-solarized' " Colours!
Plug 'bling/vim-airline'                " Airline gui
Plug 'vim-airline/vim-airline-themes'   " Airline themes
Plug 'neomake/neomake'                  " Syntax and Compiler and Linter
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Completion
Plug 'mhinz/vim-signify'                " Sign column diffs
Plug 'rbgrouleff/bclose.vim'            " Close properly
Plug 'tpope/vim-eunuch'                 " Unix built in
Plug 'ConradIrwin/vim-bracketed-paste'  " Paste properly
Plug 'sheerun/vim-polyglot'             " Lots of languages
Plug 'bitc/vim-hdevtools'               " Haskell Types
Plug 'tmhedberg/matchit'                " % Match based jumping
Plug 'alvan/vim-closetag'               " Lazy html
Plug 'roxma/vim-window-resize-easy'     " Resize windows
call plug#end()

" }}}
" Colour Scheme {{{
syntax enable
set background=dark
colorscheme solarized
highlight Comment ctermfg=DarkMagenta
highlight SignColumn ctermbg=black
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
" }}}
" Status Information {{{
set cursorline ruler relativenumber number laststatus=4
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod = ':t'
set list listchars=tab:>.,trail:.,extends:#,nbsp:.
" }}}
" Input settings {{{
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
set noerrorbells novisualbell t_vb=
set smartcase gdefault magic
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>
" File Writes {{{
set backup writebackup backupdir=/tmp/ hidden
cmap w!! w !sudo tee % >/dev/null
" }}}
" No more arrow keys {{{
map <Up>    <NOP>
map <Down>  <NOP>
map <Left>  <<
map <Right> >>
" }}}
" }}}
" Splits {{{
set splitbelow splitright
nmap <silent> <leader>h :wincmd h<CR>
nmap <silent> <leader>j :wincmd j<CR>
nmap <silent> <leader>k :wincmd k<CR>
nmap <silent> <leader>l :wincmd l<CR>
" }}}
" Control buffers/tabs {{{
nmap <leader>\ :vsp<space>
nmap <leader>- :sp<space>
nmap <leader>n :bn<CR>
nmap <leader>m :bp<CR>
nmap <leader>q :Bclose<CR>
nmap <leader>e :e<space>
nmap <leader>w :w<CR>
" }}}
" Tab (Indent and Completion) {{{
set tabstop=2 softtabstop=2 shiftwidth=2
set smarttab shiftround expandtab autoindent copyindent
set wildmenu wildignorecase wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.hi,*.gch
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
nnoremap <leader>i :%s/  *$//c<CR>gg=G<CR>
" }}}
" Movement {{{
nmap j gj
nmap k gk
"<A-j>
nnoremap ∆ :m .+1<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
"<A-k>
nnoremap ˚ :m .-2<CR>==
inoremap ˚ <Esc>:m .-2<CR>==gi
set nostartofline
" }}}
" NeoMake {{{
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
" }}}
" Run as Program {{{
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
tnoremap <C-e> <C-\><C-n>
function! Repl(call)
  execute 'nmap <buffer><silent> <leader>p : call Vterm("'.a:call.'")<CR>'
  execute 'nmap <buffer><silent> <leader>P : call Term("'.a:call.'")<CR>'
endfunction
function! ReplComp(comp, run)
  call Repl('echo \"Compiling...\"; '.a:comp.'; echo \"Running...\"; '.a:run)
endfunction
command! -nargs=* Chrome call Chrome(<f-args>)
command! -nargs=* Vterm call Vterm(<f-args>)
command! -nargs=* Term call Term(<f-args>)
" }}}
" Autocommands {{{
augroup vim
  autocmd!
  au BufWritePost $MYVIMRC source $MYVIMRC|set fdm=marker
  au BufWritePre * :silent! Neomake " Includes auto tidy for html etc
  set viewoptions-=options
  au FileType c,cpp,javascript,java nnoremap <leader>i :ClangFormat<CR>
  au BufRead,BufNewFile *.md,gitcommit,*.txt setlocal spell
  au Filetype markdown,html nmap <buffer> <leader>p :call Chrome()<CR>
  au FileType html iabbrev </ </<C-X><C-O>
  au Filetype markdown match OverLength //
  au CursorMoved * if mode() !~# "[vV\<C-v>]" | set nornu nu | endif
augroup END
" }}}
" Repls {{{
augroup Repls
  autocmd!
  au Filetype sh         call Repl("bash %")
  au Filetype zsh        call Repl("zsh %")
  au Filetype python     call Repl("python %")
  au Filetype javascript call Repl("node %")
  au Filetype haskell    call ReplComp("ghc % -Wall", "./`sed 's/\.[^\.]*$//' <<< '%'`")
  au Filetype cpp        call ReplComp("g++ % -Wall -std=c++14", "./a.out")
  au Filetype arduino    call Repl("processing-java --sketch=`pwd` --present")
  au Filetype prolog     call Repl("swipl -s %")
augroup END
let g:filetype_pl="prolog"
" }}}
" Haskell {{{
let g:haskell_indent_disable=0
nmap <leader>t :HdevtoolsType<CR>
nmap <leader>T :HdevtoolsClear<CR>
" }}}
silent! source local.vim
