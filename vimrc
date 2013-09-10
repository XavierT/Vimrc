" Custom .vimrc
"
" Need Vim Version > 7.4
"
" On Windows, rename .vim folder into vimfiles
" and clone project in there.
"
" Customized for French keyboard to avoid leaving middle keyboard row
"   Map Leader is ','
"   Jump to tag is <C-j>
"   Bufexplorer is <Leader>q
"
"
" use zM to fold all
" use zR to unfold all
" see ':help folding' for more information
"
" *****************************************************************************


" Options
" ======= {{{1
set nocompatible     " break compatibility with VI but enable a lots of VIM features

set langmenu=en_GB.UTF-8    " sets the language of the menu (gvim)
"language en                 " sets the language of the messages / ui (vim)

" put every plugin in separate .vim/bundle/[PLUGIN_DIR]
" filetype must be off before calling pathogen inititialisation
filetype off
execute pathogen#infect()

" Syntax highlighting and filetypes
filetype plugin indent on
syntax on

" *************************************
" General
" ------- {{{2


" Don't save options and mapping
" between each sessions
set sessionoptions=blank,buffers,curdir,folds,help,winsize,options
 

" Comportement un peu plus cool
set backspace=2      " allow backspacing on indentation and line break
"set scrolljump=10     " jump 'scrolljump' line when scrolling out of screen with j or k
set scrolloff=10      " keep some context when scrolling


" to use with cygwin on windows
set encoding=utf-8
set fileencoding=utf-8

" Formattage
set textwidth=80
set formatoptions=tcqnol     " automatic formatting options
set smarttab
set nojoinspaces             " insert only one space after. , ! when using join command J
set listchars=tab:»·,trail:· " Replace tabulation & trailing spaces when using :set list/nolist
set list                     " display tabulation, use set no list to remove them
set nowrap                   " by default do no wrap long line, 

set shiftwidth=4             " used by >>, << and tab.
set tabstop=4                " number of space characters used when displaying TAB
set expandtab                " replace TAB by spaces
set softtabstop=4            " will erase 4 spaces at once when using BS in the begining of lines only

set ignorecase               " ignore case for search
set smartcase                " smart case search
set cursorline               " display a line where the cursor is
set laststatus=2             " always display status line
set statusline=%f%m%r%h\ [%L]\ [%{&ff}]\ %y%=[%p%%]\ [line:%05l,col:%03v]
"               | | | |    |       |      |    |           |       |
"               | | | |    |       |      |    |           |       +- column number
"               | | | |    |       |      |    |           + -- line number
"               | | | |    |       |      |    +-- percentage in file
"               | | | |    |       |      +-- file type
"               | | | |    |       +-- file format (dos/unix)
"               | | | |    +-- total number of line in file
"               | | | +-- help flag
"               | | +-- read only flag
"               | +-- modified flag : [+] if modified, [-] if not modifiable
"               +-- relative path

" default indentation rules
set nocindent       "c specific indentation rules
set smartindent
set autoindent

" Automatic completion
set wildmenu
set wildmode=longest:full,full
set suffixes+=.bak,~,.out
set wildignore+=*.o,*.toc,*.swp,*.aux,*.log,*.dvi,*.ps,*.exe,*.bin,.git,CVS,*.so,*.debug,*.make,CMakeLists.*,tools,build*xenomai,*.png,*.swf,*.dtd,*.cmake,*.RFL
set complete-=i   " when using autocomplete do not look into all included file because it is too long
                  " with network file systeim...

" Gadgets Vim
set pastetoggle=<F10>
"set confirm
set showbreak=##        " Display characters at the beginning of a line, if force line return
set viminfo='20,\"50
set showmatch           " show matching ( or { when inserting them
set showcmd
set cmdheight=2         " Two lines for command window (better to display some messages)
set shortmess=filnxtToO
set virtualedit=block
set nostartofline
set splitright          " when splitting the new window is on right
set splitbelow          " when splitting the new window is below 
" set winheight=30
set incsearch           " incremental search. Search starts when the whole word is typed
set hlsearch            " Highlight result of search
set foldmethod=marker   " fold vimrc using {{{ and }}}

