"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Setup Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=$VIMHOME/bundle/Vundle.vim
call vundle#begin('$VIMHOME/bundle/plugins')
Plugin 'VundleVim/Vundle.vim'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ColorScheme
Plugin 'altercation/vim-colors-solarized'

" NerdTree
Plugin 'scrooloose/nerdtree'

" Tabular
Plugin 'godlygeek/tabular'

" NERDCommenter
Plugin 'scrooloose/nerdcommenter'

" FuzzyFinder Ctrl-P
Plugin 'ctrlpvim/ctrlp.vim'

" FuzzyFinder Ctrl-P
Plugin 'myusuf3/numbers.vim'

" EasyMotion
Plugin 'easymotion/vim-easymotion'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cleanup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call vundle#end()
filetype plugin indent on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
