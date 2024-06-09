colorscheme nord
" =================== MENU FOR WINDOWS GVIM ====================
" in windows popup-menu (tooltips) are shown in cp1251, but in menu_ru.utf-8
" they are in utf. So just comment them in this file.
" source $VIMRUNTIME/delmenu.vim
" source $VIMRUNTIME/lang/menu_ru.utf-8.vim
" source $VIMRUNTIME/menu.vim

set guicursor=a:blinkwait0,a:
" set guifont=Consolas:h11:cRUSSIAN
" set guifont=Liberation\ Mono\ 10
" set guifont=UbuntuMono\ NF\ 15
set guifont=Consolas\ 12
" set guifont=Ubuntu\ Mono\ derivative\ PowerLine\ 11 

" tabs
set showtabline=1
map <C-Tab> :tabnext<CR>
imap <C-Tab> <ESC><C-Tab>

set guioptions-=T
set guioptions-=m
set guioptions-=r

inoremap <C-S-v> <C-o>"+gP