" Buffers
set switchbuf=useopen

" Path & Files
" '**5'search subdirectories up to five level deep
" `';' allow to search upward until root
set path+=**3;.,./**3,./Machine/**3
set nobackup  "I don't know  what backup files are for.


" possibly needed if you use terminal to enable use of 256 colors
" (terminal should also be 256 colors able)
if !has("gui_running")
    set t_Co=256
endif

"" donbass is a nice theme because it works with vim or gvim
" for darker environnement use zenburn,solarized or wombat
if has("gui_running")
    if has('win32') || has('win64')
        " colorscheme looking like default eclipse theme
        " better to work with rest of the team using eclipse
        "set background=light
        "colorscheme solarized
        colorscheme eclipse
    else
        set background=dark
        colorscheme solarized
    endif
else
    colorscheme zenburn
endif

" Disable syntax highlighting for fold lines
" set highlight+=f-,F- 

" Persistent undo (new in VIm 7.3)
" set undodir=~/.vim/undodir
if (v:version >= 703)
    set undofile
    set undolevels=1000 "maximum number of changes that can be undone
    set undoreload=10000 "maximum number lines to save for undo on a buffer reload
endif

"
"
" End General }}}2

" *************************************
" Programming
" ------------- {{{2

set showfulltag

function! s:PROG_options()
   setlocal completeopt ="menuone"
   setlocal formatoptions+=rot
   setlocal shortmess-=T
   setlocal shiftwidth=4
   setlocal iskeyword-={,},[,],(,)
endfunction

" End Programming }}}2

" *************************************
" GUI Options
" Only used in gVim
" ------ {{{2
if has("gui_running")
    " GUI is running or is about to start.
    " Maximize gvim window.
    set lines=120 columns=140
    " Lucida is nice but a bit sharp
    " set guifont=Lucida_Console:h10:cANSI

    " Droid Sans does not distinguish between 'zero' and capital 'O'
    " set guifont=Droid_Sans_Mono:h10
    "
    "set guifont=DejaVu_Sans_Mono:h10:cANSI
    " Try out Ubunto mono font
    "
    if has("win32")
        set guifont=Ubuntu_Mono:h11:cANSI
    else
        set guifont=Ubuntu\ Mono\ 11
    endif


    " Display or hide menu when using gVim
    function! ToggleGUICruft()
      if &guioptions=='i'
        exec('set guioptions=imTrL')
      else
        exec('set guioptions=i')
      endif
    endfunction

    if has("win32")
        " Display or hide menu when using gVim
        " only works with Windows in French...
        function! ToggleFullScreen()
                execute "simalt ~n "
        endfunction

        function! MinFullScreen()
                execute "simalt ~r "
        endfunction

        nmap <F11> <Esc>:call MinFullScreen() <cr>
        nmap <F12> <Esc>:call ToggleFullScreen() <cr>

    endif

    nmap <F10> <Esc>:call ToggleGUICruft() <cr>

    " by default, hide gui menus
    set guioptions=i

endif
" End GUI options }}}2

" *************************************
" Grep Options
" ------ {{{2
if has("gui_running")
     set grepprg=grep\ -nH\ -R\ --include=*.sm\ --include=*.c\ --include=*.cpp\ --include=*.h\ --exclude-dir=workspace\ --exclude-dir=tools\ --exclude=symTbl.c\ $*\ .\ 
else

set grepprg=grep\ -nH
\\--include='*.c'
\\--include='*.cpp'
\\--include='*.xml
\\--include='*.ops'
\\--include='*.osd'
\\--include='*.h'
\\--exclude-dir='.svn'
\\--exclude='*.svn-base'
\\--exclude-dir='OBJ'
\\--exclude='symTbl.c'
\\ $*
\\ -R\ .
endif
" End Grep options }}}2

" *************************************
" Plugin Configuration
" ------ {{{2


"Tagbar plugin configuration
let g:tagbar_autofocus = 1  "autofocus on tagbar window when opening it


" CtrlP Options
" Fuzzy search for MRU, buffer, files
let g:ctrlp_custom_ignore = {
        \ 'dir': 'workspace,tools',
        \ }

function! Index_workspace()
    if has("win32")
        execute "Start! dir *.c,*.cpp,*.h /s /b > Z:/heroic/file_list.txt"
    endif
endfunction

if has("win32")
    nnoremap <F9> <ESC>:call Index_workspace() <cr>
    let g:ctrlp_user_command = ['file_list.txt', 'type %s\file_list.txt']
endif


" Syntastic options:
" Disable for now
"let g:syntastic_enable_signs=1

" End Plugin }}}2

" End Options }}}1

"******************************************************************************
" Mapping
" ==================== {{{1

" Custom map leader
let g:mapleader = ","
let g:maplocalleader = ","

" To easily copy paste from vim to external app
" and vice / versa
set clipboard=unnamed

" Tagbar plugin mapping
noremap <silent> <Leader>ta :TagbarToggle<CR>

" FuzzyFinder plugin mapping
"noremap <Leader>o :FufFile **/<CR>


