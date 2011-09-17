" Custom .vimrc
"
" Customized for french keyboard to avoid leaving middle keyboard row
"   Map Leader is ','
"   Jump to tag is fj
"   Bufexplorer is <Leader>q
"   'ii' will leave insert or visual mode (as <ESC>)
"
"  On Linux          On Windows
"    .vimrc         --> rename to '_vimrc'
"    .vim directory --> rename to 'vimfiles'
"                       Move both to $HOME
"                       (C:\Documents and Settings\username\)
"
" use zM to fold all
" use zR to unfold all
" see ':help folding' for more information
"
" *****************************************************************************

" Options
" ======= {{{1
set nocompatible     " break compatibility with VI but enable a lots of VIM features

" put every plugin in separate .vim/bundle/[PLUGIN_DIR]
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


" Syntax highlighting and filetypes
filetype plugin indent on
syntax on

" *************************************
" General
" ------- {{{2

" Comportement un peu plus cool
set backspace=2      " allow backspacing on indentation and line break
set scrolljump=10     " jump 'scrolljump' line when scrolling out of screen with j or k


" to use with cygwin on windows
if has("win32unix")
    set encoding=latin1
endif

" Formattage
set textwidth=80
set formatoptions=tcqnol     " automatic formatting options
set smarttab
set nojoinspaces             " insert only one space after. , ! when using join command J
set listchars=tab:··,trail:· " Replace tabulation & trailing spaces when using :set list/nolist
set list                     " display tabulation, use set no list to remove them

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
set wildignore+=*.o,*.toc,*.swp,*.aux,*.log,*.dvi,*.ps,*.exe,*.bin
set complete-=i   " when using autocomplete do not look into included file because it is too long
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
set nobackup

" possibly needed if you use terminal to enable use of 256 colors
" (terminal should also be 256 colors able)
set t_Co=256

" donbass is a nice theme because it works with vim or gvim
" for darker environnement use zenburn or wombat
if has("gui_running")
" colorscheme looking like default eclipse theme
" better to work with rest of the team using eclipse
    colorscheme eclipse
else
    colorscheme zenburn
endif
set highlight+=f-,F-

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

    " There is a difference in the way linux or windows are
    " treating this option
    if has("win32")
        set guifont=DejaVu_Sans_Mono:h10:cANSI
    else
        set guifont=DejaVu\ Sans\ Mono\ 10
    endif

    " Display or hide menu when using gVim
    function! ToggleGUICruft()
      if &guioptions=='i'
        exec('set guioptions=imTrL')
      else
        exec('set guioptions=i')
      endif
    endfunction

    map <F11> <Esc>:call ToggleGUICruft()<cr>

    " by default, hide gui menus but keep icon
    set guioptions=i

endif
" End GUI options }}}2

" *************************************
" Grep Options
" ------ {{{2
if has("gui_running")
     set grepprg=grep\ -nH\ -R\ --include=*.c\ --include=*.cpp\ --include=*.h\ --exclude=symTbl.c\ $*\ .\ 
else

set grepprg=grep\ -nH
\\--include='*.c'
\\--include='*.cpp'
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

" Taglist plugin config
let Tlist_Use_Right_Window = 1
let Tlist_Inc_Winwidth = 0
let Tlist_WinWidth = 45
let Tlist_GainFocus_On_ToggleOpen= 1
let Tlist_Ctags_Cmd = 'ctags'
let Tlist_Show_One_File = 1
"let Tlist_Display_Prototype = 1

" Fuzzy Finder plugin
" on windows put fuzzy finder cache into vim directory
" default is ~/.vim-fuf-data
if has("win32")
    let g:fuf_dataDir = "~/vimfiles/vim-fuf-data"
endif

" default excluded file by fuzzy finder file open
" let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
" exclude 'tools' dir full of useless files
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|tools|workspace'

" Omnicpp complete plugin
let OmniCpp_ShowPrototypeInAbbr = 1

" End Plugin }}}2

" End Options }}}1

"******************************************************************************
" Mapping
" ==================== {{{1

" Custom map leader
let g:mapleader = ","
let g:maplocalleader = ","

