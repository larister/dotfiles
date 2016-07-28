set nocompatible
 
" Install plugins
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'kien/ctrlp.vim'
Plug 'isruslan/vim-es6'
Plug 'elzr/vim-json'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-airline/vim-airline'

call plug#end()

" Autoreload
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Set styling
set t_Co=256
syntax on
set background=dark
colorscheme distinguished

" Filetype plugins
filetype plugin on

" Setup highlighting
set hlsearch
set incsearch
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Line numbers
set number
set relativenumber

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

function! NumberToggle()
      if(&relativenumber == 1)
          set number
      else
          set relativenumber
      endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" Show statusline
set laststatus=2

" Setup linting
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Setup ctrlp"
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Remap keys
inoremap kj <Esc>
