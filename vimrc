set nocompatible

" Load plugins from ~/.vim/bundle and process doc
filetype off
execute pathogen#infect()

" Set term settings to xterm-256
if &term == "xterm"
    set t_Co=256
	set t_Sf=[3%p1%dm
	set t_Sb=[4%p1%dm

	color desert256grey
endif

" Set terminal font encoding
set encoding=utf-8
set termencoding=utf-8

"{{{ General settings

" Turn on syntax highlighting
syntax on

" Save up to 100 commands executed
set history=200

" enable filetype detection:
filetype on
filetype plugin on
filetype indent on

" Set the leader for the whole file
let mapleader = ","

" Fold by marker by default '{{{' and '}}}'
set foldmethod=marker

" Cool tab completion stuff
set wildmenu

"set wildmode=list:longest,full
set wildmode=list:list:longest

set wildignore+=*.swp,*.zip,*.tar,*.gz,*.class,*.o

" Allow backspace over newlines
set backspace=2

" Allow buffers to move to the background without
" complaining about needing to be saved
set hidden

" Define the location of our exuberant ctags file
set tags=./tags;/

"}}}

"{{{ Display settings

" Show matching parens, brackets, etc
set showmatch

" Show commands as you're typing them
set showcmd

" Show the cursor position ruler at the bottom
set ruler

" Display nonprintable characters
set list

" ToggleList function {{{
let g:toggle_list = 1
function! ToggleList()
	if exists("g:toggle_list")
		if !exists("b:toggle_list_state")
			let b:toggle_list_state = &list ? 1 : 0
		endif
		let b:toggle_list_state = (b:toggle_list_state + 1) % 3
		if b:toggle_list_state == 0
			set nolist
		elseif b:toggle_list_state == 1
			set listchars=tab:»\ ,trail:·,nbsp:·
			set list
		elseif b:toggle_list_state == 2
			set listchars=tab:»\ ,trail:·,eol:¶,nbsp:·
			set list
		endif
	else
		set list!
	endif
endfunction
" }}}

" Display tabs as dot-space instead of ^I
"set listchars=tab:»\ ,trail:·,nbsp:·

" Scroll offset of 3
set scrolloff=3

" Do not wrap text lines
set nowrap

" Turn on line numbers
"set nu

" Change the background color the hightlight menu from ugly pink to nice blue
:highlight Pmenu ctermbg=DarkBlue ctermfg=white gui=bold
:highlight PmenuSel ctermbg=LightBlue ctermfg=red gui=bold

" Highlight trailing whitespace with a red background
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/ " This will not match trailing whitespace when typing on a line
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" }}}

"{{{ Spacing and tabbing
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
set nowrap
set smartindent
" }}}

" {{{ Search, replace, and paste

" Ignore case in search - except...
set ignorecase

" Only do case-sensitive search when a capital has been typed
set smartcase

" Search right when you start typing
set incsearch

" Highlight the found search
set hlsearch

" Toggle paste mode
set pastetoggle=<F10>

"}}}

"{{{ Mouse options

set mouse=a
"set mousemodel=popup
set ttymouse=xterm2

" set up command mode abbreviations for mouseoff and mouseon
cabbrev mouseoff set mouse=<CR>
cabbrev mouseon set mouse=a<CR>

"}}}

"{{{ User Interface

" Status line settings
set laststatus=2 "Always have a status line
set statusline=%-3.3n\ %f%(\ %r%)%(\ %%m%0*%)%=(%l,\ %c)\ %P\ [%{&encoding}%{&fileformat}]%(\ %w%)\ %y
set shortmess+=aI "Use nice short status notices

hi StatusLine term=inverse cterm=NONE ctermfg=white ctermbg=black
hi StatusLineNC term=none cterm=NONE ctermfg=darkgray ctermbg=black

"}}}

"{{{ Auto Commands

" When editing a file, always jump to the last cursor position
 au BufReadPost *
       \ if ! exists("g:leave_my_cursor_position_alone") |
       \     if line("'\"") > 0 && line ("'\"") <= line("$") |
       \         exe "normal g'\"" |
       \     endif |
       \ endif

" {{{ Templates
autocmd BufNewFile *.sh 0r ~/.vim/templates/template.sh
autocmd BufNewFile *.ksh 0r ~/.vim/templates/template.ksh
autocmd BufNewFile *.java 0r ~/.vim/templates/template.java
autocmd BufNewFile *.py 0r ~/.vim/templates/template.py
" }}}

" {{{ Git settings
" Go to the top of git commit files, do not remember where we left off
autocmd BufReadPost COMMIT_EDITMSG exe "normal gg"
autocmd BufReadPost COMMIT_EDITMSG exe "normal $a  "

" Enable spell-checking for commit messages
autocmd BufNewFile,BufReadPost COMMIT_EDITMSG set spell

" Wrap commit messages at 72 chars
autocmd BufNewFile,BufReadPost COMMIT_EDITMSG set tw=72
" }}}

" Automatically run ctags when writing our files
au BufWritePost *.php,*.java silent! !ctags -R 2>/dev/null &

" }}}

"{{{ Mappings

" disable stop/quit (only works with stty -ixon)
:map <C-s> :"stop/quit disabled!<CR>
:map <C-q> :"stop/quit disabled!<CR>

" disable suspend
:map <C-z> :"suspending disabled!<CR>

" Space will toggle folds.  Very helpful.
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz
map * *zz
map # #zz

" Left/Right arrows to previous/next buffer
map  <left> :bp<CR>
map  <right> :bn<CR>

" Tab/Shift-tab to previous/next buffer
nmap <S-tab> :bp<CR>
nmap <tab> :bn<CR>

" Control arrows move tabs
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>

" Tab commands
map <leader>tc :tabnew<cr>
map <leader>td :tabclose<cr>
map <leader>tm :tabmove
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>

nmap <F6> :call ToggleList()<CR>

" Load/Source the vimrc quickly
nmap <leader>s :source $MYVIMRC<CR>
nmap <leader>e :e $MYVIMRC<CR>

" Quickly delete a buffer
nmap <leader>d :bd<CR>

" Quickly toggle spellcheck
nmap <leader>l :set spell!<CR>

" Mapping to remove all trailing whitespace on lines
nmap <leader>w :%s/\s\+$//<CR>:let @/=''<CR>

" Change to current file directory upon request
nmap <silent> <Leader>cd :cd %:p:h<CR>

nmap <leader>fw :set autoindent cindent shiftwidth=2 tabstop=2 expandtab smarttab<CR>

" Make horizontal scrolling faster
nnoremap zh 20zh
nnoremap zl 20zl

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>

" }}}

"{{{ Backup settings

set writebackup " We want to write a backup file
set backupdir=~/.vim/backup,.,~/tmp,~/ " Store the backup file outside the current directory if it exists
set directory=~/.vim/tmp,.,~/tmp,/var/tmp,/tmp " Store the swap file outside the current directory if it exists

if version >= 703
	" Set persistent undo within files
	set undodir=~/.vim/undodir
	set undofile
	set undolevels=1000  "maximum number of changes that can be undone
	set undoreload=10000 "maximum number lines to save for undo on a buffer reload
endif

" }}}

"{{{ Testbed

" Ignore diff whitespace
set diffopt+=iwhite

" Test out omnicompletion
set ofu=syntaxcomplete#Complete

" Python configuration
autocmd BufRead,BufNewFile *.py syntax on
autocmd BufRead,BufNewFile *.py set ai
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,with,try,except,finally,def,class
au FileType python setl autoindent tabstop=2 expandtab shiftwidth=2 softtabstop=2
au FileType python filetype plugin indent on
au FileType python set foldmethod=indent foldlevel=99
let g:pydiction_location = '$HOME/.vim/after/ftplugin/pydiction/complete-dict'
au FileType python,man map <buffer> <leader>pw :call ShowPyDoc('<C-R><C-W>', 1)<CR>
au FileType python,man map <buffer> <leader>pW :call ShowPyDoc('<C-R><C-A>', 1)<CR>
au FileType python,man map <buffer> <leader>pk :call ShowPyDoc('<C-R><C-W>', 0)<CR>
au FileType python,man map <buffer> <leader>pK :call ShowPyDoc('<C-R><C-A>', 0)<CR>
" Execute file being edited with <Shift> + e:
au FileType python map <buffer> <S-e> :w<CR>:!/opt/freeware/bin/python % <CR>

" Search the current file for what's currently in the search register and display matches
nmap <silent> ,gs :vimgrep /<C-r>// %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Search the current file for the word under the cursor and display matches
nmap <silent> ,gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Search the current file for the WORD under the cursor and display matches
nmap <silent> ,gW :vimgrep /<C-r><C-a>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" }}}

" Plugin settings {{{

" {{{ NERDTree
map <F5> :NERDTreeToggle<CR>
map <F12> :NERDTreeToggle<CR>
" Set the location of our NERDTree bookmarks file
let g:NERDTreeBookmarksFile=expand('$HOME') . '/.vim/NERDTreeBookmarks'

" Open NERDTree if no arguments are specified
autocmd vimenter * if !argc() | NERDTree | endif

" Close vim if the only buffer left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" }}}

