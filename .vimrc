set backup
set backupdir=/home/mjablonski/.vim/backup
set directory=/home/mjablonski/.vim/tmp
colors darkblue
match ErrorMsg '\%>80v.\+'
match ErrorMsg /\s\+\%#\@<!$/
filetype plugin indent on
" set foldmethod=syntax
set tabstop=4
set shiftwidth=4
set expandtab
hi Normal ctermbg=none

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
