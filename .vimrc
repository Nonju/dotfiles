
" General
set number
set laststatus=2 " filename always visible
set splitright
set splitbelow
let mapleader = ","
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab smarttab noexpandtab copyindent preserveindent
set mouse=a
set autochdir

" Quick switching between tabs
nnoremap H gT
nnoremap L gt

" Allow for case insensitive search by default ( enable by adding \C to pattern )
" Ex: 
"  - /word      " Case insensitive
"  - /Word      " Case sensitive
"  - /word\C    " Case sensitive
"  - /Word\c    " Case insensitive
set ignorecase
set smartcase

" Prevent paste from yanking replaced text
" xnoremap p pgvy

set swapfile
set dir=~/.vimswaps/

" Block cursor
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Colorscheme - https://github.com/sickill/vim-monokai
syntax enable
colorscheme monokai

" Plugins
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter' " https://github.com/scrooloose/nerdcommenter
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

call plug#end()

" NERDcommenter
filetype plugin on
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDAltDelims_java = 1 " Set a language to use its alternate delimiters by default
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } } " Add your own custom formats or override the defaults
let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not 

" CTRLP.vim
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Svelte syntax
let g:svelte_preprocessors = ['typescript', 'ts']
let g:svelte_preprocessor_tags = [
	  \ { 'name': 'postcss', 'tag': 'style', 'as': 'scss' }
  \ ]
" You still need to enable these preprocessors as well.
let g:svelte_preprocessors = ['postcss']

" Fix for 'buftype is set' issue
set bt=


"" ### Vim commands ###

"" Reload .vimrc
" :source ~/.vimrc


"" Install / add plugins
" Append new plugin to Plug list
"   - `Plug https://github.com/scrooloose/nerdcommenter`  " Full length notation
"   - `Plug scrooloose/nerdcommenter`                     " Shorthand notation
" Reload / restart .vimrc
" Run :PlugInstall


"" Window pane handling
" C-w K     - Reorient windows to a **horizontal** split
" C-w H     - Reorient windows to a **vertical** split
"
" C-w _     - Expand current horizontally split pane to full height
" C-w |     - Expand current vertically split pane to full width
" C-w =     - Restore expanded pane to equal split (Horizontally and vertically)
" C-w +/-   - Increase / Decrease pane vertical size
" C-w </>   - Increase / Decrease pane horizontal size
"
" C-w T     - Move current pane to new tab


"" CTRLP.vim shortcuts (Picked from https://github.com/ctrlpvim/ctrlp.vim#once-ctrlp-is-open)
" Use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
" Press <c-d> to switch to filename only search instead of full path
" Use <c-j>, <c-k> or the arrow keys to navigate the result list.
"