" CtrlP mapping
noremap <Leader>o :CtrlPCurWD<CR>


" Quick Grep
" open and switch to quickfix window
noremap <Leader>g :grep<space><C-r><C-w><CR>:copen<CR>

" Version to be used with vim dispatch:
" does not support jump to file in this version...
"noremap <Leader>g :Dispatch grep -r --include=*.sm --include=*.c --include=*.cpp --include=*.h --exclude-dir=workspace --exclude-dir=tools --exclude=symTbl.c <space><C-r><C-w> . <CR>


" Grep in current buffer only
" Do not jump to quickfix window
noremap <Leader>l :vimgrep<space><C-r><C-w><space>%<CR>:g/<C-r><C-w>//<CR>:copen<CR><C-W>t

" toggle highlight search highlight
noremap <leader>h :noh<cr>

" remap ESC to jk to avoid leaving the row to leave insert mode
" i to enter insert mode, jk to leave
" only remap in Insert, because for example in visual mode for
" line selection jk is pretty common
inoremap jk <Esc>
"inoremap <Esc> <NOP>
" i to enter insert mode, jk to leave
 
" Disable escape to adapt
"inoremap <Esc> <NOP>
"vnoremap <Esc> <NOP>
"snoremap <Esc> <NOP>

" so remap :tags <cursor> on something which works
" anyway ] is not really easy to reach on a french keyboard
" so j (as jump to definition) is better
"
" CTRL+] is broken with Cygwin...
"noremap fj :exe "ta ".expand("<cword>")<CR>
noremap fj <C-]>

" Moving around quickly between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Easier Windows resize
noremap <C-Down> <C-W>-
noremap <C-Up> <C-W>+
noremap <C-Left> <C-W><
noremap <C-Right> <C-W>>

" select recently pasted text
" to use right after 'p' or 'P'
" equivalent to gv
" It is using motion `[ and `] to go to the beginning
" and end of recently modified section
" getregtype is used to get either v or V if you are copying
" linewise or blockwise
nnoremap <expr> gp '`[' . getregtype()[0] . '`]'

" remap move to parent { and }
" on easier keys
" previous opening {
nnoremap à [{
vnoremap à [{
" next closing }
nnoremap ç ]}
vnoremap ç ]}

" remap begin and end of paragraph
" on easier keys
" beginning of paragraph
nnoremap _ {
vnoremap _ {
" end of paragraph
nnoremap è }
vnoremap è }

" Quick Tags Creation
" additional fields used by omnicompletion plugin
" noremap <F8> :!ctags -R --C++-kinds=+p --fields=+iaS --extra=q .
" Create ctags from scratch
"nnoremap <F8> :!ctags -R --C++-kinds=+p --fields=+iaS --extra=q  --exclude="*tools*" --exclude=symTbl.c *.c,*.cpp,*.h,*.rb .

" Using dispatch plugin
nnoremap <F8> :Start!ctags -R --C++-kinds=+p --fields=+iaS --extra=q  --exclude="*tools*" --exclude=symTbl.c *.c,*.cpp,*.h,*.js .

