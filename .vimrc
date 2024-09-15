" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source ~/.vim/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Set the colorscheme here.
colorscheme tokyonight-night

" Set <space> as the leader key
"  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
let mapleader = ' '
let maplocalleader = ' '

" [[ Setting options ]]

" Make line numbers default
set number
" Show relative line number in front of each line
set relativenumber

" use spaces when <Tab> is inserted
set expandtab
" number of spaces to use for (auto)indent step
set shiftwidth=4
" number of spaces that <Tab> uses while editing
set softtabstop=4
" smart autoindenting for C programs
set smartindent

" maximum width of text that is being inserted
"set textwidth=100
" columns to highlight
set colorcolumn=101

" Enable mouse mode, can be useful for resizing splits for example!
set mouse=a

" Don't show the mode, since it's already in the status line
"set noshowmode

" Sync clipboard between OS and Neovim.
"  Schedule the setting after `UiEnter` because it can increase startup-time.
"  Remove this option if you want your OS clipboard to remain independent.
"  See `:help 'clipboard'`
"set clipboard=unnamedplus

" Enable break indent
set breakindent

" Save undo history
set noundofile

" Case-insensitive searching UNLESS \C or one or more capital letters in the search term
set ignorecase
set smartcase

" Keep signcolumn on by default
"set signcolumn=yes

" Decrease update time
"set updatetime=250

" Decrease mapped sequence wait time
"set timeoutlen=300

" Configure how new splits should be opened
set splitright
set splitbelow

" Sets how neovim will display certain whitespace characters in the editor.
set list
set listchars=tab:»\ ,space:·,eol:¬,nbsp:␣

" Preview substitutions live, as you type!
"set inccommand=split

" Show which line your cursor is on
set cursorline

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=10

" if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
" instead raise a dialog asking if you wish to save the current file(s)
" See `:help 'confirm'`
"set confirm

" Enable spell checking
set spell
" Language(s) to do spell checking for
set spelllang=en_us,de_de,ru_ru

" take indent for new line from previous line
set autoindent

" "dark" or "light", used for highlight colors
set background=dark

" keep backup file after overwriting a file
set nobackup

" two spaces after a period with a join command
set nojoinspaces

" tells when last window has status lines
set laststatus=2

" show relative line number in front of each line in netrw
let g:netrw_bufsettings="noma nomod nonu nobl nowrap ro rnu"

" [[ Basic Keymaps ]]

" Clear highlights on search when pressing <Esc> in normal mode
nnoremap <Esc> :nohlsearch<CR>

" Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
" for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
" is not what someone will guess without a bit more experience.
"
" NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
" or just use <C-\><C-n> to exit terminal mode
tnoremap <Esc><Esc> <C-\><C-n>

" Keybinds to make split navigation easier.
"  Use CTRL+<hjkl> to switch between windows
"
"  See `:help wincmd` for a list of all window commands
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>

" Move window to the left, right, lower and upper
" NOTE: Some terminals have coliding keymaps or are not able to send distinct keycodes
" nnoremap <C-S-h> <C-w>H
" nnoremap <C-S-l> <C-w>L
" nnoremap <C-S-j> <C-w>J
" nnoremap <C-S-k> <C-w>K

" Toggle spell checking
nnoremap <F6> :setlocal spell!<CR>

" Move selected text up and down
" xnoremap K :m '<-2<CR>gv=gv
" xnoremap J :m '>+1<CR>gv=gv

" Paste without overwriting the register
xnoremap <leader>p "_dP
" Delete without yanking
nnoremap <leader>d "_d
xnoremap <leader>d "_d
