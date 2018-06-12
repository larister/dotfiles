set nocompatible

" Install plugins
call plug#begin('~/.vim/plugged')

Plug 'bronson/vim-visual-star-search'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'isruslan/vim-es6'
Plug 'mustache/vim-mustache-handlebars'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'
Plug 'lfilho/cosco.vim'
Plug 'larister/delete-wrapper.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'dyng/ctrlsf.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'danro/rename.vim'
Plug 'sjl/gundo.vim'
Plug 'valloric/youcompleteme'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'rbgrouleff/bclose.vim'
Plug 'heavenshell/vim-pydocstring'
Plug 'djoshea/vim-autoread'
Plug 'mattn/emmet-vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

call plug#end()

" From vim sensible, better indentation/insert mode
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

" persistent undo
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories - MUST BE CREATED
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

set wildmenu " visual autocomplete for command menu

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

" Allow switching from an unsaved buffer
set hidden

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

filetype plugin on " Filetype plugins
filetype indent on " Filetype indent

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

" Remove JSHint from ale linters
let g:ale_linters = {
\    'javascript': ['eslint', 'flow', 'standard', 'prettier', 'prettier-eslint', 'xo']
\}

let g:prettier#autoformat = 0
let g:prettier#quickfix_auto_focus = 0
let g:prettier#config#tab_width = 4
let g:prettier#config#print_width = 140
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#trailing_comma = 'es5'
let g:prettier#config#jsx_bracket_same_line = 'false'
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync


function! NumberToggle()
      if(&relativenumber == 1)
          set number
      else
          set relativenumber
      endif
endfunc

let g:jsx_ext_required = 0 " Allow JSX in normal JS files

"@lfilho's Test This feature
function! <SID>TestThis()
    let originalCursorPosition = getpos('.')
    let oldReg = getreg('y')
    let oldSearch = getreg('/')
    keepjumps normal! gg/describe('f'vi'"yy
    " Use https://github.com/tpope/vim-dispatch later on:
    "exec "!$(npm bin)/grunt mocha-phantom --reporter=dot --spec=" . getreg('z')
    exec "!open http://localhost:3000/tests/?reporter=standard\\&exactMatch=true\\&spec=" . fnameescape(getreg('y'))
    call setreg('y', oldReg)
    call setreg('/', oldSearch)
    call setpos('.', originalCursorPosition)
endfunction

command! TestThis call <SID>TestThis()

" Show statusline
set laststatus=2

" Allow auto-finding files with gf
set path+=public
set suffixesadd+=.js,.template

" Mouse scrolling
set mouse=a

" Configure airline
let g:airline#extensions#ale#enabled = 1
" Install Roboto Light from https://github.com/powerline/fonts
let g:airline_powerline_fonts = 1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Setup ctrlp"
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|build'
let g:ctrlp_open_multiple_files = 'ij'
" Do not fold markdown
let g:vim_markdown_folding_disabled = 1
" Do not conceal with JSON
let g:vim_json_syntax_conceal = 0
" Show hidden files in NERDTree by default
let g:NERDTreeShowHidden= 1
" Close NERDTree when a file is selected
let g:NERDTreeQuitOnOpen = 1

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"

" Use Q to intelligently close a window
" (if there are multiple windows into the same buffer)
" or kill the buffer entirely if it's the last window looking into that buffer
function! CloseWindowOrKillBuffer()
  let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

  " We should never bdelete a nerd tree
  if matchstr(expand("%"), 'NERD') == 'NERD'
    wincmd c
    return
  endif

  if number_of_windows_to_this_buffer > 1
    wincmd c
  else
    Bclose
  endif
endfunction

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

" Remap keys

" Use space as leader
let g:mapleader = "\<Space>"

" Setup cosco
autocmd FileType javascript,css nmap <silent> <Leader>; <Plug>(cosco-commaOrSemiColon)


" Mocha tests
nnoremap <leader>t :TestThis<CR><CR>

" Gundo toggle
nnoremap <leader>u :GundoToggle<CR>

" Ale previous/next
nmap <silent> <leader>R <Plug>(ale_previous_wrap)
nmap <silent> <leader>r <Plug>(ale_next_wrap)

" highlight last inserted text
nnoremap gV `[v`]

nmap <silent> <C-_> <Plug>(pydocstring)

" Navigate windows more easily
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" leader+l toggles `set list` (show hidden invisibles)
nnoremap <leader>l :set list!<CR>

" leader+c copies visual to system clipboard
noremap <leader>c "+y

" leader+n toggles nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>N :NERDTreeFind<CR>

" toggle paste
nnoremap <leader>p :set paste!<CR>

" move lines logically
nnoremap j gj
nnoremap k gk

nnoremap gj j
nnoremap gk k

" edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
" reload vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>:AirlineRefresh<CR>

" map arrow keys to buffer switching
nnoremap <Left> :bp<CR>
nnoremap <Right> :bn<CR>
" but ignore when in nerdtree/ctrlsf
autocmd FileType nerdtree noremap <buffer> <Left> <nop>
autocmd FileType nerdtree noremap <buffer> <Right> <nop>

" copy relative path to system clipboard  (src/foo.txt)
nnoremap <leader>cf :let @*=expand("%")<CR>
" absolute path  (/something/src/foo.txt)
nnoremap <leader>cF :let @*=expand("%:p")<CR>
" filename       (foo.txt)
nnoremap <leader>ct :let @*=expand("%:t")<CR>
" directory name (/something/src)
nnoremap <leader>ch :let @*=expand("%:p:h")<CR>

nmap <leader>ff <Plug>CtrlSFPrompt
nnoremap <leader>fo :CtrlSFOpen<CR>

noremap <leader>o o<C-[>k
noremap <leader>O O<C-[>j

" use camel case motion
call camelcasemotion#CreateMotionMappings('<leader>')

noremap <silent> Q :call CloseWindowOrKillBuffer()<CR>

" debugging, use leader-DD to start, do a slow action, then leader-DQ to
" finish. Your output will be in profile.log
nnoremap <silent> <leader>DD :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
nnoremap <silent> <leader>DQ :exe ":profile pause"<cr>:noautocmd qall!<cr>
