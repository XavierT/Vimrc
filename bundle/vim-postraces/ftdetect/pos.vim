" Syntax file for postraces logs
"
" (rsyslog like syntax)" Syntax file for postraces logs
"
"


" Detect postraces filetype for syntax highlighting
au BufRead,BufNewFile postraces setfiletype pos
au BufRead,BufNewFile postraces.* setfiletype pos
