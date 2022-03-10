" Use 256 colors
set t_Co=256

" line numbers
set nu

" Set the colorscheme
colorscheme onedark

" Enable filetype plugins
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Save actions to an undo directory
set undofile
set undolevels=1000
set undodir=$HOME/.vim/undodir/

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Don't wrap lines
set nowrap

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show command keys pressed
set showcmd

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Set timeout for key combos (ms)
set timeoutlen=1000
set ttimeoutlen=100

" Update time
set updatetime=150

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

" Set utf8 as standard encoding
set encoding=utf8

" Turn backup off, since most stuff is in SVN, git etc.
set nobackup
set nowb
set noswapfile

" Prevents automatic write backup
set nowritebackup

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" Linebreak on 500 characters
set lbr
set tw=500

" Auto and smart indenting
set ai
set si

" Diable vi compatiblity
set nocompatible

" Enable Mouse Support
set mouse=a

" Use system clipboard
set clipboard=unnamedplus

" Highlight line cursor is on
set cursorline

" Speed up scrolling
set ttyfast

" Ignore casing when searching
set ignorecase

" Don't show the default vim mode on th bottom
set noshowmode

" Set the termguicolors on if terminal supports it
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