" Refresh ctags with recently edited files
nnoremap <F7> :bufdo !ctags -a --C++-kinds=+p --fields=+iaS --extra=q  %
" search first in current directory then file directory for tag file
set tags=tags,./tags

" Fast Buffer Switching
" with plugin BufExplorer installed
" nnoremap ² :BufExplorer<CR>
nnoremap  <Leader>q :BufExplorer<CR>


" Save and restore session
"nnoremap <F2> :mksession! ~/vim_session<CR>
"nnoremap <F3> :source ~/vim_session<CR>

" toggle spell checking with s
nmap <silent> <leader>s :setlocal spell!<CR>

if has("win32")
    " Quick .vimrc edit
    nmap <silent> <Leader>u :e $MYVIMRC<CR>
    " Quick .vimrc reload
    nmap <silent> <Leader>v :so $MYVIMRC<CR>
endif

if has("unix")
    " Quick .vimrc edit
    nmap <silent> <Leader>u :e ~/.vim/vimrc <CR>
    " Quick .vimrc reload
    nmap <silent> <Leader>v :so ~/.vim/vimrc<CR>
endif

" Use ` instead of '
"nmap ' `

" To yank whole lines, see :help Y
nmap Y y$

" To use jk to move up down in pop up menu
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

" Eclipse like shortcut to switch between header and C file.
nnoremap <C-TAB> :A<CR>

" Abbreviations
" ----- {{{2

" Racourcis sympas dans le texte en UTF-8
inoreabbrev esle else
inoreabbrev teh the
inoreabbrev ladate <C-R>=strftime("%A %d %B %Y")<CR>
inoreabbrev lheure <C-R>=strftime("%H:%M")<CR>
inoreabbrev thedate <C-R>=strftime("%Y-%m-%d")<CR>

" End Abbreviations }}}2

" End Mapping }}}1
"

"******************************************************************************
" Commands
" ==================== {{{1
"
" Clearcase
" expand only filename not fullpath and it works !
" get history tree graphically
command! Cleartree call s:clearcase_versionTree()
" checkout
command! Clearcheckout call s:clearcase_checkout()
" graphical diff
command! Cleardiff call s:clearcase_diff()
" quick annotation
command! Clearannotate call s:clearcase_annotate()
" quick annotation
command! Clearconfig call s:clearcase_config()

" Task
" to be used with vim outliner
command! Task :silent e ~/task.otl

"Split a small window on the right
command! Split normal 30v



" End Commands }}}1

" *****************************************************************************
" Functions
" ========= {{{1

" It only works for file in current directory
" because of differences between cygwin path in /cygdrive/z
" and windows Z:
"
" on a pure linux installation using :p instead of :t should work
function! s:clearcase_versionTree()
    if has("win32")
        execute "!start cleartool lsvtree -g ".expand("%:p")." & "
    else
        execute "!cleartool lsvtree -g ".expand("%:p")." & "
    endif
endfunction

function! s:clearcase_checkout()
    if has("win32")
        execute "!start cleartool co -nc ".expand("%:p")
    else
        execute "!cleartool co -nc ".expand("%:p")
    endif
endfunction

function! s:clearcase_diff()
    if has("win32")
        execute "!start cleartool diff -g -predecessor ".expand("%:p")
    else
        execute "!cleartool diff -g -predecessor ".expand("%:p")." & "
    endif
endfunction

function! s:clearcase_annotate()
    let filename=expand("%:p")
    execute "!cleartool annotate ".filename." & "
    execute "new "
    execute "read ".filename.".ann"
endfunction

function! s:clearcase_config()
    execute "!cleartool edcs "
endfunction


" Test if the task file is already open in VIM
function! s:TaskSwapExists()
    set wildignore-=*.swp

    let s:exists =  filereadable(expand("$HOME/.task.otl.swp"))

    set wildignore+=*.swp

    return s:exists
endfunction

command! TestF call s:TaskSwapExists()

"Open task
" if task.otl.swp does not already exists
if  (argc() == 0)
    if( s:TaskSwapExists() == 0)
         Task
    endif
