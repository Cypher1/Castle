set nocompatible " required
filetype plugin indent on " required
" Plugin {{{
call plug#begin('~/.local/share/nvim/plugged') " Plugins go here

Plug 'sjl/badwolf'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Tweaks & Fixes
Plug 'ConradIrwin/vim-bracketed-paste'  " Paste properly
Plug 'tpope/vim-repeat'                 " Repetitions
Plug 'roxma/vim-window-resize-easy'     " Resize windows
Plug 'tmhedberg/matchit'                " % Match based jumping
Plug 'tpope/vim-eunuch'                 " Unix built in
" Tools
Plug 'AndrewRadev/switch.vim'           " Switch t->f
Plug 'mhinz/vim-signify'                " Sign column diffs
Plug 'rhysd/vim-clang-format'           " Autoformat
Plug 'ap/vim-css-color'                 " Show Colors in CSS
Plug 'google/vim-searchindex'           " Count search solutions
Plug 'simnalamburt/vim-mundo'           " UNDO!
Plug 'tpope/vim-fugitive'               " Git!
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Async completion

" Format / Language Specifics
Plug 'sheerun/vim-polyglot'             " Lots of languages
Plug 'chrisbra/csv.vim'                 " CSV
Plug 'lepture/vim-jinja'                " Jinja
Plug 'rust-lang/rust.vim'               " Rust
Plug 'idris-hackers/idris-vim'          " Idris
Plug 'dag/vim2hs'                       " Haskell suppordag/vim2hst
call plug#end()

" }}}
" Colour Scheme {{{
syntax enable
set background=dark
colorscheme badwolf
let g:badwolf_tabline = 0
highlight Comment ctermfg=DarkMagenta

let g:filetype_pl="prolog"
let $COLORTERM = "gnome-terminal"
set colorcolumn=80
highlight OverLength ctermbg=red guibg=#592929
match OverLength /\%81v.\+/
" }}}
" Status Information {{{
set cursorline ruler relativenumber number laststatus=2
set list listchars=tab:>.,trail:.,extends:#,nbsp:.
" }}}
" Input settings {{{
let mapleader=' '
set mouse=ncr
set ttimeoutlen=50 " fast key codes
set backspace=indent,eol,start
set clipboard+=unnamedplus
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = "/usr/local/Cellar/llvm37/3.7.1/lib/llvm-3.7/lib/libclang.dylib"
set sessionoptions-=options
set foldmethod=manual foldlevel=20
set visualbell noerrorbells novisualbell t_vb=
set ignorecase smartcase gdefault magic inccommand=split
nnoremap <silent> : :nohlsearch<CR>:
tnoremap : <C-\><C-n>:
tnoremap :: :
set backup writebackup backupdir=/tmp/ hidden
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
set undofile undodir=~/.config/nvim/undo-dir
" No more arrow keys {{{
map <Up>    <NOP>
map <Down>  <NOP>
map <Left>  <<
map <Right> >>
" }}}
" }}}
" Fix up indent issues {{{
set cino=N-s
" }}}
" Home made functions {{{
" convert rows to a tuple
function! ToTupleFunction() range
    silent execute a:firstline . "," . a:lastline . "s/^/'/"
    silent execute a:firstline . "," . a:lastline . "s/$/',/"
    silent execute a:firstline . "," . a:lastline . "join"
    silent execute "normal I("
    silent execute "normal $xa)"
    silent execute "normal ggVGYY"
endfunction
command! -range ToTuple <line1>,<line2> call ToTupleFunction()

function! ToUnixFunction()
    execute "e ++ff=dos"
    execute "set ff=unix"
endfunction
command! -range ToUnix <line1>,<line2> call ToUnixFunction()

" Send code to bash and back
command! -nargs=1 FW call FilterToNewWindow(<f-args>)

function! FilterToNewWindow(script)
    let TempFile = tempname()
    let SaveModified = &modified
    exe 'w ' . TempFile
    let &modified = SaveModified
    exe 'split ' . TempFile
    exe '%! ' . a:script
