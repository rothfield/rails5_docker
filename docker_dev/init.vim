" let g:coc_disable_startup_warning = 1
 
set tabstop=2
" Plugins will be downloaded under the specified directory.
" ~/.local/share/nvim/plugged
call plug#begin('~/.local/share/nvim/plugged')
" for vim ~/.vim/plugged')

" Declare the list of plugins.
" Plug 'tpope/vim-sensible'
" Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-fugitive'
Plug 'sbdchd/neoformat'
"  Bundle 'Lokaltog/vim-easymotion'
"  Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"  Bundle 'tpope/vim-rails.git'
Plug 'vim-ruby/vim-ruby'
Plug 'ngmy/vim-rubocop', { 'for': 'ruby' }
"  Bundle 'guns/vim-clojure-static'
"  Bundle 'tpope/vim-fireplace'
"  Bundle 'scrooloose/syntastic'
"  Bundle "pangloss/vim-javascript"
"  Bundle 'jelera/vim-javascript-syntax'
"  Bundle 'jtratner/vim-flavored-markdown'
Plug 'Chiel92/vim-autoformat'
"  Bundle 'kchmck/vim-coffee-script'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale'
Plug 'slim-template/vim-slim'
" Use release branch (recommend)
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
let g:ale_fixers = {
  \ 'javascript': ['eslint']
  \ }

let g:ale_fix_on_save = 1

set expandtab
set shiftwidth=2
set softtabstop=2


map <leader>d <Plug>(ale_fix)


autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 

syntax enable
filetype plugin indent on
"  :au FocusLost * :wa # save on losing focus!!
