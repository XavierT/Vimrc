" Syntax file for postraces logs
"
" (rsyslog like syntax)" Syntax file for postraces logs
"
"

if exists("b:current_syntax")
  finish
endif


"In case more than one item matches at the same position, the one that was
"defined LAST wins.  Thus you can override previously defined syntax items by
"using an item that matches the same text.  But a keyword always goes before a
"match or region.  And a keyword with matching case always goes before a
"keyword with ignoring case.

" Keywords
"syn keyword syntaxElementKeyword keyword1 keyword2 nextgroup=syntaxElement2
syn keyword posError ERROR

" Matches
"syn match syntaxElementMatch 'regexp' contains=syntaxElement1 nextgroup=syntaxElement2 skipwhite


" Match number in comment
syn match     posDecNumber   "\d\+"
syn match     posHexNumber   "\<0x[a-fA-F0-9_]\+"

"Does not match number in file line
syn match posLine ":\d\+:"

syn match posTask "\[r_XR.\{-}\]"
syn match posTask "\[Rx.\{-}\]"
syn match posTask "\[JoinXR.\{-}\]"
syn match posTask "\[DisplayProc\]"
syn match posTask "\[INIT\]"
syn match posTask "\[SM.\{-}\]"
syn match posTask "\[Sock.\{-}\]"

"Match errors
syn match posError "\[reportErrorTask\]"
" match whole Line
syn match posError ".*reportError errorCode=\d\+.*"

" match the date at format YYYY-MM-DD HH:MM:SS.xxx 
syn match posDate "\d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2}\.\d\{3}" 

" Match Event for quick overview
syn match posEvent "EV_.\{-}$"
syn match posEvent "EV_.\{-} "

syn match posPaddle "Paddle changed"
syn match posIRType "IRType"

" Match system reboot
syn match posBoot ".*Starting isis.*"

" Regions
"syn region syntaxElementRegion start='x' end='y'


" Highlight groups

hi def link posTask        Statement
hi def link posDate        Normal
hi def link posDecNumber   Number
hi def link posHexNumber   Number
" do not highlight line numbers, this is not very relevant
hi def link posLine        Normal   

hi def link posError       Error
hi def link posEvent       Tag
hi def link posPaddle      Tag
hi def link posIRType      Tag


hi def link posBoot       InsertMode
"hi def link celTodo        Todo
"hi def link celComment     Comment
"hi def link celBlockCmd    Statement
"hi def link celHip         Type
"hi def link celString      Constant
"hi def link celDesc        PreProc
"hi def link celNumber      Constant

let b:current_syntax = "pos"
