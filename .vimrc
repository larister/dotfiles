set nocompatible

" Install plugins
call plug#begin('~/.vim/plugged')

Plug 'bronson/vim-visual-star-search'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
"Plug 'w0rp/ale'
Plug 'ctrlpvim/ctrlp.vim'
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
Plug 'qpkorr/vim-bufkill'
Plug 'bkad/CamelCaseMotion'
Plug 'danro/rename.vim'
Plug 'sjl/gundo.vim'
Plug 'valloric/youcompleteme'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'rbgrouleff/bclose.vim'
Plug 'tpope/vim-commentary'

call plug#end()

set autoread " auto reload files

" From vim sensible, better indentation/insert mode
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

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

" Setup linting
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_disabled_filetypes=['sass']

" Annoyingly have to quiet messages as per https://github.com/mustache/vim-mustache-handlebars/issues/6#issuecomment-56907305
let g:syntastic_html_tidy_ignore_errors = ['plain text isn''t allowed in <head> elements']
" if the above doesn't work then try
" let g:syntastic_html_tidy_quiet_messages = { "level" : "warnings" }


" Use local eslint if possible
" (http://nunes.io/notes/guide/vim-how-to-setup-eslint/)
function! CheckJavaScriptLinter(filepath, linter)
    if exists('b:syntastic_checkers')
        return
    endif
    if filereadable(a:filepath)
        let b:syntastic_checkers = [a:linter]
        let {'b:syntastic_' . a:linter . '_exec'} = a:filepath
        return 1
    endif
endfunction

function! CheckFolderForJSLinter(current_folder)
    let l:bin_folder = fnamemodify(syntastic#util#findFileInParent('package.json', a:current_folder), ':h')
    let l:bin_folder = l:bin_folder . '/node_modules/.bin/'

    if CheckJavaScriptLinter(l:bin_folder . 'standard', 'standard')
        return
    endif
    if CheckJavaScriptLinter(l:bin_folder . 'eslint', 'eslint')
        return
    endif
    if a:current_folder == '/'
        return
    endif

    call CheckFolderForJSLinter(fnamemodify(a:current_folder, ':h'))
endfunction

function! SetupJavaScriptLinter()
    let l:current_folder = expand('%:p:h')
    call CheckFolderForJSLinter(l:current_folder)
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

" Use comma as leader
let mapleader = ","

" Set backspace to reverse scan line for char (originally comma)
nnoremap \ ,

" kj to exit insert
inoremap kj <Esc>

" Setup cosco
nnoremap <leader>; :CommaOrSemiColon<CR>

" Mocha tests
nnoremap <leader>t :TestThis<CR><CR>

" Gundo toggle
nnoremap <leader>u :GundoToggle<CR>

" highlight last inserted text
nnoremap gV `[v`]

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
map <leader>N :NERDTreeFind<CR>

" toggle paste
set pastetoggle=<leader>p

" move lines logically
map j gj
map k gk

" highlight last inserted text
nnoremap gV `[v`]

" edit vimrc
nmap <leader>ev :vsplit $MYVIMRC<CR>
" reload vimrc
nmap <leader>sv :source $MYVIMRC<CR>:AirlineRefresh<CR>

" map arrow keys to buffer switching
map <Left> :bp<CR>
map <Right> :bn<CR>
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
nmap <leader>fo :CtrlSFOpen<CR>

nmap <leader>o o<C-[>k
nmap <leader>O O<C-[>j

" use camel case motion
call camelcasemotion#CreateMotionMappings('<leader>')

nnoremap <silent> Q :call CloseWindowOrKillBuffer()<CR>

" debugging, use leader-DD to start, do a slow action, then leader-DQ to
" finish. Your output will be in profile.log
nnoremap <silent> <leader>DD :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
nnoremap <silent> <leader>DQ :exe ":profile pause"<cr>:noautocmd qall!<cr>
