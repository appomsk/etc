" vim: fdm=marker

" for plugins + undo + something else. For backups

let VIMDATA = $LIB . '/vim'

" for undos (formats nvim and vim for undofiles are incompatible
let VIMUNDO = VIMDATA . (has('nvim') ? '/nvim-undo' : '/vim-undo')

" for vim launched with -u option
set nocompatible

" Heredoc highlighting
let g:vimsyn_embed = 'l'  " support embedded lua, python and ruby
" NOPE It doesn't work.
" See: https://stackoverflow.com/questions/74448018/neovim-broken-syntax-highlighting-after-heredoc-lua-eof-in-vimscript
" from 10.22 to 06.24 the problem is not gone
" Workaround from the comment: reverting to v0.7.2 lua syntax:
" !sudo curl -sS https://raw.githubusercontent.com/neovim/neovim/v0.7.2/runtime/syntax/lua.vim -o $VIMRUNTIME/syntax/lua.vim 
" sudo curl -sS \
" https://raw.githubusercontent.com/neovim/neovim/v0.7.2/runtime/syntax/lua.vim \
" -o /usr/local/share/nvim/runtime/syntax/lua.vim 
"
" It does not work with appimage

" {{{ Плагины 

call plug#begin(VIMDATA . '/plugged')

if has('nvim')
    Plug 'https://github.com/tpope/vim-sensible', { 'on': [] }
    Plug 'https://github.com/nvim-tree/nvim-web-devicons'
    Plug 'https://github.com/nvim-lualine/lualine.nvim'
    Plug 'https://github.com/nanozuki/tabby.nvim'
    Plug 'itchyny/lightline.vim', { 'on': [] }
    Plug 'https://github.com/folke/which-key.nvim'
    Plug 'https://github.com/ervandew/supertab', { 'on': [] }
else
    Plug 'https://github.com/tpope/vim-sensible'
    Plug 'https://github.com/nvim-tree/nvim-web-devicons', { 'on': [] }
    Plug 'https://github.com/nvim-lualine/lualine.nvim', { 'on': [] }
    Plug 'https://github.com/nanozuki/tabby.nvim', { 'on': [] }
    Plug 'itchyny/lightline.vim'
    Plug 'https://github.com/folke/which-key.nvim', { 'on': [] }
    Plug 'https://github.com/ervandew/supertab'
endif
Plug 'https://github.com/sainnhe/gruvbox-material'
Plug 'https://github.com/tpope/vim-rsi'
Plug 'https://github.com/lyokha/vim-xkbswitch'
Plug 'https://github.com/godlygeek/tabular'
Plug 'https://github.com/tpope/vim-sleuth'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/christoomey/vim-tmux-navigator'
Plug 'https://github.com/preservim/vimux'
Plug 'https://github.com/tmux-plugins/vim-tmux'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/dahu/vim-fanfingtastic'
Plug 'https://github.com/lifepillar/vim-cheat40'

" {{{ Plugins Check

" Plug 'https://github.com/echasnovski/mini.nvim'

" Plug 'https://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Plug 'https://github.com/numToStr/Comment.nvim'

" Git
" Plug 'https://github.com/airblade/vim-gitgutter'
" Plug 'https://github.com/lewis6991/gitsigns.nvim'

" }}}

call plug#end()

" }}}

" Истории

" {{{ Sensible

" +Plug -vim https://github.com/tpope/vim-sensible
" {{{2 Neovim defaults
" Neovim has set these as default
if !has('nvim')

  set nocompatible

  syntax on                      " Syntax highlighting
  filetype plugin indent on      " Automatically detect file types
  set autoindent                 " Indent at the same level of the previous line
  set autoread                   " Automatically read a file changed outside of vim
  set backspace=indent,eol,start " Backspace for dummies
  set complete-=i                " Exclude files completion
  set display=lastline           " Show as much as possible of the last line
  set encoding=utf-8             " Set default encoding
  set history=10000              " Maximum history record
  set hlsearch                   " Highlight search terms
  set incsearch                  " Find as you type search
  set laststatus=2               " Always show status line
  set mouse=a                    " Automatically enable mouse usage
  set smarttab                   " Smart tab
  set ttyfast                    " Faster redrawing
  set viminfo+=!                 " Viminfo include !
  set wildmenu                   " Show list instead of just completing

  set ttymouse=xterm2

