set nocompatible

" Set term settings to xterm-256
if &term == "xterm"
    set term=xterm-256color
endif

" Set terminal font encoding
set encoding=utf-8
set termencoding=utf-8

"{{{ General settings

" Turn on syntax highlighting
syntax on

" Set colorscheme to our custom color
colorscheme desert256m

" Save up to 200 commands executed
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
"set list

" Display tabs as dot-space instead of ^I
"set listchars=tab:»\ ,trail:·,nbsp:·

" Scroll offset of 3
set scrolloff=3

" Turn on line numbers
"set nu

" Display a line at column 81 to let us know not to enter or cross it.
set colorcolumn=80

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
set shiftwidth=2
set tabstop=2
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
set statusline=%-3.3n\ %f%(\ %r%)%(\ %%m%0*%)%=%{LinterStatus()}\ (%l,\ %c)\ %P\ [%{&encoding}%{&fileformat}]%(\ %w%)\ %y
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

" {{{ Git settings
" Go to the top of git commit files, do not remember where we left off
autocmd BufReadPost COMMIT_EDITMSG exe "normal gg"
autocmd BufReadPost COMMIT_EDITMSG exe "normal $a"

" Enable spell-checking for commit messages
autocmd BufNewFile,BufReadPost COMMIT_EDITMSG set spell

" Wrap commit messages at 72 chars
autocmd BufNewFile,BufReadPost COMMIT_EDITMSG set tw=72
" }}}

" Disable coc for certain files, refer below for file blacklist
autocmd BufNew,BufEnter *.js,*.svelte,*.ts execute "silent! CocEnable"
autocmd BufLeave *.js,*.svelte,*.ts execute "silent! CocDisable"

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
nmap <leader>d :b#<bar>bd#<CR>

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

" Search the current file for what's currently in the search register and display matches
nmap <silent> ,gs :vimgrep /<C-r>// %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Search the current file for the word under the cursor and display matches
nmap <silent> ,gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Search the current file for the WORD under the cursor and display matches
nmap <silent> ,gW :vimgrep /<C-r><C-a>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" }}}

" Plugin settings {{{

" Specify directory for plugins
let g:ale_disable_lsp = 1

call plug#begin('~/.vim/plugged')

Plug 'Yggdroot/indentLine'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'leafOfTree/vim-svelte-plugin'
Plug 'leafgarland/typescript-vim', { 'do': '~/.vim/bundle/typescript-vim' }
Plug 'neoclide/coc.nvim', { 'branch': 'release', 'for': ['typescript', 'javascript', 'svelte'] }
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-rails'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'thoughtbot/vim-rspec'

" Initialize plugin system
call plug#end()

" {{{ vim-svelte-plugin
let g:vim_svelte_plugin_use_typescript = 1
" }}}

" {{{ fugitive
nnoremap <Leader>gb :Gblame<Enter>
nnoremap <Leader>gd :Gdiff<Enter>
nnoremap <Leader>gl :Glog<Enter>
nnoremap <Leader>gs :Gstatus<Enter>
" }}}

" {{{ ale
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_ruby_standardrb_executable = 'bundle'

let g:ale_fixers = {
\   'svelte': ['prettier'],
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\}

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:ok_msg = '⬥ ok'
    let l:count_msg = '⨉ %d, ⚠ %d'

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? ok_msg : printf(count_msg, all_errors, all_non_errors)
endfunction
" }}}

" {{{ IndentLine
" Don't have Indent Line mess with conceal cursor settings
" let g:indentLine_setConceal = 0
" let g:indentLine_noConcealCursor=""
" }}}
