"
" Need Vim Version > 8.0
"
" On Windows, rename .vim folder into vimfiles
" and clone project in there.
"
" Customized for French keyboard to avoid leaving middle keyboard row
"   Map Leader is ','
"   Jump to tag is "fj"
"   Bufexplorer is <Leader>q
"
"  Use grep (recursively) on current word is <leader>g
"  Use grep in the same file is <leader>f
"  Change current directory to current file is <leader>p
"
"  To add to a search list in the current files :
"  visual selection --> then <leader>,a
"  to clean the search list --> <leader>,c
"
"  <,r> to open most recent file
"  <ctrl+P> to open file in directory
"  <,ww> to open vimwiki root
"  <,l> to open activity log
"
" use zM to fold all
" use zR to unfold all
" see ':help folding' for more information
"
" use :helptags ALL to regenerate all documentation after an update
" 
" use/modify _.snippets to add custom snippets for all files (TAB to " complete)
"
" *****************************************************************************
" Compatibility with Nvim, to share the same configuration
"
" On windows, in $HOME>AppData>Local>nvim
"
" create a init.vim file with the following content (minus ")
"
" set runtimepath^=~/vimfiles runtimepath+=~/vimfiles/after
" let &packpath=&runtimepath
" source ~/vimfiles/vimrc
"
"
" create a ginit.vim file with the following content (minus ") to force
" the font used by the nvim-qt client
" GuiFont! Fira Mono:h11:cANSI:qDRAFT
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

" To regenerate all documentation in plugin run :Helptags provide by pathogen

" Syntax highlighting and filetypes
if !has('nvim')
    filetype plugin indent on
    syntax on
endif

if has('nvim')
    filetype plugin indent on
    syntax on
endif


" enable mouse support / scrollwheel in normal mode
set mouse=n

if has('nvim')
    "preview somw replacement in main window for substitude commands
    set inccommand=nosplit
endif

" *************************************
" General
" ------- {{{2

" Custom map leader
let g:mapleader = ","
let g:maplocalleader = ","

"display line number on the left column
set number

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
set textwidth=72             " 72 to be compliant with our commit messages size
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
set wildignore+=*.o,*.toc,*.swp,*.aux,*.log,*.dvi,*.ps,*.exe,*.bin,.git,.svn,CVS,*.so,*.debug,*.make,build*xenomai,*.png,*.swf,*.dtd,*.cmake,*.RFL
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
        set background=dark
        colorscheme solarized8
        "colorscheme eclipse
    else
        set background=dark
        colorscheme solarized8
    endif
else
    "colorscheme zenburn
    set background=dark
    colorscheme solarized8
endif

if has("win32") || has("win64")

  "On windows, if called from cygwin or msys, the shell needs to be changed to cmd.exe
  " or some paths or plugin are broken
  if &shell=~#'bash.exe$'
    set shell=$COMSPEC " sets shell to correct path for cmd.exe
  endif
endif


" Disable syntax highlighting for fold lines
" set highlight+=f-,F- 

set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

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
    if has('win32') || has('win64')
        "set guifont=Source\ Code\ Pro:h11:cANSI
        set guifont=Consolas:h11
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

    nmap <F10> <Esc>:call ToggleGUICruft() <cr>

    " by default, hide gui menus
    set guioptions=i

endif
" End GUI options }}}2

" *************************************
" Grep Options
" ------ {{{2
"
 set grepprg=grep\
\ -nH\
\ -R\
\ --include=*.sm\
\ --include=*.c\
\ --include=*.cpp\
\ --include=*.idl\
\ --include=*.cfg\
\ --include=*.dyn\
\ --include=*.cal\
\ --include=*.h\
\ --include=*.js\
\ --include=*.html\
\ --include=*.xml\
\ --include=*.css\
\ --include=*.py\
\ --include=*.bat\
\ --include=*.txt\
\ --include=*.err\
\ --include=*.md\
\ --include=*postraces*\
\ --exclude-dir=workspace\
\ --exclude-dir=atlasdelivery\
\ --exclude-dir=atlastools\
\ --exclude-dir=.svn\
\ --exclude-dir=.git\
\ --exclude-dir=.hg\
\ --exclude=symTbl.c\
\ --exclude=*_sv.cpp\
\ --exclude=*_cv.cpp\
\ --exclude=*_sv.h\
\ --exclude=*_cv.h\
\ $*\ .\ 

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" End Grep options }}}2

