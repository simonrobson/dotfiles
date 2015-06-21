call pathogen#infect()
set nocompatible                " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation

set gfn=Menlo\ Regular:h14
" set gfn=Monaco:h15
colorscheme desert
" set background=light
" colorscheme solarized

let mapleader = ","
inoremap jj <Esc>

" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
" set cursorline

set pastetoggle=<F2> " convenience when pasting lost of formatted text

set statusline=%<%f\ (%{&ft})\ %-4(%m%)
set statusline+=%{fugitive#statusline()}
" set statusline+=%=%-19(%3l,%02c%03V%)
" set statusline=%F%m%r%h%w\ 
" set statusline+=%{fugitive#statusline()}\    
" set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
" set statusline+=\ [line\ %l\/%L]          
" set statusline+=%{rvm#statusline()}  
"
set laststatus=2
"
set backupdir=~/.vim/_backup// " where to put backup files.
set directory=~/.vim/_temp// " where to put swap files.

" Make search more comfortable
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

set hidden                       " allow sending current buffer to background without saving
set wildmenu                     " enhanced tab completion in command mode
set ruler
" set relativenumber               " relative linenumbers
set number

set wildmenu
set wildmode=longest:list

" map leader w to vertical split and move to new window
nnoremap <leader>w <C-w>v<C-w>l

" ,ew to edit something from directory of current file in current window, etc
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Thanks to Gary B. https://www.destroyallsoftware.com/file-navigation-in-vim.html
" commandT convenience mappings
" Open files with <leader>f
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
" Open files, limited to the directory of the current file, with <leader>gf
" Uses the %% mapping found above.
map <leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>

" Unite
" let g:unite_source_history_yank_enable = 1
" call unite#filters#matcher_default#use(['matcher_fuzzy'])
" call unite#filters#sorter_default#use(['sorter_rank'])
" nnoremap <leader>f :<C-u>Unite -no-split -start-insert file_rec/async:!<cr>
" nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
" nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
" nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
" nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
" nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction


" edit or view files in current directory
map <leader>e :edit %%
map <leader>v :view %%

nnoremap <leader><leader> <c-^>

map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Shift-tab to insert a hard tab
imap <silent> <S-tab> <C-v><tab>

" Mainly for evaling clojure
nnoremap <C-e> :Eval<CR>
nnoremap <leader>fe :%Eval<CR>

" Vim turbux settings
map <leader>t <Plug>SendTestToTmux
map <leader>T <Plug>SendFocusedTestToTmux

" allow jsx syntax all over the place
let g:jsx_ext_required = 0

" Fold settings for vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_initial_foldlevel=1

""""""""""""""""""""""""""""""""""""""""
" For more convenient prose writing
""""""""""""""""""""""""""""""""""""""""

" Turn hard wrapped text into soft wrapped.
" This command will join all lines within a range that are not separated
" by empty lines. Automatic word wrap must be off (set fo-=a).
" Useful if you need to copy and paste into a word processor.
command! -range=% SoftWrap
            \ <line2>put _ |
            \ <line1>,<line2>g/.\+/ .;-/^$/ join |normal $x

" Next two courtesy of http://alols.github.io/2012/11/07/writing-prose-with-vim/
command! Prose inoremap <buffer> . .<C-G>u|
            \ inoremap <buffer> ! !<C-G>u|
            \ inoremap <buffer> ? ?<C-G>u|
            \ setlocal "spell spelllang=en
            \     nolist nowrap tw=74 fo=t1 nonu|
            \ augroup PROSE|
            \   autocmd InsertEnter <buffer> set fo+=a|
            \   autocmd InsertLeave <buffer> set fo-=a|
            \ augroup END

command! Code silent! iunmap <buffer> .|
            \ silent! iunmap <buffer> !|
            \ silent! iunmap <buffer> ?|
            \ setlocal nospell nolist nowrap
            \     tw=74 fo=tcq showbreak=… nu|
            \ silent! autocmd! PROSE * <buffer>

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

"""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
"""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

