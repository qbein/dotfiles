execute pathogen#infect()

set hidden

syntax on

colorscheme abra

set autoindent
set copyindent
set ruler

set tabstop=2
" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=2
" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab
" always uses spaces instead of tab characters
set expandtab


" size of an "indent"
set shiftwidth=2
set shiftround
set showmatch
set ignorecase " ignore case when searching
set hlsearch   " hightlight search term
set incsearch  " show search matches while typing
set number

set undolevels=1000
set history=1000
set title

set nobackup
set noswapfile

autocmd Syntax * syn match Todo /\s\+$\| \+\ze\t/

fun! TrimWhiteSpace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,javascript,ruby,python autocmd BufWritePre <buffer> :call TrimWhiteSpace()

set runtimepath^=~/.vim/bundle/ctrlp.vim


