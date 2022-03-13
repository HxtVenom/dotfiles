unlet! skip_defaults_vim

set nocompatible
set number
set relativenumber
syntax on

set hlsearch
set smartcase

set textwidth=72
set linebreak
set wrap

set ruler
set title

set tabstop=2
set shiftwidth=2
set expandtab

set backspace=indent,eol,start

set laststatus=2

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

if filereadable(expand("~/.vim/coc-mappings.vim"))
  source ~/.vim/coc-mappings.vim
endif

set path+=**
set wildmenu

" BEGIN PLUGINS
call plug#begin()

Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim' 
Plug 'scrooloose/nerdcommenter'
" Git plugins
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tsony-tsonev/nerdtree-git-plugin'
" Styling Plugins
Plug 'arzg/vim-colors-xcode'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Language Plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'derekwyatt/vim-scala'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

call plug#end()

" Color Scheme Stuff:
colorscheme xcodedark
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus' ] ]
      \ },
      \ 'component_function':{
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'LightLineCoc'
      \   }
      \ }
" Commenter plugin 
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

let g:NERDTreeGitStatusWithFlags = 1

map <C-o> :NERDTreeToggle<CR>
let g:NERDTreeIgnore = ['^node_modules$']

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()
return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction
" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
wincmd p
endif
endfunction
" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

