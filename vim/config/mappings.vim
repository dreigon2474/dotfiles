" Set leader key to <space>
let mapleader = ' '

" Reload .vimrc
nnoremap <F12> :so ~/.config/nvim/init.vim<CR>

" Open fuzzyfinder
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Clears search
map <leader>c <cmd>let @/=''<cr>

" Fuck you, help key
nmap <F1> <nop>

" Enable hybrid line numbers
nnoremap <leader>n <cmd>set relativenumber!<Cr>

" Toggle color highlighting on
nnoremap <leader>t <cmd>ColorToggle<Cr>

" Quick saving
autocmd BufReadPost *
    \  if &readonly
    \|      nmap <leader>w :SudaWrite<cr>
    \| else
    \|      nmap <leader>w :w!<cr>
    \| endif

" No need for Ex mode
nnoremap Q <NOP>

" Resize windows
if bufwinnr(1)
	map + <cmd>resize +1<CR>
	map - <cmd>resize -1<CR>
	map < <cmd>vertical resize +1<CR>
	map > <cmd>vertical resize -1<CR>
endif

" Useful mappings for managing tabs
map <leader>tn <cmd>tabnew<cr>
map <leader>to <cmd>tabonly<cr>
map <leader>tc <cmd>tabclose<cr>
map <leader>tm <cmd>tabmove<cr>
map <leader>u <cmd>tabnext<cr>
map <leader>y <cmd>tabprevious<cr>

" Toggle netrw tree view
map <leader>b <cmd>Lexplore<cr>
