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

call denite#custom#map('insert', "<C-j>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-k>", '<denite:move_to_previous_line>')


" for nerdtree
let NERDTreeStatusline="%{matchstr(getline('.'), '\\s\\zs\\w\\(.*\\)')}"
let NERDTreeShowHidden=1

" for git
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
hi GitGutterAdd ctermfg=Green

" for emmet
let g:user_emmet_leader_key='<c-t>'

autocmd QuickFixCmdPost *grep* cwindow

" for vue
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
autocmd FileType vue syntax sync fromstart

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
imap <C-l> <Plug>(neosnippet_expand_or_jump)
smap <C-l> <Plug>(neosnippet_expand_or_jump)
inoremap <silent> jj <ESC>
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [ []<Left>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap ` ``<LEFT>
nmap <silent> <C-g> ;<C-u>Denite grep<CR>
nmap <silent> <space>r ;<C-u>Denite file_mru<CR>
nmap <silent> <space>y ;<C-u>Denite neoyank<CR>
nmap <silent> ;y ;<C-u>Denite neoyank<CR>
nmap <silent> <C-p> ;<C-u>Denite file_rec<CR>
nnoremap <silent><C-n> :NERDTreeToggle<CR>
nnoremap j gj
nnoremap k gk
nnoremap ; :
nnoremap : ;
nnoremap <space>c :<C-u>setlocal cursorline! cursorcolumn!<CR>
noremap <Space>h ^
noremap <Space>l $
noremap <Space><CR> o<ESC>
inoremap <expr><C-j> pumvisible()?  "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible()?  "\<C-p>" : "\<C-k>"

" denite
call denite#custom#map('_', "<C-s>",
  \ '<denite:do_action:vsplit>')
call denite#custom#map('insert', "<C-s>",
  \ '<denite:do_action:vsplit>')
call denite#custom#map('_', "<C-v>",
  \ '<denite:do_action:split>')
call denite#custom#map('insert', "<C-v>",
  \ '<denite:do_action:split>')
call denite#custom#map('insert',
  \ "jj", '<denite:enter_mode:normal>')
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'default_opts', ['--follow', '--no-group', '--no-color'])

" golang
let g:go_metalinter_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_version_warning = 0
let g:go_snippet_engine = "neosnippet"
au FileType go setlocal sw=4 ts=4 sts=4 noet