endfunction
" }}}
" Buffers/Tabs/Splits {{{
set splitbelow splitright
nmap <leader>v :vsp<space>
nmap <leader>t :vsp<CR>:term<CR>
nmap <leader>s :sp<space>

nmap <leader>n :bn<CR>
nmap <leader>m :bp<CR>
nmap <leader>q :bp <BAR> bd #<CR>
nmap <leader>u :MundoToggle<CR>
" }}}
" FZF {{{

let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nmap <C-O> <ESC>:GFiles<CR>
nmap <C-F> <ESC>:GGrep<CR>
nmap <C-G> <ESC>:Buffers<CR>

" }}}
" Tab (Indent and Completion) {{{
set tabstop=2 softtabstop=2 shiftwidth=2
set smarttab shiftround expandtab autoindent copyindent
set wildmenu wildignorecase wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.hi,*.gch
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"
nnoremap <leader>i :%s/  *$//c<CR>gg=G<CR>
" }}}
" Movement {{{
nmap j gj
nmap k gk
"Shove down: <A-j>
nnoremap ∆ :m.+1<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
nnoremap <A-j> :m .+1<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
"Show up: <A-k>
nnoremap ˚ :m .-2<CR>==
inoremap ˚ <Esc>:m .-2<CR>==gi
nnoremap <A-k> :m .-2<CR>==
inoremap <A-k> <Esc>:m .-2<CR>==gi
nnoremap <leader>! :Switch<CR>

let g:switch_custom_definitions =
    \ [
    \   ['foo', 'bar', 'baz'],
    \   ['0', '1'],
    \   ['<', '>', '<=', '>=', '!=', '/='],
    \   ['TRUE', 'FALSE'],
    \   ['T', 'F'],
    \   ['.cc', '.h'],
    \   ['{', '}'],
    \   ['[', ']'],
    \   ['(', ')'],
    \   ['||', '&&'],
    \   ['and', 'or'],
    \   ['x', 'y', 'z', 'i', 'j', 'k', 'u', 'v']
    \ ]
set nostartofline
" }}}
" My Repls {{{
let g:rappel#launch="chromium \"%\""
" }}}
" NeoMake {{{
let g:rustfmt_autosave = 1

let g:neomake_verbose = 3
let g:neomake_haskell_hlint_exe = '/Users/cypher/.local/bin/hlint'

let g:neomake_rust_enabled_makers = ['cargo']
let g:neomake_haskell_enabled_makers = ['hlint', 'ghcmod']
let g:neomake_cpp_enabled_makers = ['gcc', 'cppcheck']
let g:neomake_cpp_gcc_args = ["-std=c++14", "-Wextra", "-Wall", "-fsanitize=undefined","-g"]
let g:neomake_cpp_clang_maker = {'exe': 'clang++',
            \ 'args': ["-std=c++14", '-Wall', '-Wextra'] }
let g:neomake_python_enabled_makers = ['pylint']
let g:neomake_markdown_enabled_makers = ['mdl']
let g:neomake_markdown_mdl_args = ["-r", "~MD007", "~MD013"]
let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_javascript_eslint_maker = {
    \ 'exe': split(system('npm bin'), '\n')[0].'/eslint',
    \ 'args': ['-f', 'compact'],
    \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
    \ '%W%f: line %l\, col %c\, Warning - %m'
    \ }

let g:neomake_open_list = 2
" }}}
" Autocommands {{{
augroup vim
  autocmd!
  au BufRead,BufNewFile *.md,gitcommit,*.txt setlocal spell
  au Filetype qf set nobuflisted
  au BufWritePost $MYVIMRC source $MYVIMRC
  au Filetype html iabbrev </ </<C-X><C-O>
  au Filetype markdown match OverLength //
  au BufEnter,BufRead *.swift set filetype=swift
  au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja
  au TabNewEntered,TermOpen term://* startinsert
  au BufEnter *.hs compiler ghc
augroup END
" }}}
