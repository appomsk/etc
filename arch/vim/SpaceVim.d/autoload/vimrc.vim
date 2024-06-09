function! vimrc#after() abort
" {{{ Russification
let g:XkbSwitchEnabled = 1

" For vim layouts
" source ~/etc/conf/misc/vim/russian-utf8.vim

" As in emacs and C-^ always changed to alternative file
" alternative keyboard
inoremap <C-\> <C-^>

" insert mode and search in original language (english) at the beginning
set iminsert=0
set imsearch=0

" It's simpler
imap № #
imap ё `
imap Ё ~

" SPELL
" Словари для русского языка.
" mkdir -p ~/.vim/spell && 
" cd ~/.vim/spell && 
" wget http://ftp.vim.org/vim/runtime/spell/ru.utf-8.sug &&
" wget http://ftp.vim.org/vim/runtime/spell/ru.utf-8.spl

"включить проверку орфографии
set spelllang=ru,en_us
set nospell
inoremap <F9> <ESC>:setlocal spell!<CR>
noremap <F9> :setlocal spell!<CR>

" ???
nnoremap <C-_> :<C-U>setlocal <C-R>=&spell?"nospell":"spell"<CR><CR>
vnoremap <C-_> <Esc>:setlocal <C-R>=&spell?"nospell":"spell"<CR><CR>gv
inoremap <C-_> <C-O>:setlocal <C-R>=&spell?"nospell":"spell"<CR><CR>
cnoremap <C-_> <C-C>:setlocal <C-R>=&spell?"nospell":"spell"<CR><CR>
onoremap <C-_> <C-C>:setlocal <C-R>=&spell?"nospell":"spell"<CR><CR>

" for menu, etc.
lang en_US.utf8

" }}} Russification

call SpaceVim#custom#SPC('nnoremap', ['f', 'v', 'c'], 
      \  'e ~/.SpaceVim.d/autoload/vimrc.vim', 'open my Custom vimrc', 1)

endfunction

function! vimrc#after() abort

let g:delimitMate_autoclose = 0

" MY:
set cdpath=,.,~/
set clipboard=unnamed,unnamedplus
set formatoptions=tcqj
let &keywordprg=":Man"

" skip startup message
set shortmess+=I

" TODO Maybe - autowriteall, undofile, undolevels, undoreload, nohidden
set autowrite		" no dull questions

" raise a dialogue asking if you wish to save changed files.
set confirm

set textwidth=72
set ignorecase
set smartcase

" TODO with plugin: completion in insert mode 
set completeopt=menu,menuone,noselect

" For all files -- it doesn't work sometimes because of sleuth plugin 
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround

" fix
set nonumber

"" Mappings
" Hm... Any minuses? 
inoremap   <C-c>   <Esc>
inoremap   <M-c>   <Esc>

" Fix: russian "C"
inoremap   <C-с>   <Esc>
inoremap   <M-с>   <Esc>
cnoremap   <C-с>   <C-c>
noremap    <C-с>   <C-c>
cnoremap   <M-с>   <C-c>
noremap    <M-с>   <C-c>

inoremap <M-k> <C-k>
inoremap <C-k> <C-o>D

" Quick formatting
nnoremap <M-q> gqap

" the same as in the normal mode
inoremap <C-^> <Esc><C-^>

" CR in console 
noremap <CR> i<CR><ESC>
noremap <M-CR> i<CR>

" common in browsers
noremap <leader><Space> <C-f>
noremap <BS> <C-B>

" TODO Check powerman/vim-plugin-viewdoc
noremap <C-Up> <C-Y>
noremap <C-Down> <C-E>
noremap <M-Down> <C-]>
noremap <M-Left> <C-o>
noremap <M-Right> <C-i>

" much better for long wrapped lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg=@"<CR>gvs<C-R>=current_reg<CR><Esc>

" TODO which-keys
nnoremap <silent> <leader>ve :edit $MYVIMRC<CR>
nnoremap <silent> <leader>vs :w<CR>:source $MYVIMRC<CR>

" Save file
noremap <silent> <C-s> :w<CR><ESC>
map! <C-s> <ESC><C-s>
map  <F2> <C-s>
map! <F2> <C-s>

" examples
noremap  <F5> :!./%<CR>
map! <F5> <ESC><F5>
inoremap <silent> <F4> <ESC>:set number! \| set cursorline! \|
    \ execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>a

endfunction

function! vimrc#before() abort
" pass
let g:XkbSwitchEnabled = 1
endfunction

