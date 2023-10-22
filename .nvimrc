call plug#begin('~/.nvim/plugged')
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'posva/vim-vue'
Plug 'tpope/vim-sensible'
Plug 'dense-analysis/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'vim-python/python-syntax'
Plug 'mustache/vim-mustache-handlebars'
Plug 'tpope/vim-fugitive'
Plug 'chase/vim-ansible-yaml'
Plug 'justinmk/vim-syntax-extra'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ap/vim-css-color'
Plug 'cespare/vim-toml'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Autocompletions for languages
Plug 'SirVer/ultisnips'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

Plug 'psf/black', { 'tag': '23.1.0' }

Plug 'alvan/vim-closetag'

"colorschemes
Plug 'jaromero/vim-monokai-refined'
Plug 'Reewr/vim-monokai-phoenix'
Plug 'sickill/vim-monokai'

"terraform
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'

" Starlark/tilt
Plug 'cappyzawa/starlark.vim'

" Toggle boolean values
Plug 'https://github.com/sagarrakshe/toggle-bool'
call plug#end()


let g:UltiSnipsExpandTrigger="<Enter>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"ignores
set wildignore+=*/.git/*
set wildignore+=*/venv/*
set wildignore+=*/__pycache__/*

"When I misclick shift
command! W write
command! Q quit

command Pjson %!python -m json.tool

" disable ex mode
:map Q <Nop>

" Disable preview window for autocomplete
set completeopt-=preview

"Ricing
set number
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:python_highlight_all = 1
colorscheme monokai

" tabs
nnoremap <C-b>  :tabprevious<CR>
inoremap <C-b>  <Esc>:tabprevious<CR>i
nnoremap <C-n>  :tabnext<CR>
inoremap <C-n>  <Esc>:tabnext<CR>i
nnoremap <C-t>  :tabnew<CR>
inoremap <C-t>  <Esc>:tabnew<CR>i


function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        lopen
    else
        lclose
    endif
endfunction

nnoremap <silent> - :call ToggleQuickFix()<cr>

" nnoremap ] :lclose<CR>
" nnoremap [ :lopen<CR>

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" js bullshit
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType vue setlocal ts=2 sts=2 sw=2
autocmd FileType yaml setlocal ts=2 sts=2 sw=2
autocmd FileType css setlocal ts=2 sts=2 sw=2
autocmd FileType vue syntax sync fromstart


set mouse=a

" Plugin Settings
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

" Work branch
" let g:gitgutter_diff_args = 'dev'
let g:gitgutter_max_signs=9999
"
" closetags
let g:closetag_filetypes = 'html,vue'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue'



" Ale options
let g:ale_linters = {
\    'python': ['flake8', 'pylint', 'mypy'],
\    'javascript': ['eslint'],
\    'vue': ['stylelint', 'eslint'],
\    'rust': ['rls', 'analyzer'],
\    'java': ['checkstyle'],
\}
let g:ale_linter_aliases =  {'vue': ['javascript', 'css', 'scss', 'html']}
let g:ale_linters.scala = ['fsc', 'scalastyle']
let g:ale_javascript_eslint_options = '--no-ignore'
let g:ale_scalastyle_config_loc='~/.scalastyle_config.xml'
let g:ale_python_mypy_options='--ignore-missing-imports'
let g:ale_java_checkstyle_options="-c $(git root)/checkstyles.xml"
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_open_list = 0
let g:ale_python_pylint_options='-s n -r n -j 0 --disable=missing-docstring --init-hook="import sys; sys.path.append(\"$(git root)\")"'
" let g:ale_python_flake8_options='--ignore=E501'
" Black line length
let g:black_linelength = 120

let g:ale_rust_rls_options = '--cli'
" let g:ale_rust_rls_toolchain = ''

let g:ale_completion_enabled = 1


" Autocomplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" let g:deoplete#sources = {}
" let g:deoplete#sources.java = ['javacomplete2']
let g:LanguageClient_serverCommands = {
            \ 'lua': ['~/workspace/lua-language-server/lua-lsp'],
            \ 'rust': ['rust-analyzer'],
            \ }
let g:LanguageClient_autoStart = 1
let g:python3_host_prog = '/usr/bin/python'


" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"


" Keymaps

map <C-f> /
nnoremap U <C-r>
ino ,, <esc>
cno ,, <c-c>
nmap <C-v> "*p
imap <C-v> <C-o>"*p
vmap <C-c> "*y

nmap ' ysiw
nmap ; ds
" Comments
vmap _ gcc
nmap _ gcc

" wrap
set wrap

"Toggle booleans
noremap r :ToggleBool<CR>

"window navigation
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" error navigation
nmap . :lnext<CR>