endif

" 2}}}

" }}}
" {{{ Colors

" See top/trending here: https://vimcolorschemes.com/

" +Plug 'https://github.com/sainnhe/gruvbox-material'
set background=dark
colorscheme gruvbox-material

" no need for neovim
set termguicolors

" }}}
" {{{ Statusline

" {{{2 Nvim
if has("nvim") 

" +Plug --nvim 'https://github.com/nvim-tree/nvim-web-devicons'
" +Plug --nvim 'https://github.com/nvim-lualine/lualine.nvim'
" +Plug 'https://github.com/nanozuki/tabby.nvim'

lua << EOF
  local custom = require'lualine.themes.gruvbox'
  -- custom.command.a.bg = custom.normal.a.bg
  -- custom.visual.a.bg = custom.insert.a.bg
  -- custom.insert.a.bg = '#d8caac'
  require('lualine').setup {
    options = {
      theme = custom,
      component_separators = '',
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
      lualine_b = { 'filename', 'branch' },
      lualine_c = {
        '%=', --[[ add your center compoentnts here in place of this comment ]]
      },
      lualine_x = {},
      lualine_y = { 'filetype', 'progress' },
      lualine_z = {
        { 'location', separator = { right = '' }, left_padding = 2 },
      },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
  --  tabline = {},
    extensions = {},
  }

  local function bubble()
    local util = require('tabby.util')

    local hl_tabline_fill = util.extract_nvim_hl('lualine_c_normal')
    local hl_tabline = util.extract_nvim_hl('lualine_b_normal')
    local hl_tabline_sel = util.extract_nvim_hl('lualine_a_normal')

    local function tab_label(tabid, active)
      local icon = active and ' ' or ' '
      local number = vim.api.nvim_tabpage_get_number(tabid)
      local name = util.get_tab_name(tabid)
      return string.format(' %s %d: %s ', icon, number, name)
    end

    local presets = {
      hl = 'lualine_b_normal',
      layout = 'tab_only',
      head = {
        { '  ', },
        { ' '  , },
      },
      active_tab = {
        label = function(tabid)
        return {
          tab_label(tabid, true),
          hl = { fg = hl_tabline_sel.fg, bg = hl_tabline_sel.bg },
        }
        end,
        left_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
        right_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
      },
      inactive_tab = {
        label = function(tabid)
        return {
          tab_label(tabid, false),
          hl = { fg = hl_tabline.fg, bg = hl_tabline_fill.bg },
        }
        end,
        left_sep = { ' ', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        right_sep = { ' ', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
      },
    }
    return presets  
  end -- bubble

  require('tabby').setup({
    tabline = bubble(),
  })
EOF

" }}}
" {{{2 Vim

" Lightline
else 

  let g:LL#color = "apprentice"

  set ruler
  set laststatus=2
  "set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)

  " with Nerd fonts
  " for using virtual chars (utf-8) in column count
  let g:lightline = {
      \ 'colorscheme' : g:LL#color,
      \ 'component': {
      \   'lineinfo': '%3l:%-2v',
      \ },
      \ 'separator':    { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
  \ }

  " No nerd fonts
  " let g:lightline = {
  "     \ 'colorscheme' : g:LL#color,
  "     \ 'component': {
  "     \   'lineinfo': '%3l:%-2v',
  "     \ },
  " \ }
    " pass
  endif " has("nvim")

" }}}

" }}}
" {{{ Cursor

if !has('nvim')
augroup cursor 
    au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
    au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' | 
    \   silent execute '!echo -ne "\e[6 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[4 q"' | redraw! |
    \ endif
    au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
augroup END
endif

" }}}
" {{{ Main keys

let mapleader=" "
" let g:maplocalleader=

inoremap   <C-c>   <Esc>
inoremap   <C-c><C-c> <C-c>
" In zsh only M-c
inoremap   c   <Esc>
cnoremap   c   <ESC>
inoremap   <C-c><C-c> <C-c>
noremap    c   <Esc>
inoremap   <C-c><C-c> <C-c>

" Fix: russian "C"
" inoremap   <C-с>   <Esc>
inoremap   с   <Esc>
cnoremap   с   <Esc>
noremap    с   <Esc>
cnoremap   <C-с>   <Esc>
noremap    <C-с>   <Esc>

" }}}
" {{{ Emacs keys

" +Plug 'https://github.com/tpope/vim-rsi'

inoremap <C-k> <C-o>D
" for digraphs (<M-k> for tmux navigation)
inoremap <M-K> <C-k>

" }}}
" {{{ Mappings

" {{{2 Which-key

if has('nvim')
  " which-key recomendations
  set timeout
  set timeoutlen=300

  lua <<EOF
  require("which-key").setup{
    
  }

EOF

endif

" }}}
" {{{2 Tweaks

if !has('nvim')
    " From Neovim
    nnoremap Y y$
    nnoremap <C-L> <Cmd>nohlsearch<Bar>diffupdate<CR><C-L>
    inoremap <C-U> <C-G>u<C-U>
    inoremap <C-W> <C-G>u<C-W>
    noremap Q :execute 'normal! @'.g:qreg<cr>
endif

" Fix main operators. Y is already fixed. 
" Try - BAD IDEA but let's be there - for memory
" noremap V v$
" noremap vv 0V

" S should do something else - cc is simpler and do the right thing
" TODO for folds?
noremap S <nop>

" Quick formatting
nnoremap q gqap

" the same as in the normal mode
inoremap <C-^> <Esc><C-^>
" :h i_CTRL-^
inoremap <C-\> <C-^>

" CR in console 
noremap <CR> i<CR><ESC>

" common in browsers
noremap <leader><Space> <C-f>
" noremap <M-BS> <C-f>
noremap <BS> <C-b>

" Hmm... TODO Check powerman/vim-plugin-viewdoc
noremap <C-Up> <C-Y>
noremap <C-Down> <C-E>
" noremap <M-Down> <C-]>
" noremap <M-Left> <C-o>
" noremap <M-Right> <C-i>

" much better for long wrapped lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg=@"<CR>gvs<C-R>=current_reg<CR><Esc>

" Add undo break-points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ; ;<c-g>u

" Save file
noremap <silent> <C-s> :w<CR><ESC>
map! <C-s> <ESC><C-s>

" vim-admin-related mappings

" MYVIMRC is not set if vim started with -u option 
nnoremap <silent> <leader>ve :edit $MYVIMRC<CR>
nnoremap <silent> <leader>vs :w<CR>:source $MYVIMRC<CR>

" }}}
" {{{2 Examples

noremap  <F5> :!./%<CR>
map! <F5> <ESC><F5>
noremap <silent> <F4> <ESC>:set number! \| set cursorline! \|
    \ execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>
map! <F4> <ESC><F4>i

" }}}

" }}}
" {{{ Rus

set fileencodings=utf-8,cp1251,latin1

" For vim layouts TODO - mv in .vim?
source $ETC/apps/vim/russian-utf8.vim

" As in emacs and C-^ always changed to alternative file
" done in keymappings
" alternative keyboard
" inoremap <C-\> <C-^>

" insert mode and search in original language (english) at the beginning
set iminsert=0
set imsearch=0

" These keys are more useful
imap № #
imap ё `
imap Ё ~

" To compile:
" git clone https://github.com/grwlf/xkb-switch
let g:XkbSwitchEnabled = 1 
" Manjaro
if !empty(glob("/usr/lib/libxkbswitch.so"))
    let g:XkbSwitchLib = '/usr/lib/libxkbswitch.so'
endif
" OpenSUSE
if !empty(glob("/usr/lib64/libxkbswitch.so.1"))
    let g:XkbSwitchLib = '/usr/lib64/libxkbswitch.so.1'
endif
if !empty(glob("/usr/local/lib/libxkbswitch.so"))
    let g:XkbSwitchLib = '/usr/local/lib/libxkbswitch.so'
endif

" SPELL
" Словари для русского языка.
" mkdir -p VIMDATA/spell && 
" cd VIMDATA/spell && 
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

" }}}
" {{{ Editor

" {{{2 User Interface

" skip startup message
set shortmess+=I

" TODO with plugin: completion in insert mode
set completeopt=menu,menuone,noselect

" Always show the signcolumn, otherwise it would shift the text each time
set signcolumn=yes

" raise a dialogue asking if you wish to save changed files.
set confirm

set wildmode=list:longest,full

set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶

" TODO Check anothers?
" Allow backspace and cursor keys to cross line boundaries
set whichwrap+=<,>,h,l

set textwidth=72

" only if more than one
set showtabline=1

" Show partial commands in status line 
" and Selected characters/lines in visual mode
set showcmd        
" Show current mode in command-line
set showmode
" Always report changed lines
set report=0
" Avoid the pop up menu occupying the whole screen
set pumheight=20

" }}}
" {{{2 Misc tweaks

set cdpath=,.,~/
set clipboard=unnamed,unnamedplus
set formatoptions=tcqj
let &keywordprg=":Man"

" }}}
" {{{2 Search

set ignorecase
set smartcase

" }}}
" {{{2 Indent

set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround

" }}}
" {{{2 No backups

" TRY. Backups
" Справедливое замечание в инете o свапах - может быть помогли раз пять, но
" раздражали раз тысяч много

set autowriteall
augroup AUTOSAVE
  au!
  autocmd InsertLeave,TextChanged,FocusLost * 
    \ if filewritable(expand('%')) && !&readonly | silent! update! | endif
augroup END

set nobackup noswapfile nowritebackup     " disable backup/swap files
set undofile undolevels=9999              " undo options

if !isdirectory(expand(VIMUNDO))
  call mkdir(expand(VIMUNDO), "p")
endif
let &undodir = VIMUNDO

" }}}
" {{{2 Goods

" Tabularize
" +Plug 'https://github.com/godlygeek/tabular'
" Detect tabstop and shiftwidth automatically
" +Plug 'https://github.com/tpope/vim-sleuth'
" TODO check clever-f.vim or https://github.com/justinmk/vim-sneak
" (BETTER?)
" Find a char, across lines
" +Plug 'https://github.com/dahu/vim-fanfingtastic'

" +Plug 'https://github.com/tpope/vim-repeat'

" +Plug 'https://github.com/tpope/vim-commentary'

" +Plug 'https://github.com/tpope/vim-surround'

" CHECK
" Plug 'https://github.com/dhruvasagar/vim-table-mode'
" Plug 'https://github.com/tpope/vim-speeddating'
" https://github.com/ntpeters/vim-better-whitespace
" https://github.com/tpope/vim-obsession vs https://github.com/thaerkh/vim-workspace

" }}}
" {{{ TODO to check 
" if default - any length saves "-remove nohighlighting, only remember
" the last 10 files, contents of registres (up to 1000 lines) will be
" remembered, the last 10 search commands, filemarks stored (remember '0),
" path for viminfo. No global variables, restore the buffer list, no 
" specific number of the command-line history (see option history - 100)
set viminfo=h,'10,<1000,/10,f1,n

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif
" }}}

" }}}
" {{{ FZF

" +Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" +Plug 'junegunn/fzf.vim'

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Another 
" nnoremap <silent> <Leader>b :Buffers<CR>
" nnoremap <silent> <C-f> :Files<CR>
" nnoremap <silent> <Leader>f :Rg<CR>
" nnoremap <silent> <Leader>/ :BLines<CR>
" nnoremap <silent> <Leader>' :Marks<CR>
" nnoremap <silent> <Leader>g :Commits<CR>
" nnoremap <silent> <Leader>H :Helptags<CR>
" nnoremap <silent> <Leader>hh :History<CR>
" nnoremap <silent> <Leader>h: :History:<CR>
" nnoremap <silent> <Leader>h/ :History/<CR>

" }}}
" {{{ Tmux

" to edit .tmux.conf 
" +Plug 'https://github.com/tmux-plugins/vim-tmux'

" +Plug 'https://github.com/christoomey/vim-tmux-navigator'
" Ctrl-H,J,K,L But not for me. Change to M-...

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> h :<C-U>TmuxNavigateLeft<cr>
nnoremap <silent> j :<C-U>TmuxNavigateDown<cr>
nnoremap <silent> k :<C-U>TmuxNavigateUp<cr>
nnoremap <silent> l :<C-U>TmuxNavigateRight<cr>
nnoremap <silent> \ :<C-U>TmuxNavigatePrevious<cr>

" Prompt for a command to run
map <Leader>tp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>tl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <Leader>ti :VimuxInspectRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
map <Leader>tq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
map <Leader>tx :VimuxInterruptRunner<CR>

" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>tz :call VimuxZoomRunner()<CR>

" TODO It doesn't work because of tmux changes after 2.2
" If text is selected, save it in the v buffer and send that buffer it to tmux
function! VimuxSlime()
call VimuxSendText(@v)
endfunction

vmap <Leader>ts "vy :call VimuxSlime()<CR>


" Select current paragraph and send it to tmux

nmap <Leader>ts vip<Leader>ts<CR>

" TODO slime-like
" Plug 'https://github.com/preservim/vimux'

" }}}
" {{{ Devel

"if has('nvim')
"" Treesitter
"lua <<EOF
"require'nvim-treesitter.configs'.setup {
"  ensure_installed = { "vim", "lua", "bash", "markdown", },
"
"  sync_install = false,
"  auto_install = true,
"  highlight = {
"    enable = true,
"  },
"}
"EOF
"endif

" }}}
" {{{ TODO File Explorer NetRW/FZF/Tmux panel?

" I for help bunner
" F1 by default but it for quake-terminal
autocmd filetype netrw noremap <buffer> <leader>h :help netrw-quickhelp<CR>
" NetRW hide hidden files
let ghregex='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide=ghregex

" }}}
" {{{ File Type Setting

" TODO
" this is original markdown feature

let g:markdown_fenced_languages = ['python', 'lua',]

augroup filetype_vim
  autocmd!
  autocmd filetype vim setlocal foldmethod=marker
augroup end

autocmd filetype sh set iskeyword+=$

" for zshrc
autocmd FileType zsh setlocal foldmethod=marker

" }}}
" GUI {{{

" has('gui_running') is now supported in Nvim 0.9
if has('gui_running')

    set guicursor=a:blinkwait0,a:

    " set guifont=Consolas:h11:cRUSSIAN
    " set guifont=Consolas\ 12
    set guifont=UbuntuSansMono\ NerdFont\ 12

    set guioptions-=T
    set guioptions-=m
    set guioptions-=r

    inoremap <C-S-v> <C-o>"+gP

    " TODO check behaviour and how to do it in terminal?
    " visual copying copy to clipboard too
    set guioptions+=a

endif

" }}}
" {{{ Lua

if has('nvim')
  " lua require 'basic'
endif

" }}}
