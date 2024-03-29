"  _   _ _____ _____     _____ __  __
" | \ | | ____/ _ \ \   / /_ _|  \/  |
" |  \| |  _|| | | \ \ / / | || |\/| |
" | |\  | |__| |_| |\ V /  | || |  | |
" |_| \_|_____\___/  \_/  |___|_|  |_|

" This line makes pacman-installed global Arch Linux vim packages work.
source /usr/share/nvim/archlinux.vim

"=================================="
"       Begin Plugins Section      "
"=================================="

call plug#begin('~/.local/share/nvim/plugged')
    " plugins go here in the form of: Plug 'vim-airline/vim-airline'
    " so it's Plug 'githubauthor/nameofgithub'
    " or any git url such as Plug 'https://github.com/junegunn/vim-github-dashboard.git
    " then save the file, reload vim, and run :PlugInstall
    " :PlugUpgrade to upgrame vimplug
    " :PlugUpdate updates all installed plugins
    " uninstall by removing the line, save and quit, and then :PlugClean
    " - [ ] see github for how to load plugins only on particular files or when
    "   particular conditions are met
    " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "
        "{{{ ENHANCEMENTS }}}
            Plug '907th/vim-auto-save'
            "Plug 'tpope/vim-surround' " T-Pope / Change surrounding tags, characters, quotes
            Plug 'unblevable/quick-scope' " f command highlighting
	    "test with ":StartupTime ~/foo.vim 100 , will test with opening the file 100 times
            Plug 'tweekmonster/startuptime.vim' 
        "{{{ MARKUP }}}
	    Plug 'https://gitlab.com/dbeniamine/todo.txt-vim.git' "adds todo.txt support to vim
            Plug '/home/connor/.local/share/nvim/plugged/vimwiki'
	    Plug 'godlygeek/tabular'
	    Plug 'danro/rename.vim'
	    Plug 'dkarter/bullets.vim' "auto insert bullet on newline
	    Plug 'Konfekt/FastFold'
	    "Plug 'plasticboy/vim-markdown'
	    "Plug 'masukomi/vim-markdown-folding'
	    Plug 'zhimsel/vim-stay' "vim persistent folds, bugged when used
	    "with vim-markdown-holding
	"{{{ SYNTAX HIGHLIGHTING }}}
	    Plug 'RRethy/vim-hexokinase'
	"{{{ THEMES }}}
	    Plug 'tomasiser/vim-code-dark' "codedark
	    Plug 'ayu-theme/ayu-vim' "ayu , let ayucolor=dark|mirage|light
	    Plug 'liuchengxu/space-vim-theme' "space_vim_theme , set background=dark|light
	    Plug 'laggardkernel/vim-one' "one , set background=dark|light must be done after setting the theme
	    "Plug 'ishan9299/modus-theme-vim' "this is lua, so you'll need to port to lua before using it "call with modus-operandi and modus-vivendi
	    Plug '/home/connor/.local/share/nvim/plugged/vim-vividchalk' "vividchalk , cant get line numbers
	    "to match
	    Plug 'dracula/vim'
	    Plug 'lifepillar/vim-colortemplate'
	    

call plug#end()

" startup options
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification
let g:auto_save_events = ["InsertLeave", "TextChanged"] " update when you enter and leave insert mode
"let g:auto_save_events = ["CursorHold", "CursorHoldI"] " update according to the updatetime interval
"set updatetime=2000 " in milliseconds

" basic settings
set undofile "undo history across close and open in a file
set autoread "update file when contents changed

":set number relativenumber "hybrid/relative line numbers
:set number

" color scheme
set t_Co=256
"let g:one_allow_italics = 1
"let g:one_dark_syntax_bg='#000000'
colorscheme vividchalk
"let ayucolor="dark"
"set background=dark


