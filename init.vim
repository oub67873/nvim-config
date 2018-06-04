if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein')


  call dein#add('Shougo/deoplete.nvim')
  "  call dein#add('Shougo/deol.nvim') " wtf
  "	call dein#add('Shougo/denite.nvim') " wtf
  call dein#add('HerringtonDarkholme/yats.vim')
  call dein#add('mhartington/nvim-typescript')
  call dein#add('scrooloose/nerdtree')
  call dein#add('tmux-plugins/vim-tmux')
  call dein#add('christoomey/vim-tmux-navigator')
  " call dein#add('sbdchd/neoformat')
  call dein#add('vim-airline/vim-airline')
  call dein#add('907th/vim-auto-save') "my addition
  " call dein#add('junegunn/vim-easy-align') 

  " auto closing quotations/brackets
  call dein#add('itmammoth/doorboy.vim')

  " highlights the enclosing html/xml tags
  call dein#add('valloric/MatchTagAlways', {'on_ft': 'html'})

  " emmet
  call dein#add('mattn/emmet-vim')

  call dein#add('terryma/vim-multiple-cursors')

  " zen mode
  call dein#add('junegunn/goyo.vim')


  if dein#check_install()
    call dein#install()
    let pluginsExist=1
  endif


  call dein#end()
  call dein#save_state()
endif


"" EDITOR

syntax on
set number
filetype plugin indent on
set tabstop=2 shiftwidth=2 expandtab
set backspace=indent,eol,start

" indent on save (gg=G)
augroup autoindent
  au!
  autocmd BufWritePre * :undojoin | normal migg=G`i 
augroup END


"" PLUGINS

" AutoSave
let g:auto_save = 1

" Doorboy
let g:doorboy_additional_brackets = {
      \ 'html': ['<>']
      \ }

" Emmet 
" - remapping <C-y>, just doesn't cut it.
function! s:expand_html_tab()
  " try to determine if we're within quotes or tags.
  " if so, assume we're in an emmet fill area.
  let line = getline('.')
  if col('.') < len(line)
    let line = matchstr(line, '[">][^<"]*\%'.col('.').'c[^>"]*[<"]')
    if len(line) >= 2
      return "\<C-n>"
    endif
  endif
  " expand anything emmet thinks is expandable.
  if emmet#isExpandable()
    return emmet#expandAbbrIntelligent("\<tab>")
    " return "\<C-y>,"
  endif
  " return a regular tab character
  return "\<tab>"
endfunction

autocmd FileType html,css,scss imap <silent><buffer><expr><tab> <sid>expand_html_tab()
let g:user_emmet_mode='a'
let g:user_emmet_complete_tag = 0
let g:user_emmet_install_global = 0
autocmd FileType html,css,scss EmmetInstall


" Nerdtree
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

map <C-S-e> :NERDTreeToggle<CR> " Ctrl-Shift-E

" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1

" Navigate between vim buffers and tmux panels ------------------------------{{{

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-;> :TmuxNavigatePrevious<cr>
tmap <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
tmap <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
tmap <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
tmap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
tmap <C-;> <C-\><C-n>:TmuxNavigatePrevious<cr>

"}}}

" Code formatting -----------------------------------------------------------{{{


" ,f to format code, requires formatters: read the docs
"noremap <silent> <leader>f :Neoformat<CR>
"let g:standard_prettier_settings = {
"      \ 'exe': 'prettier',
"      \ 'args': ['--stdin', '--stdin-filepath', '%:p', '--single-quote'],
"      \ 'stdin': 1,
"      \ }
" }}}

"set formatoptions+=t

"let g:neoformat_typescript_prettier = g:standard_prettier_settings
"let g:neoformat_enabled_typescript = ['prettier']

"vnoremap <leader>ga <Plug>(EasyAlign)