" End Options }}}1

" *****************************************************************************
" Plugin Configuration
" ======= {{{1

"rust.vim
let g:rustfmt_command = '~/.cargo/bin/rustfmt'

"autoformat on save
let g:rustfmt_autosave = 1

" vimwiki/vimwiki
" location of vimwiki files
let g:vimwiki_list = [{'path': '~/Box Sync/Documents/01_activity_tracking/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" enable folding in vimwiki
let g:vimwiki_folding = 'syntax'

"Additional special config for vimwiki

function! VimwikiFindAllIncompleteTasks()
  VWS /* \[ \]/
  lopen
endfunction

nmap <Leader>wa :call VimwikiFindAllIncompleteTasks()<CR>

" open activity log file on <leader> l in normal mode
nmap <Leader>l :e  $HOME\Box Sync\Documents\01_activity_tracking\vimwiki\activity_log.md<CR>


"Tagbar
" ------- {{{2
let g:tagbar_autofocus = 1  "autofocus on tagbar window when opening it

" }}} 2   End Tagbar

" CtrlP
" ------- {{{2
" Fuzzy search for MRU, buffer, files
" Example to ignore folders containing atlas
"  \ 'dir':  '\v[\/]\.(git|hg|svn)|.*atlas.*$',

let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v(\.(exe|so|dll|o))|(_cv\.cpp|_sv\.cpp|_cv\.h|_sv\.h)$',
	\ }

" Enable/Disable per-session caching: >
" Press F5 inside ctrl P to refresh cache
let g:ctrlp_use_caching = 1

" keep the cache between session
let g:ctrlp_clear_cache_on_exit = 0

" Max limit in the number of file searched
" 0 for no limit
let g:ctrlp_max_files = 0

" Max directory depth
let g:ctrlp_max_depth = 20

" maximum size of the result window
let g:ctrlp_max_height = 25

" Open CtrlP in the current file directory
" If you are using git or svn, it might a better idea to use
" let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_working_path_mode = '0'


" Set the directory to store the cache files: >
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'

" line:  allow to search line by line in the current file
" bookmarkdir : allow to bookmard a directory
let g:ctrlp_extensions = [ 'line', 'bookmardir']

"most recent files
" use m because r is used for redo
" so this is the Most recent files
nnoremap <Leader>r :CtrlPMRUFiles<CR>



" for some reason the above mapping open the MRU list in quickfix on enter
" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" }}} 2   End CtrlP

" Syntastic
" ------- {{{2
" Disable for now
"let g:syntastic_enable_signs=1
" html check does not really work well with handlebar template
" so disable it for now
let syntastic_mode_map = { 'passive_filetypes': ['html'] }

" I have not configured correctly the include list for syntastic
" anyway
let g:syntastic_cpp_no_include_search = 1

" }}} 2 End Syntastic

" Airline option
"
" ------- {{{2

" Disable check of mixed mode / trailing white space
let g:airline#extensions#whitespace#enabled = 0

" Display the buffer name in the tabline
" let g:airline#extensions#tabline#enabled = 1

" }}} 2 End Airline

" Asyncrun option
" ------- {{{2

"automatically open quickfix windows with 6 lines
let g:asyncrun_open = 6 
" }}} 2 End Asyncrun

" End Plugin }}}1
"
" *****************************************************************************
" Mapping
" ==================== {{{1

if has('nvim')
    " to escape easily from nvim terminal
    tnoremap <Esc> <C-\><C-n>
endif

" To easily copy paste from vim to external app
" and vice / versa
set clipboard=unnamed

" Change directory to current open file
nnoremap <leader>p :cd %:p:h<CR>

" Tagbar plugin mapping
noremap <silent> <Leader>ta :TagbarToggle<CR>

" Quick Grep
" open and switch to quickfix window
nnoremap <Leader>g :grep<space><C-r><C-w><CR>:copen<CR>


if executable("rg")
    noremap <Leader>g :Rg <CR>
endif

" Grep in current buffer only
" Do not jump to quickfix window
noremap <Leader>f :vimgrep<space><C-r><C-w><space>%<CR>:g/<C-r><C-w>//<CR>:copen<CR><C-W>t

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
" Rust config to only generate file in .\src
nnoremap <F7> :!ctags -R .\src

nnoremap <F8> :!ctags -R .

" Refresh ctags with recently edited files
"nnoremap <F7> :bufdo !ctags.exe -a --C++-kinds=+p --fields=+iaS --extra=q  %
" search first in current directory then file directory for tag file
set tags=tags,./tags

" Fast Buffer Switching
" with plugin BufExplorer installed
" nnoremap ² :BufExplorer<CR>
"nnoremap  <Leader>q :BufExplorer<CR>

"with CtrlP plugin
nnoremap  <Leader>q :CtrlPBuffer<CR>

" Save and restore session
"nnoremap <F2> :mksession! ~/vim_session<CR>
"nnoremap <F3> :source ~/vim_session<CR>

if has('win32') || has('win64')
    " Quick .vimrc edit
    nmap <silent> <Leader>u :e $MYVIMRC<CR>
    " Quick .vimrc reload
    nmap <silent> <Leader>v :so $MYVIMRC<CR>

    " when using nvim, there is a further indirection because vimrc is sourced
    " in init.vim so have to manage the special case
    " Quick .vimrc edit
    if has('nvim')
        nmap <silent> <Leader>u :e ~/vimfiles/vimrc<CR>
    endif
    
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

"******************************************************************************
" Commands
" ==================== {{{1

"Split a small window on the right
command! Split normal 30v

" Tortoise SVN...

command! Svndiff call s:tortoisesvn_graphicaldiff()

" End Commands }}}1

" *****************************************************************************
" Functions
" ========= {{{1

function! s:tortoisesvn_graphicaldiff()
    execute "!TortoiseProc.exe /command:diff /path:."
endfunction

let g:selection_list = []
"transform list into argument separated by \| (OR)
let g:search_string = ""

" get the visual selection into a method
function! Get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! Add_to_search()
   call add(g:selection_list, Get_visual_selection())
   echo g:selection_list

   let @b = join(g:selection_list,'\|')

   "expand full path name
   execute 'vimgrep "'.join(g:selection_list,'\|').'" '.fnameescape(expand('%'))
   execute 'copen'
endfunction

" clear temporary global variable
function! Clear_search()
    let g:selection_list = []
    let g:search_string = ""

    "clear the quickfix window
    call setqflist([])
endfunction

noremap  <Leader>a :call Add_to_search() <CR>
noremap  <Leader>c :call Clear_search() <CR>

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
   setlocal softtabstop=2            " will erase 2 spaces at once when using BS in the begining of lines only
endfunction

" End XML }}}2

" Javascript
" --- {{{2

function! s:Javascript_options()
   setlocal shiftwidth=2
   setlocal tabstop=2                " number of space characters used when displaying TAB
   setlocal softtabstop=2            " will erase 2 spaces at once when using BS in the begining of lines only
   setlocal cinoptions=>1s
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
   setlocal nospell                    " add spell checker for txt files
   setlocal noexpandtab               "allow to use tab in txt and tsv file
   setlocal nolist                    "don't display whitespace in a text file 
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
autocmd BufRead,BufNewFile *.js call s:Javascript_options()
autocmd BufRead,BufNewFile *.py call s:PYTHON_options()
autocmd BufRead,BufNewFile *.txt,*.tsv call s:TXT_options()
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

" Vimoutliner filetype
autocmd BufRead,BufNewFile *.otl set filetype=vo_base

" Maximize gvim windows at startup on Windows
"if has("win32")
    "Maximize screen on windows with a french shortcuts...
    "autocmd GUIEnter * :simalt ~n
"endif

" End Autocmd }}}1

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
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite noundofile | else | set eventignore-=FileType | endif
    augroup END
  endif
" End Large File }}}1