" autocmd
"autocmd BufWritePost /home/connor/.config/espanso/default.yml !/home/connor/bin/res
"autocmd BufWritePost /home/connor/.config/spectrwm/baraction.sh !/home/connor/bin/refbar
"autocmd BufWritePost /home/connor/.confic/Xresources/Xresources !xrdb ~/.config/Xresources/Xresources
"autocmd VimLeave /home/connor/.local/config_sync/clip.md !xclip -r -selection clipboard -i /home/connor/.local/config_sync/clip.md ; ~/bin/clip3.sh &
autocmd BufNewFile,Filetype markdown setlocal tabstop=4 shiftwidth=4 expandtab
"autocmd VimLeave /etc/** !echo $(pass sysadmin/laptop-password) | sudo alacritty -e /home/connor/.local/dotfiles/shared/system_scripts/nopath/vim-etckeeper-update.sh
"autocmd VimLeave /dev/shm/pass** /home/connor/.local/dotfiles_secret/shared/system_scripts/nopath/pass-git-update.sh
"autocmd BufReadPre /home/connor/dox/notes/mind/daily_notes/* !/home/connor/.local/dotfiles/shared/system_scripts/nopath/cron/vim-fix-daily-note.sh &

" Use system clipboard
set clipboard+=unnamedplus

" sets
:set ignorecase
:set nohlsearch
:set linebreak
"nnoremap j :normal! gj<CR>
"nnoremap gj :normal! j<CR>
"nnoremap k :normal! gk<CR>
"nnoremap gk :normal! k<CR>

" keymaps
let mapleader = ']'
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$
noremap <Leader>rm :!trash-put "%"
noremap <Leader> :!mv "%"

" spell check
set nospell
set spelllang=en
set spellfile=/home/connor/sync/config/en.utf-8.add

" create backup files in cache directory
set backupdir=~/.cache/nvim,. 
set dir=~/.cache/nvim//,.


" \w toggles wrap
"noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    s: Does your network need the attention of a  : Does your network need the attention of a  : Does your network need the attention of a  : Does your network need the attention of a  : Does your network need the attention of a  etlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction

" Alias replace all to S
nnoremap S :%s//gI<Left><Left><Left>

" Alias write and quit to Q
"nnoremap <leader>q :wq<CR>
"nnoremap <leader>w :w<CR>

" Remove trailing whitespace on save
"autocmd BufWritePre * %s/\s\+$//e

" CUSTOM KEYBINDINGS
"
" normal mode change case
"normal mode toggle single character case
nmap <F7> g~l
"Normal mode toggle full word case
nmap <F8> mzg~iw`z
" insert mode toggle full word case
imap <F8> _<Esc>mzi<S-Right><C-o>b<C-o>g~iw<C-o>`z<Del>
imap <S-F8> _<Esc>mzi<S-Right><C-o>b<C-o>gUiw<C-o>`z<Del>
" Map Ctrl-Backspace to delete the previous word in insert mode.
:imap <C-H> <C-W>
" map Ctrl-Delete to delete word ahead in insert mode
imap <C-DEL> <ESC>ldei
imap <F19> <ESC>ldei
" change word comma is already something else, so likely change?
"nmap , ciw
nmap Y y$
nmap <Alt>p o<ESC>p
nmap '' ``zz
nmap <Tab> za
"
" plugin settings

" markdown folding
"set foldexpr=NestedMarkdownFolds()
":set foldtext='\ '.foldtext()
"let g:markdown_fold_override_foldtext=0
"autocmd FileType vimwiki set foldexpr=NestedMarkdownFolds()
"autocmd FileType vimwiki nmap <Tab> za
"set viewoptions=cursor,folds,slash,unix "for vim-stay
"let g:fastfold_savehook = 0 "for vim fastfold not update on save

" 
" Vim Quickscope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
"highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
"highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
"
"Vim Hexokinase
set termguicolors
let g:Hexokinase_highlighters = ['backgroundfull']

"=================================="
"             VIM WIKI             "
"=================================="
    " ~~~~~ Ensure files are read as what I want in vimwiki:
        let g:vimwiki_global_ext = 0
        let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'} "commented out because I want wiki style links in vimwiki syntax
        let g:vimwiki_root = '~/dox/notes'
"change 'field' 2 for **default** for vimwiki syntax and **markdown** for markdown syntax
        let g:vimwiki_list = [
            \{'path': '~/dox/notes', 'syntax': 'markdown', 'ext': '.md'},
            \]
