if &compatible
 set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  let s:toml = '~/dotfiles/nvim/dein.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif

" for nerdtree
let NERDTreeStatusline="%{matchstr(getline('.'), '\\s\\zs\\w\\(.*\\)')}"
let NERDTreeShowHidden=1

" python setting
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = '/usr/local/bin/python'

" for git
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
hi GitGutterAdd ctermfg=Green

" for emmet
let g:user_emmet_leader_key='<c-t>'

autocmd QuickFixCmdPost *grep* cwindow

" for vue

" autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript
autocmd FileType vue syntax sync fromstart

" nopaste
autocmd InsertLeave * set nopaste

" encoding
set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8
" display
set fillchars+=vert:│ 
set number
" valid backspace
set backspace=indent,eol,start
" smartindent
set smartindent
" Tab文字を半角スペースにする
set expandtab
set tabstop=2
" ファイル名表示
set statusline=%F
" 変更チェック表示
set statusline+=%1*\ %m\ %*
" 読み込み専用かどうか表示
set statusline+=%r
" ヘルプページなら[HELP]と表示
set statusline+=%h
" プレビューウインドウなら[Prevew]と表示
set statusline+=%w
" これ以降は右寄せ表示
set statusline+=%=
" file encoding
set statusline+=[ENC=%{&fileencoding}]
" 現在行数/全行数
set statusline+=[ROW=%l/%L][COL=%c]
" ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set statusline+=%{FugitiveStatusline()}

set laststatus=2
set infercase
"不可視文字
set listchars=tab:»-,trail:.,extends:»,precedes:«,nbsp:%,eol:↲
set list
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索ハイライト設定
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" grep default
set grepprg=grep\ --exclude-dir=.git
" コマンドラインの補完
set wildmode=list:longest
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" マウス対応
set mouse=a
" wildcard対象外
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
" クリップボード
set clipboard+=unnamedplus
" others
set shiftwidth=2
set noswapfile

" color
colorscheme tender
syntax on
hi Normal guibg=NONE ctermbg=NONE
hi link EndOfBuffer Ignore
hi NonText ctermfg=Black guifg=Black
hi LineNr ctermfg=grey
hi VertSplit cterm=NONE ctermfg=Black
hi StatusLine cterm=none ctermfg=white ctermbg=Black cterm=NONE
hi StatusLineNC ctermbg=Black ctermfg=Grey cterm=NONE
hi TabLine ctermbg=Black ctermfg=Black
hi TabLineSel ctermbg=Black ctermfg=Black
hi TabLineFill ctermbg=Black ctermfg=Black
hi Visual term=reverse cterm=reverse guibg=Grey
hi User1 ctermbg=NONE ctermfg=darkcyan gui=BOLD
hi SpecialKey ctermfg=Black guifg=Black

" mapping
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>
inoremap <silent> jj <ESC>
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [ []<Left>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap ` ``<LEFT>
nnoremap j gj
nnoremap k gk
nnoremap ; :
nnoremap : ;
nnoremap <space>c :<C-u>setlocal cursorline! cursorcolumn!<CR>
noremap <Space>h ^
noremap <Space>l $
noremap <Space><CR> o<ESC>
nmap <silent> <Space>i ;GoInfo<CR>
inoremap <expr><C-j> pumvisible()?  "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible()?  "\<C-p>" : "\<C-k>"
nnoremap <silent>fd <C-w>v<C-w>w :call feedkeys("gd")<CR>

" tab
nmap t [Tag]
map <silent> [Tag]o ;tablast <bar> tabnew<CR>
map <silent> [Tag]x ;tabclose<CR>
map <silent> [Tag]j ;tabnext<CR>
map <silent> [Tag]k ;tabprevious<CR>

" command line
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" golang
" let g:go_metalinter_autosave = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_types = 1
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" let g:go_version_warning = 0
" let g:go_snippet_engine = "neosnippet"
au FileType go setlocal sw=4 ts=4 sts=4 noet

