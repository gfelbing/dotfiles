"""[Vundle stuff
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'ianks/vim-tsx'
Plugin 'scrooloose/nerdtree.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'chriskempson/base16-vim'
Plugin 'mindriot101/vim-yapf'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
call vundle#end()            " required
filetype plugin indent on    " required
"""]

"""[ Basic setup
set nocompatible              " required
syntax enable
filetype off
set path+=**
set wildmenu
set cursorline
set autoread

" Tags for file jump and autocomplete
command MakeTags !ctags -R .

" file browse config
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

"""[base16
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
colorscheme base16-google-light 
"""]


"""[Airline

let g:airline_theme='papercolor'
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"""]

"""[Some settings
" Show line numbers
:set number relativenumber
" Use spaces instead of tabs
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
" Enable Syntax Highlighting
syntax on
filetype indent plugin on
"""]


"""[ file search
nnoremap <C-p> :FZF<CR>
"""]

"""[Pandoc
command PDF :w | !pandoc %:t -o %:t.pdf
command PANDOC :w | !pandoc-compose -v
"""]

"""[yapf - python formatter
command PEP8 :w | :Yapf --style=pep8 | :w

"""[clang
command CLANGFORMAT :w | !clang-format -i %
"""]

"""[NERDtree
function! NERDTreeToggleInCurDir()
    " If NERDTree is open in the current buffer
    if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
        exe ":NERDTreeClose"
    else
        if (expand("%:t") != '')
            exe ":NERDTreeFind"
        else
            exe ":NERDTreeToggle"
        endif
    endif
endfunction
map <C-n> :call NERDTreeToggleInCurDir()<CR>
"""]
