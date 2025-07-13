" Enable Syntax
syntax on

" Enable relative line numbering
"set rnu
set nu
" Disable  mouse
"set mouse=v
set mouse=a

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


" Testing (may need to del later)
" Fold highlighted lines in visual mode
set foldmethod=manual
" USE:
" zf  -  create fold
" zo  -  open fold
" zc  -  close fold
" zd  -  delete fold
" zR  -  open all folds
" zM  -  close all folds

" Visualize tabs and newlines
set listchars=tab:▸\ ,trail:⌋

" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off                                                                                                                                                                                                     
"Toggle tabs and trail
nnoremap <leader>l :set list!<CR>


colorscheme desert
set termguicolors


" Chinmay Vim customizations:

inoremap <c-b> <Esc>:Lex<cr>:vertical resize 40<cr>
nnoremap <c-b> <Esc>:Lex<cr>:vertical resize 40<cr>
let g:netrw_liststyle = 3        " Tree-style view
"let g:netrw_banner = 0           " Hide the help banner
let g:netrw_altv = 1             " Open in a vertical split
let g:netrw_winsize = 35        " Set width of the explorer
"let g:markdown_syntax_conceal = 0
autocmd FileType netrw highlight netrwMarkFile ctermbg=yellow ctermfg=black guibg=yellow guifg=black

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

" Draw-It
Plug 'vim-scripts/DrawIt'

" Ansi-Esc
Plug 'powerman/vim-plugin-AnsiEsc'

" File Explorer
Plug 'preservim/nerdtree'

" Syntax Highlighting
Plug 'sheerun/vim-polyglot'


call plug#end()

"----------------------------------------------------------------
" Associate .txt files with python like syntax

autocmd BufNewFile,BufRead *.txt set syntax=python
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!




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


set clipboard=unnamedplus

set guifont=Monospace\ 12
set cursorline
" highlight CursorLine ctermbg=NONE guibg=#4e4e4e
"highlight CursorLine cterm=NONE ctermbg=237 gui=NONE guibg=#3a3a3a
highlight CursorLine cterm=NONE ctermbg=237 gui=NONE guibg=#4e4e4e



" Only Enable this for AnsiEsc characters
"autocmd BufReadPost * AnsiEsc





" Setting my custom filefypes
" --------------------------------------
" augroup filetype
"     au!
"     au BufRead,BufNewFile *.tcl set filetype=tcl
"     au BufRead,BufNewFile *.tcl set isk+=:
"     au BufRead,BufNewFile *.rules set filetype=tcl_svrf
"     au BufRead,BufNewFile *.rules set isk+=:
"     au BufRead,BufNewFile *rules* set filetype=tcl
"     au BufRead,BufNewFile *rules* set isk+=:
"     au BufRead,BufNewFile *.drc set filetype=calibre
"     au BufRead,BufNewFile *.svrf set filetype=calibre
"     au BufRead,BufNewFile *.lvs set filetype=calibre
" augroup END



augroup filetype
    au!
    
    " Set .txt files as conf files
    au BufRead,BufNewFile *.txt set filetype=conf
    " Set .tcl files to TCL
    au BufRead,BufNewFile *.tcl set filetype=tcl

    " Set .txt files as conf files
    au BufRead,BufNewFile *.lib set filetype=sh
    
    " Set .net layout files as spice files 
    au BufNewFile,BufRead *.sp,*.spice,*.net set filetype=spice 
    
    " Match both: 
    " - Files exactly named 'rules' or containing 'rules' 
    " - Files ending with '.rules'
    au BufRead,BufNewFile *rules* set filetype=tcl_svrf
    au BufRead,BufNewFile *.rules set filetype=tcl_svrf

    " Set filetype for other SVRF/Calibre files
    au BufRead,BufNewFile *.drc,*.svrf,*.lvs set filetype=calibre

    " Fix isk+=: for TCL and TCL_SVRF
    au FileType tcl,tcl_svrf setlocal isk+=:



augroup END


augroup custom_highlights
    autocmd!
    " Custom colored tags
    autocmd BufEnter * syntax match TagDONE      /\v<(DONE|done)>/
    autocmd BufEnter * syntax match TagFIXED     /#FIXED/
    autocmd BufEnter * syntax match TagERROR     /#ERROR/
    autocmd BufEnter * syntax match TagNEGATIVE  /#NEGATIVE_TC/
    autocmd BufEnter * syntax match TagTOT       /#TOT/
    autocmd BufEnter * syntax match Tag2025_1      /#2025\.1/
    autocmd BufEnter * syntax match Tag2025_2      /#2025\.2/
    autocmd BufEnter * syntax match Tag2025_3      /#2025\.3/
    autocmd BufEnter * syntax match TagTODO      /\v<TODO>/
    autocmd BufEnter * syntax match TagFIXME     /\v<FIXME>/
    autocmd BufEnter * syntax match CommentWIP   /#WIP/
    autocmd BufEnter * syntax match CommentMASA  /\v#(MASA|masa)/
    autocmd BufEnter * syntax match TagPASSED    /\v<(PASSED|pass|passed|Pass|PASS)>/ 
    autocmd BufEnter * syntax match TagFAILED    /\v<(FAILED|fail|Fail|FAIL|failed)>/ 
    autocmd BufEnter * syntax match TagReadyQA    /\v<(Ready for QA)>/ 
    autocmd BufEnter * syntax match TagInValidation  /\v<(In Validation)>/ 
