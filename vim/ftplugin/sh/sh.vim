setlocal   tabstop=4
setlocal   softtabstop=4
setlocal   shiftwidth=4
setlocal   textwidth=80
setlocal   expandtab
setlocal   autoindent
setlocal   fileformat=unix
setlocal   comments=:#
setlocal   commentstring="# %s"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mark last allowed Column
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
setlocal colorcolumn=+1
highlight ColorColumn ctermbg=235 guibg=#03323e

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Abbr
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Execute on every Write
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ExecuteBeforeWrite()
  call DeleteTrailingSpaces()
endfunction
autocmd BufWritePre * call ExecuteBeforeWrite()