" {{{ fugitive
nnoremap <Leader>gb :Gblame<Enter>
nnoremap <Leader>gd :Gdiff<Enter>
nnoremap <Leader>gl :Glog<Enter>
nnoremap <Leader>gs :Gstatus<Enter>
" }}}

" {{{ YankRing
" Open up our yank rink upon request
let g:yankring_history_file = '.vim/yankring_history'
nnoremap <Leader>pp :YRShow<Enter>
inoremap <Leader>pp <ESC>:YRShow<Enter>
"  }}}

" {{{ FuzzyFinder
map \ff :FufFile<CR>
map \fm :FufMruFile<CR>
map \fb :FufBuffer<CR>
" Set the fuzzy finder temporary directory
let g:fuf_dataDir="~/.vim/tmp/fuzzy-finder/"
" }}}

" {{{ Taglist
" Tell the taglist plugin that the window size cannot be changed
let Tlist_Inc_Winwidth=0

" Taglist commands
map <leader>tl :TlistToggle<cr>
" }}}

" {{{ Closetag
" Source our closetag function with the right document types
au FileType html,xml,xsl,xslt source ~/.vim/bundle/closetag/closetag.vim
" }}}

" CtrlP {{{
let g:ctrlp_prompt_mappings = {
    \ 'PrtBS()': ['<c-h>'],
    \ 'PrtCurLeft()': ['<left>'],
    \ }

nmap <leader>cpp :CtrlP<CR>
nmap <leader>cpb :CtrlPBuffer<CR>
nmap <leader>cpm :CtrlPMRU<CR>
let g:ctrlp_match_window_reversed = 0 " Put search results at the top instead of the bottom
let g:ctrlp_regexp = 1 " Search as regex by default
let g:ctrlp_max_files = 10000
let g:ctrlp_max_depth = 40
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/vim/cache/ctrlp'
let g:ctrlp_open_multiple_files = '2vr'
let g:ctrlp_extensions = ['tag', 'undo', 'mixed']
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|build$\'
\}
" }}}
" }}}

set nocompatible
