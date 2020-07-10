set autoindent
set smartindent
set mouse=a
color desert

set tabstop=2
set shiftwidth=2
set expandtab
set number
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

