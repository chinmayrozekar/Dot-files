" Enable Syntax
syntax on

" Enable line numbering
set nu

" Disable  mouse
set mouse=v

" Set character set as UTF-8
set encoding=utf-8

" Enable smartcase serach sensitivity
set ignorecase
set smartcase


set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set backspace=indent,eol,start
set autoindent
set laststatus=2                " 2 displays status line always

" Enable highlight searching pattern
set hlsearch

" Enable show matches while typing to search 
set incsearch

" Shows the matching part of pairs [], {}, and ()
set showmatch
colorscheme desert

" Chinmay Vim customizations:

inoremap <c-b> <Esc>:Lex<cr>:vertical resize 40<cr>
nnoremap <c-b> <Esc>:Lex<cr>:vertical resize 40<cr>
let g:netrw_liststyle = 3        " Tree-style view
"let g:netrw_banner = 0           " Hide the help banner
let g:netrw_altv = 1             " Open in a vertical split
let g:netrw_winsize = 35        " Set width of the explorer
"let g:markdown_syntax_conceal = 0


command! Wq wq
command! WQ wq
command! Qa qa
command! QA qa
command! Q q
command! W w


"----------------------------------------------------------------
" Vim Plugins:

call plug#begin()
" Goyo.vim
Plug 'junegunn/goyo.vim'
" Limelight.vim
Plug 'junegunn/limelight.vim'
" Vim-Wiki:
Plug 'vimwiki/vimwiki'

Plug 'suan/vim-instant-markdown'
call plug#end()

"----------------------------------------------------------------
" Associate .txt files with python like syntax

autocmd BufNewFile,BufRead *.txt set syntax=python
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!




"----------------------------------------------------------------
" Mappings to make Vim more friendly towards presenting slides.
autocmd BufNewFile,BufRead *.vpm call SetVimPresentationMode()
function SetVimPresentationMode()
  nnoremap <buffer> <Right> :n<CR>
  nnoremap <buffer> <Left> :N<CR>

  if !exists('#goyo')
    Goyo
  endif
endfunction


"----------------------------------------------------------------
" Vim Wiki:

" Prerequisites 
set nocompatible
filetype plugin on
syntax on

"----------------------------------------------------------------
" Associate .wiki files with python like syntax
autocmd BufNewFile,BufRead *.wiki set syntax=python


let g:vimwiki_list = [{'path': '/wv/chiroz51/misc/cheatsheets/vimwiki/', 'syntax': 'markdown', 'ext': 'md'}]

" set clipboard=unnamedplus



