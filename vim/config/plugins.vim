call plug#begin()

" lua libraries
Plug 'nvim-lua/plenary.nvim'

" Add OneDark theme to neovim
Plug 'joshdick/onedark.vim'

" Syntax Plugins
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'bfrg/vim-cpp-modern'
Plug 'vim-python/python-syntax'

" Add Icons to neovim
Plug 'ryanoasis/vim-devicons'

" Git Integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Better Vim status line
Plug 'nvim-lualine/lualine.nvim'

" Arduino support
Plug 'stevearc/vim-arduino'
Plug 'sudar/vim-arduino-syntax'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim'

" Emmet, the best html plugin
Plug 'mattn/emmet-vim'

" Save files as superuser
Plug 'lambdalisue/suda.vim'

" Auto close tags
Plug 'alvan/vim-closetag'

" Highlight hex colors
Plug 'chrisbra/Colorizer'

" Discord rich presence
Plug 'vimsence/vimsence'

call plug#end()


"" Plugin Configuration

" Python syntax highlighting
let g:python_highlight_all = 1

" netrw config
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_altv = 1
let g:netrw_winsize = 18

" Lualine
lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
END

" Set the arduino directory
let g:arduino_dir = '/home/ayman/Arduino'
let g:arduino_use_cli  = 1
let g:arduino_board = 'arduino:avr:uno'
