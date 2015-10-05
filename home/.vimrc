syntax enable
set background=dark
set undodir=~/.vim/undofiles
set backupdir=~/.vim/tildafiles
colorscheme railscasts
set encoding=utf-8
set autoindent
set smartindent
filetype plugin indent on
set nu

"Yank and copy to clipboard!
set clipboard=unnamed,autoselect

"ハイライトを消す
nnoremap <ESC><ESC> :nohlsearch<CR>

"NeoBundle Scripts-----------------------------
if has('vim_starting')
	if &compatible
		set nocompatible               " Be iMproved
	endif
	" Required:
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:

" ファイルを簡単に開く
NeoBundle "ctrlpvim/ctrlp.vim"

" Rubyファイルでendを自動で挿入
NeoBundle 'tpope/vim-endwise'

" Git管理
NeoBundle 'tpope/vim-fugitive'

" Rails管理
NeoBundle 'tpope/vim-rails'

" 無駄なスペースをハイライト
NeoBundle 'bronson/vim-trailing-whitespace'

" コード補完
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'marcus/rsense'
NeoBundle 'supermomonga/neocomplete-rsense.vim'
NeoBundle 'violetyk/neocomplete-php.vim'
NeoBundle 'davidhalter/jedi-vim'

" コードジャンプ
NeoBundle 'szw/vim-tags'

" 非同期処理
NeoBundle 'tpope/vim-dispatch'

" 構文チェック
NeoBundle 'scrooloose/syntastic'

" statusline/tablineのカスタマイズ
NeoBundle 'itchyny/lightline.vim'

" Treeファイラー
NeoBundle 'scrooloose/nerdtree'

" Zen Coding
NeoBundle 'mattn/emmet-vim'

" 実行
NeoBundle 'thinca/vim-quickrun'

" なめらかにスクロール
NeoBundle 'yonchu/accelerated-smooth-scroll'

" You can specify revision/branch/tag.
"NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

"-------------------------------
"Rsense
"-------------------------------
let g:rsenseHome = "/usr/local/Cellar/rsense/0.3/libexec/"
let g:rsenseUseOmniFunc = 1

"-----------------------------
" neocomplete.vim
"-----------------------------
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

"For python
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType python setlocal completeopt-=preview
let g:jedi#auto_vim_configuration = 0
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

"-----------------------------
" vim-tags.vim
"-----------------------------
nnoremap <Space>p :CtrlPTag<cr>
let g:vim_tags_use_vim_dispatch = 1
let g:neocomplete_php_locale = 'ja'

"-----------------------------
" syntastics.vim
"-----------------------------
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_python_python_exec = 'python3'

"-----------------------------
" lightline.vim
"-----------------------------
let g:lightline = {
			\ 'colorscheme': 'solarized',
			\ 'mode_map': { 'c': 'NORMAL' },
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
			\   'right': [ ['date', 'day', 'time' ],
			\              [ 'percent', 'lineinfo',  'syntastic',  ],
			\              [ 'fileformat', 'fileencoding', 'filetype' ]],
			\ },
			\ 'component_function': {
			\   'modified': 'MyModified',
			\   'readonly': 'MyReadonly',
			\   'fugitive': 'MyFugitive',
			\   'filename': 'MyFilename',
			\   'fileformat': 'MyFileformat',
			\   'filetype': 'MyFiletype',
			\   'fileencoding': 'MyFileencoding',
			\   'mode': 'MyMode',
			\   'date': 'MyDate',
			\   'day' : 'MyDay',
			\   'time': 'MyTime',
			\ },
			\ 'separator': { 'left': '⮀', 'right': '⮂' },
			\ 'subseparator': { 'left': '⮁', 'right': '⮃' }
			\ }
let g:lightline.tabline = {
			\ 'left': [ [ 'tabs' ] ],
			\ 'right': [ [ 'close' ] ] }

function! MyModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! MyReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
	return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
				\ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
				\  &ft == 'unite' ? unite#get_status_string() :
				\  &ft == 'vimshell' ? vimshell#get_status_string() :
				\ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
				\ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
function! MyFugitive()
	if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
		let _ = fugitive#head()
		return strlen(_) ? '⭠ '._ : ''
	endif
	return ''
endfunction
function! MyFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction
function! MyFileencoding()
	return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction
function! MyMode()
	return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
function! MyDate()
	return strftime("%m/%d")
endfunction
function! MyTime()
	return strftime("%H:%M")
endfunction
function! MyDay()
	return strftime("%a")
endfunction

"CtrP競合回避
let g:ctrlp_buffer_func = {'enter': 'CtrlPEnter'}
function! CtrlPEnter()
	let w:lightline = 0
endfunction

"-----------------------------
" vim-rails.vim
"-----------------------------
autocmd User Rails.view*                 NeoSnippetSource ~/.vim/snippet/ruby.rails.view.snip
autocmd User Rails.controller*           NeoSnippetSource ~/.vim/snippet/ruby.rails.controller.snip
autocmd User Rails/db/migrate/*          NeoSnippetSource ~/.vim/snippet/ruby.rails.migrate.snip
autocmd User Rails/config/routes.rb      NeoSnippetSource ~/.vim/snippet/ruby.rails.route.snip

"-----------------------------
" neosnippet.vim
"-----------------------------

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=i
endif
let s:default_snippet = neobundle#get_neobundle_dir() . '/neosnippet/autoload/neosnippet/snippets'
let s:my_snippet = '~/.vim/snippet'
let g:neosnippet#snippets_directory = s:my_snippet
let g:neosnippet#snippets_directory = s:default_snippet . ',' . s:my_snippet

"-----------------------------
" NERDTree.vim
"-----------------------------
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"-----------------------------
" emmet-vim
"-----------------------------
let g:user_emmet_settings = {
			\  'lang' : 'ja',
			\}

"-----------------------------
" vim-quickrun
"-----------------------------
map <F5> <ESC>:QuickRun<CR>

