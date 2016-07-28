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
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'editorconfig/editorconfig-vim'

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

" Do not auto-add new lines
set noeol

" Do not wrap in middle of word
set linebreak

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

autocmd InsertEnter * :set norelativenumber
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
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

let g:syntastic_javascript_checkers = ['eslint']

" Use local eslint if possible
function! SyntasticESlintChecker()
  let l:npm_bin = ''
  let l:eslint = 'eslint'

  if executable('npm')
      let l:npm_bin = split(system('npm bin'), '\n')[0]
  endif

  if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint')
    let l:eslint = l:npm_bin . '/eslint'
  endif

  let b:syntastic_javascript_eslint_exec = l:eslint
endfunction

"let g:syntastic_javascript_checkers = ["eslint"]

autocmd FileType javascript :call SyntasticESlintChecker()


" Add to airline
let g:airline#extensions#syntastic#enabled = 1


" Setup ctrlp"
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Do not fold markdown
let g:vim_markdown_folding_disabled = 1


" Remap keys
inoremap kj <Esc>

" leader+c copies to system clipboard
map <leader>c "+y

" leader+n toggles nerdtree
map <leader>n :NERDTreeToggle<CR>
