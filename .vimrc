syntax on

set nu rnu
set noerrorbells
set hidden
set tabstop=3 softtabstop=3
set shiftwidth=3
set expandtab
set smartindent
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set clipboard+=unnamedplus
set encoding=UTF-8
set t_Co=256
set cmdheight=2
set updatetime=300
set shortmess+=c
highlight ColorColumn ctermbg=0 guibg=lightgrey
" highlight CocErrorHighLight ctermfg=Red guifg=#ff0000

call plug#begin('~/.vim/plugged')
" Gruvbox for colorscheme
Plug 'gruvbox-community/gruvbox'

" Vim Fugitive
Plug 'tpope/vim-fugitive'
" Vim Airline
Plug 'vim-airline/vim-airline'

" CoC vim
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

colorscheme gruvbox
set background=dark

" Leader Key
let mapleader = " "
let maplocalleader = ","

" Navigate
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Open Windows and terminals
nnoremap <leader>v :vsp<CR>
nnoremap <leader>s :sp<CR>
nnoremap <leader>t :term<CR>

" Edit and source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Some tricks in normal mode
nnoremap <leader>w viw
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>< viw<esc>a><esc>bi<<esc>lel
nnoremap <C-U> viwUe
nnoremap <C-L> viwue

" Operator Maps
onoremap in( :<C-U>normal! f(vi(<cr>
onoremap il( :<C-U>normal! F(vi(<cr>
onoremap in[ :<C-U>normal! f[vi[<cr>
onoremap il[ :<C-U>normal! F[vi[<cr>
onoremap in{ :<C-U>normal! f{vi{<cr>
onoremap il{ :<C-U>normal! F{vi{<cr>

" Visual mode
vnoremap - U
vnoremap _ u

" Insert mode
inoremap <C-D> <ESC>ddi
inoremap <C-U> <ESC>viwUea
inoremap <C-L> <ESC>viwuea

" Resize windows
nnoremap <leader>r+ :resize +5<CR>
nnoremap <leader>r- :resize -5<CR>
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>

autocmd FileType python nnoremap <buffer> <localleader>c I# <ESC>
autocmd FileType vim nnoremap <buffer> <localleader>c I" <ESC>
autocmd BufNewFile * :write
autocmd FileType javascript nnoremap <buffer> <localleader>c I// <ESC>
autocmd FileType typescript nnoremap <buffer> <localleader>c I// <ESC>


" CoC configurations
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

autocmd CursorHold * silent call CocActionAsync('highlight')

hi! CocErrorHighLight ctermfg=Red guifg=#ff0000
hi! CocWarningSign ctermfg=Brown guifg=#ff922b
hi! CocInfoSign ctermfg=Yellow guifg=#fab005

" netwr instead of Nerdtree
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_banner = 0
let g:netrw_list_hide = &wildignore

nnoremap <leader>e :Explore <CR>
nnoremap <leader>ve :Vexplore <CR>
nnoremap <leader>se :Sexplore <CR>

" fzf
nnoremap <leader>bf :Buffers<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>gf :GFiles<CR>
nnoremap <leader>gs :GFiles?<CR>

" Kite
let g:kite_supported_languages = ['*']
let g:kite_auto_complete=0
let g:kite_tab_complete=1
autocmd CompleteDone * if !pumvisible() | pclose | endif

" tab
nnoremap <leader>tp :tabprevious<CR>
nnoremap <leader>tn :tabnext<CR>
