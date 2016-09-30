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
Plug 'dyng/ctrlsf.vim'

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

" Update quicksmart
set updatetime=250

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
nnoremap <silent> <C-n> :<C-u>nohlsearch<CR>

" Tab stop (both normal and insert) of 4
set tabstop=4
set shiftwidth=4
set softtabstop=4
" Expand tabs to spaces
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

"@lfilho's Test This feature
function! <SID>TestThis()
    let originalCursorPosition = getpos('.')
    let oldReg = getreg('z')
    let oldSearch = getreg('/')
    keepjumps normal! gg/describe('f'vi'"zy
    " Use https://github.com/tpope/vim-dispatch later on:
    "exec "!$(npm bin)/grunt mocha-phantom --reporter=dot --spec=" . getreg('z')
    exec "!open http://localhost:3000/tests/?spec=" . getreg('z')
    call setreg('z', oldReg)
    call setreg('/', oldSearch)
    call setpos('.', originalCursorPosition)
endfunction

command! TestThis call <SID>TestThis()

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
function! CheckJavaScriptLinter(filepath, linter)
	if exists('b:syntastic_checkers')
		return
	endif
	if filereadable(a:filepath)
		let b:syntastic_checkers = [a:linter]
		let {'b:syntastic_' . a:linter . '_exec'} = a:filepath
	endif
endfunction

function! SetupJavaScriptLinter()
	let l:current_folder = expand('%:p:h')
	let l:bin_folder = fnamemodify(syntastic#util#findFileInParent('package.json', l:current_folder), ':h')
	let l:bin_folder = l:bin_folder . '/node_modules/.bin/'
	call CheckJavaScriptLinter(l:bin_folder . 'standard', 'standard')
	call CheckJavaScriptLinter(l:bin_folder . 'eslint', 'eslint')
endfunction

autocmd FileType javascript call SetupJavaScriptLinter()

" Allow auto-finding files with gf
set path+=public
set suffixesadd+=.js,.template

" Mouse scrolling
set mouse=a

" Configure airline
let g:airline#extensions#syntastic#enabled = 1
" Install Roboto Light from https://github.com/powerline/fonts
let g:airline_powerline_fonts = 1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Setup ctrlp"
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Do not fold markdown
let g:vim_markdown_folding_disabled = 1

" Do not conceal with JSON
let g:vim_json_syntax_conceal = 0

" Show hidden files in NERDTree by default
let g:NERDTreeShowHidden=1

" Remap keys

" Use comma as leader
let mapleader = ","

" kj to exit insert
inoremap kj <Esc>

" Setup cosco
nnoremap <leader>; :CommaOrSemiColon<CR>

" Mocha tests
nnoremap <leader>t :TestThis<CR><CR>

" Navigate windows more easily
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" leader+l toggles `set list` (show hidden invisibles)
nmap <leader>l :set list!<CR>

" leader+c copies visual to system clipboard
map <leader>c "+y

" leader+n toggles nerdtree
map <leader>n :NERDTreeToggle<CR>

" toggle paste
set pastetoggle=<leader>p

" map arrow keys to buffer switching
map <Left> :bp<CR>
map <Right> :bn<CR>

" copy relative path to system clipboard  (src/foo.txt)
nnoremap <leader>cf :let @*=expand("%")<CR>
" absolute path  (/something/src/foo.txt)
nnoremap <leader>cF :let @*=expand("%:p")<CR>
" filename       (foo.txt)
nnoremap <leader>ct :let @*=expand("%:t")<CR>
" directory name (/something/src)
nnoremap <leader>ch :let @*=expand("%:p:h")<CR>

nmap <leader>f <Plug>CtrlSFPrompt

" debugging, use leader-DD to start, do a slow action, then leader-DQ to
" finish. Your output will be in profile.log
nnoremap <silent> <leader>DD :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
nnoremap <silent> <leader>DQ :exe ":profile pause"<cr>:noautocmd qall!<cr>