"    autocmd BufEnter * syntax match TagP1         /\v<(P1)>/ 
"    autocmd BufEnter * syntax match TagP2         /\v<(P2)>/ 
    autocmd BufEnter * syntax match TagACTIVE     /\v<(ACTIVE|active)>/ 
    autocmd BufEnter * syntax match TagPAUSED     /\v<(PAUSED|paused)>/ 
    autocmd BufEnter * syntax match TagInProgress /\v<(IN PROGRESS)>/ 


    " Custom highlight styles
    autocmd BufEnter * highlight TagDONE      ctermfg=Green   guifg=Green
    autocmd BufEnter * highlight TagFIXED     ctermfg=Green   guifg=Green
    autocmd BufEnter * highlight TagERROR     ctermfg=Magenta guifg=Magenta
    autocmd BufEnter * highlight TagTOT       ctermfg=Magenta guifg=Magenta
    autocmd BufEnter * highlight Tag2025_1    ctermfg=Yellow  guifg=Yellow
    autocmd BufEnter * highlight Tag2025_2    ctermfg=Yellow  guifg=Yellow
    autocmd BufEnter * highlight Tag2025_3    ctermfg=Yellow  guifg=Yellow
    autocmd BufEnter * highlight TagTODO      ctermfg=Yellow  guifg=Yellow
    autocmd BufEnter * highlight TagFIXME     ctermfg=Red     guifg=Red
    autocmd BufEnter * highlight CommentWIP   ctermfg=Yellow  guifg=Yellow
    autocmd BufEnter * highlight CommentMASA  ctermfg=Red     guifg=Red
    autocmd BufEnter * highlight TagNEGATIVE  ctermfg=Red     guifg=Red
    autocmd BufEnter * highlight TagPASSED    ctermfg=Green   guifg=Green
    autocmd BufEnter * highlight TagFAILED    ctermfg=Red     guifg=Red
    autocmd BufEnter * highlight TagReadyQA   ctermfg=Green   guifg=Green
    autocmd BufEnter * highlight TagInValidation ctermfg=Yellow  guifg=Yellow
"    autocmd BufEnter * highlight TagP1        ctermfg=Red     guifg=Red
    autocmd BufEnter * highlight TagACTIVE    ctermfg=Green   guifg=Green
    autocmd BufEnter * highlight TagPAUSED    ctermfg=Yellow  guifg=Yellow
    autocmd BufEnter * highlight TagInProgress ctermfg=Yellow  guifg=Yellow
augroup END


" JIRA
nnoremap <leader>t :r !jira list --template simple --query "(assignee = chiroz51 OR \"QA Owner\" = chiroz51) AND project in (PERC, PERC_AMY) AND status not in (closed, released, done)"<CR>

nnoremap <leader>tt :r !jira list --template list --query "(assignee = chiroz51 OR \"QA Owner\" = chiroz51) AND project in (PERC, PERC_AMY) AND status not in (closed, released, done) ORDER BY fixVersion DESC"<CR>



"lua require("image_config")
"
"" In your vimrc
"let g:vimwiki_template_path = '~/vimwiki/Templates/'
"let g:vimwiki_template_default = 'WorkLog'
"let g:vimwiki_template_ext = '.md'
"
"" Add to your vimrc
"command! WorkLog read ~/vimwiki/Templates/WorkLog.md



" DEBUG
":highlight TempHighlight ctermfg=yellow guifg=yellow
":match TempHighlight /Debug Net\|Debug Device|DEBUG|debug|debugging|Debugging|Debuged|debuged/

" DEBUG highlighting
highlight TempHighlight ctermfg=yellow guifg=yellow
match TempHighlight /\v(Debug Net|Debug Device|DEBUG|debug(ging)?|Debug(ging|ed)|debuged)/


" NERDTREE
" Map <Leader>n to toggle NERDTree
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif


" Highlight dates in the format YYYY-MM-DD
"syntax match DatePattern /\v\w{3}\s+\w{3}\s+\d{1,2}\s+\d{2}:\d{2}:\d{2}\s+\w{3,4}\s+\d{4}/ containedin=ALL
"highlight DatePattern ctermfg=cyan guifg=cyan cterm=bold gui=bold
augroup DateHighlight
    autocmd!
    " Standard date format YYYY-MM-DD
    autocmd BufEnter,BufRead * syntax match DatePattern /\d\{4\}-\d\{2\}-\d\{2\}/ containedin=ALL
    " Full date time format (Mon Jun 16 00:00:00 PDT 2025)
    autocmd BufEnter,BufRead * syntax match DatePattern /\v\w{3}\s+\w{3}\s+\d{1,2}\s+\d{2}:\d{2}:\d{2}\s+\w{3,4}\s+\d{4}/ containedin=ALL
    " Set highlighting for both patterns
    autocmd BufEnter,BufRead * highlight DatePattern ctermfg=cyan guifg=cyan cterm=bold gui=bold
augroup END


" Copy to clipboard
vnoremap <leader>y :w !xclip -sel clip<CR><CR>

" Paste from clipboard
nnoremap <leader>p :r !xclip -sel clip -o<CR>




