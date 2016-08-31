" FIXME: Save swap files and/or history in a dedicated folder?
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
	call system("git clone https://github.com/gmarik/vundle.git " . expand(bundle) . "/vundle")
endif

filetype off
let g:syntastic_check_on_open=1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:racer_cmd = expand(bundle . "/racer/target/racer")

let &rtp .= ',' . expand(bundle . "/vundle")
call vundle#begin(expand(bundle))
Plugin 'gmarik/vundle'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'Raimondi/delimitMate' " Better support for parens
Plugin 'kien/ctrlp.vim' " Fuzzy searching à sublime text
"
" Language support
"Plugin 'derekwyatt/vim-scala'
"Plugin 'phildawes/racer' " Rust autocompletion
"Plugin 'rust-lang/rust.vim'

" Colorschemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'w0ng/vim-hybrid'
if has("nvim")
	Plugin 'morhetz/gruvbox'
endif

" YouCompleteMe is only available for Vim 7.3+
if v:version > 703
	"Plugin 'Valloric/YouCompleteMe'
endif
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
elseif has("nvim")
	colorscheme gruvbox
elseif &term =~ "putty" || &term =~ "256color"
	colorscheme solarized
else
	let g:hybrid_use_Xresources = 1
	colorscheme hybrid
endif

if !has("nvim") && !has("gui_running")
	if has("terminfo")
		let &t_Co=256
		let &t_AB="\<Esc>[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm"
		let &t_AF="\<Esc>[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm"
	else
		let &t_Co=16
		let &t_Sf="\<Esc>[3%dm"
		let &t_Sb="\<Esc>[4%dm"
	endif
endif

autocmd filetype python setlocal expandtab

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

autocmd InsertEnter * set timeoutlen=0
autocmd InsertLeave * set timeoutlen=1000
inoremap jj <Esc>

" Ctrl+j/k/h/l to move between splits
map<C-j> <C-w>j
map<C-k> <C-w>k
map<C-h> <C-w>h
map<C-l> <C-w>l