" Taglist plugin mapping
noremap <silent> <Leader>ta :TlistToggle<CR>

" FuzzyFinder plugin mapping
noremap <Leader>o :FufFile **/<CR>

" Quick Grep
noremap <Leader>g :grep<space><C-r><C-w><CR>:copen<CR><CR><C-W>b

" toggle highligh search highlight
noremap <leader>h :noh<cr>

" remap ESC to ii to avoid leaving the row to leave insert mode
" i to enter insert mode, ii to leave
inoremap ii <Esc>
vnoremap ii <Esc>
snoremap ii <Esc>

" CTRL+] is broken with Cygwin...
" so remap :tags <cursor> on something which works
" anyway ] is not really easy to reach on a french keyboard
" so j (as jump to definition) is better
"noremap fj :exe "ta ".expand("<cword>")<CR>
noremap fj <C-]>

" Moving around quickly between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

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
nnoremap � [{
vnoremap � [{
" next closing }
nnoremap _ ]}
vnoremap _ ]}

" remap ESC to jk
nnoremap jk <ESC>
vnoremap jk <ESC>
snoremap jk <ESC>

" remap begin and end of paragraph
" on easier keys
" beginning of paragraph
nnoremap ç {
vnoremap ç {
" end of paragraph
nnoremap à }
vnoremap à }

" Quick Tags Creation
" additional fields used by omnicompletion plugin
" noremap <F8> :!ctags -R --C++-kinds=+p --fields=+iaS --extra=q .
" Create ctags from scratch
nnoremap <F8> :!ctags -R --C++-kinds=+p --fields=+iaS --extra=q  --exclude=symTbl.c *.c,*.cpp,*.h,*.rb .

" Refresh ctags with recently edited files
nnoremap <F7> :bufdo !ctags -a --C++-kinds=+p --fields=+iaS --extra=q  %
" search first in current directory then file current directory for tag file
set tags=tags,./tags

" Fast Buffer Switching
"
" without plugin BufExplorer installed
" noremap � :buffers<CR>:buffer<Space>
"
" with plugin BufExplorer installed
" nnoremap � :BufExplorer<CR>
nnoremap  <Leader>q :BufExplorer<CR>

" Comment/Uncomment.
" use Nerd Commenter plugin instead
" nnoremap <Leader>c :<C-B>sil <C-E>s/^/<C-R>=escape(substitute (&comments,'^\(.\{-},\)\?:\([^,]\+\).*','\2',''),'\/')<CR> /<CR>:nohls<CR>
" nnoremap <Leader>c :<C-B>sil <C-E>s/^/<C-R>=escape(substitute (&comments,'^\(.\{-},\)\?:\([^,]\+\).*','\2',''),'\/')<CR> /<CR>:nohls<CR>

if has("win32")
    " Quick .vimrc edit
    nmap <silent> <Leader>u :e $HOME\_vimrc<CR>
    " Quick .vimrc reload
    nmap <silent> <Leader>v :so $HOME\_vimrc<CR>
endif

if has("unix")
    " Quick .vimrc edit
    nmap <silent> <Leader>u :e ~/.vimrc <CR>
    " Quick .vimrc reload
    nmap <silent> <Leader>v :so ~/.vimrc<CR>
endif

" Use ` instead of '
"nmap ' `

" To yank whole lines, see :help Y
nmap Y y$


" Abbreviations
" ----- {{{2

" Racourcis sympas dans le texte en UTF-8
" iab ca ça
" iab Ca �a
" iab etre être
" iab etes êtes
" iab Etes êtes
" iab tete tête
" iab meme même
" iab Meme Même
iab esle else
iab teh the
iab ladate <C-R>=strftime("%A %d %B %Y")<CR>
iab lheure <C-R>=strftime("%H:%M")<CR>

" End Abbreviations }}}2

" End Mapping }}}1

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
" End Other }}}2

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
   setlocal smartindent
   setlocal autoindent
   setlocal shiftwidth=4
   setlocal noexpandtab
   setlocal nolist
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
" For makefile do not expand tab !
autocmd BufRead,BufNewFile Makefile*,makefile* setlocal noexpandtab

autocmd User Rails colorscheme wombat

" End Autocmd }}}1

