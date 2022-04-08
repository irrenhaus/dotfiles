set nocompatible

" gruvbox
autocmd vimenter * ++nested colorscheme gruvbox

if (has("nvim"))
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

colorscheme gruvbox

" apparent fix that prevents bd from killing whole vim process when using
" NERDTree
" nnoremap \d :bp<cr>:bd #<cr>
noremap <leader>x :bp<cr>:bd #<cr>

" =====================================
" NERDTree stuff
" Auto start NERD tree when opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif

" Auto start NERD tree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}

" =====================================
" General stuff

" Use Unix as the standard file type
set ffs=unix,dos,mac

set hlsearch
autocmd FileType vim,lua,nginx,yaml set shiftwidth=2 softtabstop=2
autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0
set encoding=utf-8
set confirm
" if hidden is not set, TextEdit might fail.
" Some servers have issues with backup files, see #649
set hidden 

set nobackup
set nowb
set noswapfile
set nowritebackup

set title
set mouse=a
set shell=zsh
set exrc
set secure
set tabstop=4
set softtabstop=4
set shiftwidth=4
" set noexpandtab
set expandtab
set nrformats+=alpha
set signcolumn=yes
set shortmess+=c
set modeline          " enable modelines
set modelines=5
set cmdheight=2
set updatetime=300
set number
filetype on
filetype plugin indent on
syntax on
set autoindent
set smartindent
set equalalways       " make splits equal size
set cursorline
set noshowmode
set background=dark
set ruler
set colorcolumn=110

" Sets how many lines of history VIM has to remember
set history=1024

" Set to auto read when a file is changed from the outside
set autoread

" Word wrapping after 80 characters
set tw=80
set fo-=t
"set wrap

" Enable the wildmenu (better auto completion for files in command line)
set wildmenu
set wildmode=longest:full,full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" No annoying sound on errors
set noerrorbells

" For regular expressions turn magic on
set magic

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Open new split panes to right and bottom
set splitbelow
set splitright

" Automatically remove trailing whitespaces on save
" autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Automatically detect *.md files as Markdown files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Open new split panes to right and bottom
set splitbelow
set splitright

" Damn you Arduino!
au BufNewFile,BufRead *.ino set filetype=cpp

" Rust
au BufNewFile,BufRead *.rs set filetype=rust

" More powerfull backspace
set backspace=indent,eol,start

" persistent_undo
set undofile
set undolevels=1000
set undoreload=10000

" show matching bracket (briefly jump)
set showmatch
set matchtime=2 "0.2 seconds
set matchpairs+=<:>                                               " specially for html


" =====================================
" NVim CoC
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
  else
    set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" =====================================
" Airline
set laststatus=2 " Always display the statusline in all windows
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#fnametruncate = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#whitespace#enabled = 1
"let g:airline#extensions#promptline#snapshot_file = '~/.dotfiles/zsh/90-airline-theme.zsh'
let g:airline_theme='gruvbox'
let g:Powerline_symbols='fancy'
" Distinct background color is enough to discriminate the warning and
" error information.
let g:airline#extensions#ale#error_symbol = '•'
let g:airline#extensions#ale#warning_symbol = '•'


" =====================================
" MISC

" Don't conceal JSON syntax
set conceallevel=0
let g:vim_json_syntax_conceal = 0


" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" =====================================
" Key stuff
let mapleader=","

nnoremap <silent> <Space> :NERDTreeToggle<CR>
" toggle tagbar
" nnoremap <silent> <leader>tb :TagbarToggle<CR>
" inoremap ;; <Esc>
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy
" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" go to next buffer
nnoremap <silent> <leader>bn :bn<CR>
nnoremap <C-l> :bn<CR>

" go to previous buffer
nnoremap <silent> <leader>bp :bp<CR>

" https://github.com/neovim/neovim/issues/2048
nnoremap <C-h> :bp<CR>

" close buffer
nnoremap <silent> <leader>bd :Bdelete<CR>

nmap <Leader>// <Plug>NERDCommenterToggle
omap <Leader>// <Plug>NERDCommenterToggle
vmap <Leader>// <Plug>NERDCommenterToggle

" Map Up and Down keys to move one row instead of one line (wrapped lines
" stuff)
map <Down> gj
map <Up> gk

" Map Ctrl+Up and Ctrl+Down to scroll window
map <C-Down> <C-E>
map <C-Up> <C-Y>

" I want word movements on Ctrl + Arrows instread of WORD movements
map <C-Right> w
map <C-Left> b

nmap <Leader>q :nohlsearch<CR>

" Map Shift + Arrows to switch between windows
nmap <S-Up>    <C-W><Up>
nmap <S-Down>  <C-W><Down>
nmap <S-Left>  <C-W><Left>
nmap <S-Right> <C-W><Right>

" Open/Close foldings in normal mode with space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Tab changes
:nmap <Leader>t2 :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
:nmap <Leader>t4 :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
:nmap <Leader>t8 :set expandtab tabstop=8 shiftwidth=8 softtabstop=8<CR>

" See http://vim.wikia.com/wiki/Accessing_the_system_clipboard
" Visual mode: F7 to copy current selection to clipboard
vmap <F7> "+ygv"+y`>
" Visual Mode Ctrl-F7: Overwrite selection with clipboard cursor
vmap <C-F7> "+p`]
" F7: Paste clipboard after cursor
nmap <F7> "+gp
" F8: Tagbar toggle
nmap <F8> :TagbarToggle<CR>
" Shift-F7: Paste clipboard before cursor
nmap <S-F7> "+gP

" F9 : Toggle auto line wrapping
map <F9> :call ToggleTextWrap()<CR>
" F10: Highlight too long lines
map <F10> :call ToggleHighlightLongLines()<CR>
" F12:  Toggle line numbers
map <F12> :set nonumber!<CR>:IndentLinesToggle<CR>

nmap <Leader>tw :call StripTrailingWhitespaces()<CR>

" Shortcut for vim-ripgrep
nnoremap <space>/ :Rg 

""""" Helper function from http://amix.dk/vim/vimrc.html
" Visual mode: search & highlight current selection (* -> forward, # -> backward)
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    elseif a:direction == 'ug'
        execute "Unite grep:.::" . l:pattern
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Thanks to http://wtf.hijacked.us/wiki/index.php/Vim
" Global tracker var
let g:HighlightLongLines = 0 "set to 0 so we can run it to enable
" Function to toggle highlighting of lines longer than 80 character
" It also toggles textwidth to 80 so newlines are forced when typing
fu! ToggleHighlightLongLines()
   if(g:HighlightLongLines == 1)
           " Disable highlighting and textwidth
           highlight clear rightMargin
           set textwidth=0
           let g:HighlightLongLines = 0
   else
           " Enable highlighting and textwidth
           set textwidth=80
           highlight rightMargin ctermbg=LightRed guibg=LightRed
           match rightMargin /\%>81v/
           let g:HighlightLongLines = 1
   endif
endfunction

function! ToggleTextWrap()
    if &fo =~ 't'
        set fo-=t
    else
        set fo+=t
    endif
endfunction

function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
