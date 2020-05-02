set nocompatible " Disable vi compatibility mode
set langmenu=en_US.UTF-8
let $LANG='en'
if !has("nvim")
  set encoding=utf8
endif

if has("win32") || has("win16")
  let bundle="~/vimfiles/bundle"
else
  let bundle="~/.vim/bundle"
endif

if !isdirectory(expand(bundle . "/vundle"))
  call system("mkdir -p " . expand(bundle))
  call system("git clone https://github.com/gmarik/vundle.git " . expand(bundle) . "/vundle")
endif

filetype off
let g:syntastic_check_on_open=1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let &rtp .= ',' . expand(bundle . "/vundle")

call vundle#begin(expand(bundle))
  Plugin 'gmarik/vundle'
  Plugin 'bling/vim-airline'
  Plugin 'scrooloose/syntastic'
  Plugin 'tpope/vim-fugitive'
  Plugin 'airblade/vim-gitgutter'
  Plugin 'Raimondi/delimitMate' " Better support for parens
  Plugin 'kien/ctrlp.vim' " Fuzzy searching à sublime text

  " Language support
  "Plugin 'rust-lang/rust.vim'

  " Colorschemes
  Plugin 'morhetz/gruvbox'
call vundle#end()

filetype plugin indent on   " detect file type and load indents and plugins
syntax on                   " turn on syntax highlighting

" Automatically install bundles on first run
if !isdirectory(expand(bundle . "/vim-airline"))
  execute 'silent PluginInstall'
  execute 'silent q'
endif

" Show arrow for tabs
set list
set listchars=tab:·\ ,trail:·,extends:»,precedes:«,nbsp:×
highlight SpecialKey ctermfg=2 ctermbg=NONE
highlight NonText ctermfg=2 ctermbg=NONE

set background=dark
colorscheme gruvbox

if has('gui_running')
  set guioptions-=T  " no toolbar
  set guioptions-=m  " no menu bar
  set guioptions-=r  " no right-hand scroll bar
  set guioptions-=L  " no left-hand scroll bar
  if has('gui_win32')
    set guifont=Inconsolata-g_for_Powerline:h11
  else
    set guifont=Inconsolata-g\ for\ Powerline\ 12
  endif
endif

if has("termguicolors")
  set termguicolors
endif


let mapleader = ","
let g:mapleader = ","
" w!! for changing the file to sudo in case it wasn't opened as su
cmap w!! w !sudo tee % >/dev/null

set modeline
set modelines=1
set laststatus=2
set clipboard=unnamed " share yank with OS clipboard
set nowrap        " don't wrap lines
set expandtab
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                    " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set relativenumber
set shiftwidth=2  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                    "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                    "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set novisualbell         " don't visually blink
set noerrorbells         " don't beep

set scrolloff=8 " j/k will start scrolling when 8 lines from edge
set wildmenu " shows commandline tab completion
set wildmode=longest:full,full
set showcmd " shows normal mode commands in the commandline
set matchtime=2 " time the matching bracket is highlighted for
set hidden
set ttyfast " sends characters more often to improve redraw rate
set lazyredraw " delays redraws to improve performance (?)

" absolute numbers in insert, relative otherwise
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
" also when focus lost/gained
autocmd FocusLost * :set norelativenumber
autocmd FocusGained * :set relativenumber

" Turn off backups and swaps
set nobackup
set nowb
set noswapfile

" Treat long lines as break lines (useful for moving around in them)
map j gj
map k gk

" use space to search
map <Space> /

" Use tab in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv
" shift tab dedents in insert
imap <S-Tab> <C-d>

command! ClearHighlight let @/ = ""

nnoremap <Leader>s :update<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>c :ClearHighlight<CR>

autocmd InsertEnter * set timeoutlen=0
autocmd InsertLeave * set timeoutlen=1000
inoremap jj <Esc>

" Ctrl+j/k/h/l to move between splits
map<C-j> <C-w>j
map<C-k> <C-w>k
map<C-h> <C-w>h
map<C-l> <C-w>l
