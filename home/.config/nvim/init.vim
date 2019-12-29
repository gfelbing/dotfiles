"""[Vundle stuff
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

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
Plugin 'mileszs/ack.vim'
"Plugin 'vim-pandoc/vim-pandoc'
"Plugin 'vim-pandoc/vim-pandoc-syntax'
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
set exrc
set secure
let mapleader = "," 

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
colorscheme base16-gruvbox-light-hard
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
"""]

"""[ time
:nnoremap <F5> "=strftime("\n- %H:%M:%S ")<CR>P
:inoremap <F5> <C-R>=strftime("%H:%M:%S ")<CR>
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
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
"""]

"""[Pandoc
command PDF :w | !pandoc %:t -o %:t.pdf
command PANDOC :w | !pandoc-compose -v
"""]

"""[yapf - python formatter
command PEP8 :w | :Yapf --style=pep8 | :w

"""[clang
command CLANGFORMAT :w | !clang-format -i %
autocmd FileType c,cpp,objc nnoremap <Leader>cf :CLANGFORMAT<CR>
command JSONPP !cat % | json_pp --json_opt=canonical,pretty > /tmp/json_pp && cat /tmp/json_pp > %
autocmd FileType json nnoremap <Leader>cf :JSONPP<CR>
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

"""[Window navigation
nnoremap <silent> <C-j> :bnext<CR>
nnoremap <silent> <C-k> :bprev<CR>
"""]

"""[ YCM
nnoremap <C-b> :YcmCompleter GoTo
"""]

