" Plugin {{{
call plug#begin('~/.config/nvim/plugged') " Plugins go here
" Style
Plug 'altercation/vim-colors-solarized' " Colours!
Plug 'vim-airline/vim-airline'          " Airline gui
Plug 'vim-airline/vim-airline-themes'   " Airline themes
" Tweaks
Plug 'tpope/vim-eunuch'                 " Unix built in
Plug 'ConradIrwin/vim-bracketed-paste'  " Paste properly
Plug 'tmhedberg/matchit'                " % Match based jumping
Plug 'roxma/vim-window-resize-easy'     " Resize windows
" Tools
Plug 'kien/ctrlp.vim'                   " Fuzzy Finder
Plug 'sjl/gundo.vim'                    " UNDO!
Plug 'cypher1/nvim-rappel'              " Repls
Plug 'neomake/neomake'                  " Syntax and Compiler and Linter
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Completion
Plug 'mhinz/vim-signify'                " Sign column diffs
" Format / Language Specifics
Plug 'sheerun/vim-polyglot'             " Lots of languages
Plug 'lambdatoast/elm.vim'              " ELM
Plug 'chrisbra/csv.vim'                 " CSV
call plug#end()

" }}}
" Colour Scheme {{{
syntax enable
set background=dark
colorscheme solarized
highlight Comment ctermfg=DarkMagenta
highlight SignColumn ctermbg=8
highlight LineNr ctermbg=8
highlight LineNr ctermbg=8
highlight Folded ctermbg=8
highlight SignifySignAdd ctermbg=8
highlight SignifySignModify ctermbg=8
highlight SignifySignDelete ctermbg=8
highlight SignifySignChangeDelete ctermbg=8
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/
" }}}
" Status Information {{{
set cursorline ruler relativenumber number laststatus=2
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod = ':t'
set list listchars=tab:>.,trail:.,extends:#,nbsp:.
" }}}
" Input settings {{{
let mapleader=' '
set mouse=ncr
set ttimeoutlen=50 " fast key codes
set backspace=indent,eol,start
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = "/usr/local/Cellar/llvm37/3.7.1/lib/llvm-3.7/lib/libclang.dylib"
set sessionoptions-=options
set foldmethod=manual foldlevel=0
set visualbell noerrorbells novisualbell t_vb=
set ignorecase smartcase gdefault magic inccommand=split
nnoremap <silent> : :nohlsearch<CR>:
tnoremap <C-e> <C-\><C-n>:
set backup writebackup backupdir=/tmp/ hidden
set undofile undodir=~/.config/nvim/undo-dir
" No more arrow keys {{{
map <Up>    <NOP>
map <Down>  <NOP>
map <Left>  <<
map <Right> >>
" }}}
" Use F10 to display highlighting rules around the cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }}}
" Buffers/Tabs/Splits {{{
set splitbelow splitright
nmap <leader>v :vsp<space>
nmap <leader>s :sp<space>
nmap <silent> <leader>h :wincmd h<CR>
nmap <silent> <leader>j :wincmd j<CR>
nmap <silent> <leader>k :wincmd k<CR>
nmap <silent> <leader>l :wincmd l<CR>
nmap <leader>n :bn<CR>
nmap <leader>m :bp<CR>
nmap <leader>q :bp <BAR> bd #<CR>
nmap <leader>w :w<CR>
" }}}
" Control P {{{
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules|\_site)$',
  \ 'file': '\v(\.(exe|so|dll|class|png|jpg|jpeg|)$)|^[^\.]*$',
\}
let g:ctrlp_working_path_mode = 'r' "Use git root
let g:ctrlp_max_files = 0
nmap <leader>b :CtrlPMixed<cr>
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
" Autocommands {{{
augroup vim
  autocmd!
  au BufWritePost $MYVIMRC source $MYVIMRC|set fdm=marker
  au BufWritePre * :silent! Neomake " Includes auto tidy for html etc
  au BufRead,BufNewFile *.md,gitcommit,*.txt setlocal spell
  au FileType html iabbrev </ </<C-X><C-O>
  au Filetype markdown match OverLength //
  au BufEnter,BufRead *.swift set filetype=swift
augroup END
" }}}
" My Repls {{{
let g:filetype_pl="prolog"
let g:rappel#run_key    = '<leader>p'
let g:rappel#repl_key   = '<leader>P'
let g:rappel#launch_key = 'π'
let g:rappel#launch="chrome \"%\""

let g:rappel#custom_repls={
\ 'arduino': {
\   'launch': 'processing-java --sketch=`pwd` --present',
\   'run': 'processing-java --sketch=`pwd` --present'
\ },
\}
" }}}