endif

" End Functions }}}1

" *****************************************************************************
" File Format specific functions

" ------------- {{{1
" C
" - {{{2

function! s:C_options()
    " Options de formatage a la GNU
    " set cinoptions={.5s:.5sg.5st0(0=.5s

    " Format options for RTSW Pos
    setlocal cinoptions={0,:1s,g1s,t0,(0,=.5s

    setlocal noautoindent
    setlocal nosmartindent
    setlocal cindent
    call s:PROG_options()
endfunction

function! s:CPP_options()
   call s:C_options()
   setlocal cinoptions={0,:1s,g1s,t0,(0,=.5s
   setlocal expandtab
   set fo-=o fo-=r
endfunction

" End C }}}2

" HTML
" ---- {{{2

function! s:HTML_options()
   call s:XML_options()
endfunction

" End HTML }}}2

" XML
" --- {{{2

function! s:XML_options()
   setlocal shiftwidth=2
   setlocal tabstop=2                " number of space characters used when displaying TAB
   setlocal softtabstop=2            " will erase 4 spaces at once when using BS in the begining of lines only
endfunction

" End XML }}}2

" C like
" ------ {{{2

function! s:C_LIKE_options()
   setlocal cindent
   setlocal expandtab
   call s:PROG_options()
endfunction

" End C like }}}2

" PYTHON
" --- {{{2

function! s:PYTHON_options()
   setlocal nosmartindent               " this is bad for comments starting with a bang
   setlocal autoindent
   setlocal shiftwidth=4
   setlocal tabstop=4
   setlocal softtabstop=4            " will erase 4 spaces at once when using BS in the begining of lines only
   setlocal noexpandtab
   setlocal nolist
endfunction

" End PYTHON }}}2

" TXT
" --- {{{2

function! s:TXT_options()
   setlocal noundofile                "don't want to have temp file every time I open a txt file
   setlocal spell                     " add spell checker for txt files
endfunction

" End PYTHON }}}2
" End file format specific }}}1

" *****************************************************************************
" Autocmd
" ======= {{{1

autocmd BufRead,BufNewFile *.c call s:C_options()
autocmd BufRead,BufNewFile *.cpp call s:CPP_options()
autocmd BufRead,BufNewFile *.php call s:C_LIKE_options()
autocmd BufRead,BufNewFile *.perl,*.pl call s:C_LIKE_options()
autocmd BufRead,BufNewFile *.xml call s:XML_options()
autocmd BufRead,BufNewFile *.html call s:HTML_options()
autocmd BufRead,BufNewFile *.py call s:PYTHON_options()
autocmd BufRead,BufNewFile *.txt call s:TXT_options()
" For makefile do not expand tab !
autocmd BufRead,BufNewFile Makefile*,makefile* setlocal noexpandtab

" To restore session at next startup
" autocmd VimLeavePre * s:Save_session() 
" autocmd VimEnter * call s:Restore_session()
" autocmd SessionLoadPost * syntax on


" Spelling auto commands
"autocmd BufRead,BufNewFile _vimrc setlocal spell

" check spelling of comments / not code ! Very cool
"autocmd InsertEnter * setlocal spell
"autocmd InsertLeave * setlocal nospell

" Orocos specific
autocmd BufRead,BufNewFile *.osd,*.ops set filetype=c

" Vimoutliner filetype
autocmd BufRead,BufNewFile *.otl set filetype=vo_base

" Maximize gvim windows at startup on Windows
"if has("win32")
    "Maximize screen on windows with a french shortcuts...
    "autocmd GUIEnter * :simalt ~n
"endif

" End Autocmd }}}1
"
"

" *****************************************************************************
" Management of Large file
" ======= {{{1
" Large file are above 10 Mo
:let g:LargeFile=10

" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  " Large files are > 10M
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowritefile (is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
    augroup END
  endif
" End Large File }}}1


" Custom settings to start in working environnement
" when it is mounted
" if not stay in current directory
if isdirectory("Z:\heroic")
    cd Z:\heroic
endif


