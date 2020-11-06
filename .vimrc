set backup
set backupdir=/home/$USER/.vim/backup
set directory=/home/$USER/.vim/tmp
colors delek
match ErrorMsg '\%>80v.\+'
match ErrorMsg /\s\+\%#\@<!$/
filetype plugin indent on
" set foldmethod=syntax
set tabstop=4
set shiftwidth=4
set expandtab
hi Normal ctermbg=none
set modeline
set modelines=5

augroup Docker
    au BufNewFile Dockerfile exec "0r ~/.vim/skel/Docker" | %s/HELLO/\=expand("%:r")/ge
augroup end

augroup Scripts
    au BufNewFile *.sh,*.pl,*.py exec "0r ~/.vim/skel/skel.".expand("%:e") | %s/HELLO/\=expand("%:r")/ge
augroup end

augroup CPP
    au BufNewFile *.c,*.cpp,*.h,*.hpp exec "0r ~/.vim/skel/skel.".expand("%:e") | %s/HELLO/\=expand("%:r")/ge
augroup end

augroup Java
    au BufNewFile *.java 0r ~/.vim/skel/skel.java | %s/CLASSNAME/\=expand("%:r")/ge
augroup end

autocmd BufWritePre README.md %s/\s\+$//e
autocmd BufWritePre *.py %s/\s\+$//e
autocmd BufWritePre *.pl %s/\s\+$//e
autocmd BufWritePre *.yaml %s/\s\+$//e
autocmd BufWritePre *.sls %s/\s\+$//e
autocmd BufWritePre *.properties %s/\s\+$//e
autocmd BufWritePre *.sql %s/\s\+$//e
autocmd BufWritePre *.cql %s/\s\+$//e
autocmd BufWritePre *Jenkinsfile* %s/\s\+$//e
autocmd BufWritePre *.gradle %s/\s\+$//e
autocmd BufWritePre *.xml %s/\s\+$//e
set viminfo+=<256

nnoremap <F9> :!%:p<Enter>
let mapleader = "-"
nnoremap <leader>r :!%:p

au BufRead,BufNewFile *.md setlocal textwidth=80

