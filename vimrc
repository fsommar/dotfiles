" FIXME: Save swap files and/or history in a dedicated folder?
set nocompatible " Apparently needed for cool vim things?
set langmenu=en_US.UTF-8
let $LANG='en'
set encoding=utf8

if has("win32") || has("win16")
	let bundle="~/vimfiles/bundle"
else
	let bundle="~/.vim/bundle"
endif

if !isdirectory(expand(bundle . "/vundle"))
	call system("git clone https://github.com/gmarik/vundle.git " . expand(bundle) . "/vundle")
endif

filetype off
let g:syntastic_check_on_open=1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1

let &rtp .= ',' . expand(bundle . "/vundle")
call vundle#begin(expand(bundle))
Plugin 'gmarik/vundle'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
" Plugin 'zeis/vim-kolor'
" Plugin 'nanotech/jellybeans.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'morhetz/gruvbox'
Plugin 'wting/rust.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Raimondi/delimitMate'
" Plugin 'jelera/vim-javascript-syntax'
" Plugin 'othree/javascript-libraries-syntax.vim'
" Plugin 'pangloss/vim-javascript'
Plugin 'w0ng/vim-hybrid'
Plugin 'derekwyatt/vim-scala'
Plugin 'kien/ctrlp.vim'
if v:version > 703
	Plugin 'Valloric/YouCompleteMe'
endif
call vundle#end()
filetype plugin indent on   " detect file type and load indents and plugins
syntax on                   " turn on syntax highlighting

" Automatically install bundles on first run
if !isdirectory(expand(bundle . "/vim-airline"))
	execute 'silent PluginInstall'
	execute 'silent q'
endif

if has('gui_running')
	set guioptions-=T  " no toolbar
	set guioptions-=m  " no menu bar
	set guioptions-=r  " no right-hand scroll bar
	set guioptions-=L  " no left-hand scroll bar
	colorscheme gruvbox
	if has('gui_win32')
		set guifont=Inconsolata-g_for_Powerline:h11
	else
		set guifont=Inconsolata-g\ for\ Powerline\ 12
	endif
elseif &term =~ "putty"
	set background=dark
	colorscheme solarized
else
	let g:hybrid_use_Xresources = 1
	colorscheme hybrid
endif

if has("terminfo")
  let &t_Co=16
  let &t_AB="\<Esc>[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm"
  let &t_AF="\<Esc>[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm"
else
  let &t_Co=16
  let &t_Sf="\<Esc>[3%dm"
  let &t_Sb="\<Esc>[4%dm"
endif

autocmd filetype python set expandtab

let mapleader = ","
let g:mapleader = ","
" w!! for changing the file to sudo in case it wasn't opened as su
cmap w!! w !sudo tee % >/dev/null

set modeline
set modelines=1
set laststatus=2
set clipboard=unnamed " share yank with OS clipboard
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                    " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set relativenumber
set shiftwidth=4  " number of spaces to use for autoindenting
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

" highlight CursorLine cterm=NONE ctermbg=black

" Show arrow for tabs
set list
set listchars=tab:·\ ,trail:·,extends:»,precedes:«,nbsp:×
highlight SpecialKey ctermfg=2 ctermbg=NONE
highlight NonText ctermfg=2 ctermbg=NONE

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
" Tab at the beginning of a line jumps to the correct indentation
function! JumpToIndent()
	if cindent('.') > 0 && col('.') == 1 && empty(getline('.'))
		return "\<Esc>cc"
	else
		return "\<Tab>"
	endif
endfunction
inoremap <silent> <Tab> <C-R>=JumpToIndent()<CR>

" Clears the search highlighting
" by doing :C
command! ClearHighlight let @/ = ""
command! KattisUpload echom system("python submit.py " . bufname("%") . " -f -p oldkattis:adkcasting")
nnoremap <Leader>k :update<CR>:KattisUpload<CR>

function! DeleteIndent()
	" Make sure there's no text on the right and that everything to the left
	" is whitespace
	if indent('.') > 0 && line('.') != prevnonblank('.')
		left
		return ""
	else
		return "\<BS>"
	endif
endfunction
inoremap <silent> <BS> <C-R>=DeleteIndent()<CR>

nnoremap <Leader>s :update<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>c :ClearHighlight<CR>

inoremap jj <Esc>

" Ctrl+j/k/h/l to move between splits
map<C-j> <C-w>j
map<C-k> <C-w>k
map<C-h> <C-w>h
map<C-l> <C-w>l

" Alt+j/k to move lines
" disable esc sequences to make this less of a nuisance?
" nnoremap j :m+<CR>==
" nnoremap k :m-2<CR>==
" inoremap j <Esc>:m+<CR>==gi
" inoremap k <Esc>:m-2<CR>==gi
" vnoremap j :m'>+<CR>gv=gv
" vnoremap k :m'<-2<CR>gv=gv
autocmd Filetype java set makeprg=javac\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
map <F9> :make<Return>:copen<Return>
map <F10> :cprevious<Return>
map <F11> :cnext<Return>
