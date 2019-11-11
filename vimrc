if &compatible
end

execute pathogen#infect()
syntax on
filetype plugin indent on

filetype off
set rtp+=~/.vim/Vundle.vim/
cal vundle#begin()

" Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

Plugin 'cohlin/vim-colorschemes'
Plugin 'morhetz/gruvbox'
"Plugin 'trevordmiller/nova-vim'

Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive' "Wrap all Git commang
Plugin 'tpope/vim-repeat' "Il punto ripete l'ultima azione
Plugin 'tpope/vim-surround'
Plugin 'w0rp/ale' "syntastic alternative
Plugin 'vimwiki/vimwiki'

Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'leafgarland/typescript-vim'

Plugin 'rking/ag.vim'
Plugin 'bling/vim-airline'

Plugin 'roman/golden-ratio' "auto-reside the windows
Plugin 'scrooloose/nerdtree'
Plugin 'xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/nerdcommenter'

Plugin 'sjl/vitality.vim' "Change Cursor
Plugin 'ntpeters/vim-better-whitespace'

Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}

"ALE syntax
let b:ale_linters = {'javascript': ['eslint', 'tslint']}
let g:airline#extensions#ale#enabled = 1

call vundle#end()
filetype on

" Change <Leader>
let mapleader = ","

set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set autowrite     " Automatically :write before running commands
set laststatus=2  " Always shows the status line at the bottom
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set incsearch     " do incremental searching
"set hlsearch " "Highlights the searched workds. Undo :nohl
"set cursorline    " highlight the current line the cursor is on
"set complete=.,w,b,u,t,i
set colorcolumn=+1
set showmatch "flashes matching brackets or parentheses"
set wildmenu "Enable tab complete. First shows all matches, then starts cycling throught"


"set viminfo=
" Make it obvious where 80 characters is
set textwidth=100

"INDENTATION
"set tabstop=4
set shiftwidth=4
set softtabstop=4
"set smarttab
"set shiftround
set expandtab

"Markdown Preview & vimWiki
let g:instant_markdown_autostart = 0
nnoremap <leader>md :InstantMarkdownPreview<CR>

"ext associated to vimwiki
let g:vimwiki_ext2syntax = { '.md': 'markdown' }

"vimWiki folders. Called them via number<leader>ww
let g:vimwiki_list = [{'path': '~/.Notes/Personal', 'path_html': '~/.Notes/Personal/html/',  'ext': '.md'}, {'path': '~/.Notes/DAZN', 'path_html': '~/.Notes/DAZN/html/',  'ext': '.md'}]


"SEARCH (using AG instead of Grep)
let g:ackprg = 'ag --vimgrep' "After installing 'brew install the_silver_searcher', this line make it works

if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

"Search the word under the cursor
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>
"END SEARCH

"clipboard per copiare da vim ed incollare altrove:
"set clipboard=unnamedplus " Tmux
set clipboard=unnamed " Mac

" Type ipb+space  Add python breakPoint
ab ipb import ipdb; ipdb.set_trace()


" Move between splits
"nnoremap <S-Tab> <C-j>W
"nnoremap <Tab> <C-W><C-W>

"Fugitive map
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gm :diffget //2<CR>
nnoremap <leader>go :diffget //3<CR>
nnoremap <leader>gu :diffupdate<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :Glog -- % copen<CR>
"Shows the branch name for each version
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P


" Nerdtree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.git','\.DS_Store','\.pdf', '.beam', 'node_modules']
"let g:NERDTreeWinSize = 4
let NERDTreeHighlightCursorline = 1
let NERDTreeShowHidden=1

" JJ escape
inoremap jj <ESC>:wa<CR>

" Indentation
noremap <Leader>i gg=G

" Autoformat
map <Leader>f :Autoformat<CR>

" such very magic
:nnoremap / /\v
:cnoremap %s/ %s/\v

"Move between windows
nnoremap <Tab> <C-W><C-W>
" numbering
set relativenumber
set number "mi da il numero assuluto della linea in cui sono
" Toggle relative line numbers
let g:NumberToggleTrigger="<leader>r" "without this <C-n>(relative number) will conflict with nerdTree

"COLORSCHEME
"set t_ut=
set t_Co=256
syntax enable
colorscheme gruvbox 
set background=dark

set backspace=2   " Backspace deletes like most programs in insert mode
set nowritebackup

nnoremap <space> za

set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

"open vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

"NEW STUFF FROM A VIDEO TALK
set path+=**

