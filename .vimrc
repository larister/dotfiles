set nocompatible
 
" Install plugins
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'kien/ctrlp.vim'
Plug 'isruslan/vim-es6'
Plug 'mustache/vim-mustache-handlebars'
Plug 'elzr/vim-json'
Plug 'lfilho/cosco.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'

call plug#end()

" Autoreload
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" open help in a new tab
augroup HelpInTabs
  autocmd!
  autocmd BufEnter *.txt call HelpInNewTab()
augroup END

function! HelpInNewTab ()
  if &buftype == 'help'
    "Convert the help window to a tab...
    execute "normal \<C-W>T"
  endif
endfunction

" Set styling
set t_Co=256
syntax on
set background=dark
colorscheme distinguished

" Do not auto-add new lines
set noeol

" Autoindent new lines
set autoindent

" Nicer looking invisibles
set listchars=tab:▸·,eol:¬
highlight NonText ctermfg=8 guifg=#4a4a59

" Do not wrap in middle of word
set linebreak

" Filetype plugins
filetype plugin on

" Mustache syntax for .template
au BufNewFile,BufRead *.template set filetype=mustache

" No swap files
:set noswapfile

" Setup highlighting
set hlsearch
set incsearch
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Tab stop (both normal and insert) of 4
set tabstop=4
set shiftwidth=4
set softtabstop=4
" Expand tabs to spaces
set noexpandtab

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

autocmd FileType javascript :call SyntasticESlintChecker()

set suffixesadd+=.js

" Mouse scrolling
:set mouse=a

" Configure airline
let g:airline#extensions#syntastic#enabled = 1
" Install Roboto Light from https://github.com/powerline/fonts
let g:airline_powerline_fonts = 1

" Setup ctrlp"
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Do not fold markdown
let g:vim_markdown_folding_disabled = 1

" Remap keys

" Use comma as leader
let mapleader = ","

" kj to exit insert
inoremap kj <Esc>

" Setup cosco
nnoremap <leader>; :CommaOrSemiColon<CR>

" leader+l toggles `set list` (show hidden invisibles)
nmap <leader>l :set list!<CR>

" leader+c copies visual to system clipboard
map <leader>c "+y

" leader+n toggles nerdtree
map <leader>n :NERDTreeToggle<CR>

" copy relative path to system clipboard  (src/foo.txt)
nnoremap <leader>cf :let @*=expand("%")<CR>
" absolute path  (/something/src/foo.txt)
nnoremap <leader>cF :let @*=expand("%:p")<CR>
" filename       (foo.txt)
nnoremap <leader>ct :let @*=expand("%:t")<CR>
" directory name (/something/src)
nnoremap <leader>ch :let @*=expand("%:p:h")<CR>
