setlocal   tabstop=4
setlocal   softtabstop=4
setlocal   shiftwidth=2
setlocal   textwidth=80
setlocal   expandtab
setlocal   autoindent
setlocal   fileformat=unix
setlocal   comments=:--
setlocal   commentstring="-- %s"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mark last allowed Column
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
setlocal colorcolumn=+1
highlight ColorColumn ctermbg=235 guibg=#03323e

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Taglist
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let Tlist_Use_Right_Window = 0
"let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_One_File = 1
let Tlist_Display_Prototype = 0
let Tlist_Sort_Type = "name"
let g:tlist_vhdl_settings   = 'vhdl;d:package declarations;x:package bodies;l:blocks;e:entities;a:architecture specifications;t:type declarations;p:processes;f:functions;r:procedures'
let Tlist_Use_Split_Window = 1
set tags=tags,sim/mti/lib/tags


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Abbr
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iabbr dt DOWNTO
iabbr sig SIGNAL
iabbr ot OTHERS => '
iabbr sl STD_LOGIC
iabbr slv STD_LOGIC_VECTOR

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" If buffer modified, update any '@date ' in the first 50 lines.
" Restores cursor and window position using save_cursor variable.
function! LastModified()
    if &modified
        let save_cursor = getpos(".")
        let n = min([50, line("$")])
        keepjumps exe '1,' . n . 's#^\(.\{,10}@date \).*#\1' .
                    \ strftime('%d.%m.%Y') . '#e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Execute on every Write
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ExecuteBeforeWrite()
  call DeleteTrailingSpaces()
  call LastModified()
endfunction
autocmd BufWritePre * call ExecuteBeforeWrite()
