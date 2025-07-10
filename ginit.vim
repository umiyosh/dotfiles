" Enable Mouse
set mouse=a

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont HackGen35\ Console\ NF:h17
endif

" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif
" Paste normal mode
nnoremap <D-v> "+P
" Paste visual mode
vnoremap <D-v> "+P
" Paste command mode
cnoremap <D-v> <C-R>+
" Paste insert mode
inoremap <D-v> <C-R>+
tnoremap <D-v> <C-\><C-N>"+pi



" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 1
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
