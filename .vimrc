set encoding=utf-8
scriptencoding utf-8

source $VIMRUNTIME/defaults.vim

packadd termdebug

call plug#begin()
Plug 'Shougo/deoplete.nvim'     " neosnippet->
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'airblade/vim-gitgutter'   " 左に変更行の印を出せます。
Plug 'altercation/vim-colors-solarized'
Plug 'bfrg/vim-jqplay'          " :Jqplay など
Plug 'chrisbra/csv.vim'         " CSV 操作
Plug 'easymotion/vim-easymotion'        " モーション
Plug 'editorconfig/editorconfig-vim'    " editorconfig を使う
Plug 'elzr/vim-json'            " JSON のハイライティング
Plug 'github/copilot.vim'
Plug 'jonathanfilip/vim-lucius' " colorscheme lucs
Plug 'jremmen/vim-ripgrep'      " 検索（Rg コマンド）
Plug 'junegunn/fzf'
Plug 'leafgarland/typescript-vim'       " typescript
Plug 'majutsushi/tagbar'        " コードの要約。API は TagberToggle
Plug 'mattn/emmet-vim'          " html / css 入力支援
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP 対応の補完
Plug 'peitalin/vim-jsx-typescript'      " typescript （どうやらこっちもいるらしい）
Plug 'rebelot/kanagawa.nvim'    " カラースキーム kanagawa
Plug 'ron-rs/ron.vim'           " .ron
Plug 'roxma/nvim-yarp'          " neosnippet->
Plug 'roxma/vim-hug-neovim-rpc' " neosnippet->
Plug 'ryanoasis/vim-devicons'   " アイコンのフォント
Plug 'scrooloose/nerdtree'      " ファイルエクスプローラ
Plug 'sjl/gundo.vim'            " アンドゥツリー
Plug 'skanehira/denops-gh.vim'  " GitHub
Plug 'tomtom/tcomment_vim'      " コメントアウト支援（他の選択肢は、nerdcommenter）
Plug 'tpope/vim-fugitive'       " Git 操作ができます。Gdiff などです。
Plug 'tpope/vim-repeat'         " ドットコマンドで、対応したプラグイン定義のコマンドも繰り返す
Plug 'tpope/vim-surround'       " 囲みコマンド
Plug 'tpope/vim-unimpaired'     " ショートカット
Plug 'tpope/vim-vinegar'        " press '-' to open the directory
Plug 'tyru/open-browser.vim'    " ブラウザを開く
Plug 'vim-airline/vim-airline'  " ステータスライン（他の選択肢は、Powerline, Lightline）
Plug 'vim-airline/vim-airline-themes'   " airline のテーマ
Plug 'vim-denops/denops.vim'    " Write plugins in deno
Plug 'vim-jp/vimdoc-ja'
Plug 'vim-utils/vim-man'        " マニュアルを読む（Man コマンド）
call plug#end()

syntax enable                   " シンタックスハイライティング

noremap <Leader>sv :source $MYVIMRC<CR>
noremap <Leader>ev :edit $MYVIMRC<CR>
noremap <Leader>ee :e!<CR>
noremap <Leader>w :w<CR>

set ambiwidth=double            " 全角を正しく表示したい
set backspace=indent,eol,start  " <BS> で消せるもの　
set belloff=all         " これもエラーベルを鳴らさない（noerrorbells はだめなのか？）
set completeopt=menuone " 補完メニューを開かない
set cursorline          " カーソル行をハイライティング
set expandtab           " タブをスペースに展開する
set foldmethod=marker   " 折りたたみをマーカーで行う
set helplang=ja,en      " ヘルプを常に日本語で出します。
set hidden              " 保存されていないバッファーがあっても新規バッファーを開くことができる
set incsearch           " パターンの入力中に検索をする
set list listchars=tab:>-,trail:#,extends:>,precedes:<,nbsp:%   " 特殊文字の表示方法
set matchpairs+=「:」,『:』,（:）,【:】,《:》,〈:〉,［:］,‘:’,“:”   " 括弧の定義
set matchtime=1         " 対応する括弧のハイライトまでの遅延 (x 100 ms)
set mouse=a
set nobackup            " 上書き時にバックアップを作らない
set noerrorbells        " エラーベルを鳴らさない
set nospell             " スペルチェックなし
set noswapfile          " swp ファイルを作らない
set nowrap              " 折返しをしない
set number              " 行番号 set shiftwidth=4
set scrolloff=2         " ここまでくると自動でスクロールがされる
set shiftwidth=4        " 自動インデントの幅
set showmatch           " 対応する括弧をハイライト
set showtabline=2       " タブページのラベルを常に表示する
set smartindent         " カッコの後ろなどにインデント
set softtabstop=4       " <Tab> を押した時, 何個分のスペースを挿入するか
set tabstop=4           " 何個分のスペースで 1 つのタブとしてカウントするか
set undodir=~/.vim/undodir      " アンドゥファイルのためのディレクトリ
set undofile            " アンドゥファイルを作る

let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#default#enabled = 1
let g:airline#extensions#default#layout = [
    \ [ 'z', 'b', 'c' ],
    \ [ 'x', 'y', 'a', 'error', 'warning']
    \ ]
let g:airline_theme = 'alduin'
let g:fsharp#automatic_reload_workspace = 1
let g:fsharp#linter = 1
let g:fsharp#show_signature_on_cursor_move = 1
let g:fsharp#unused_declarations_analyzer = 1
let g:fsharp#unused_opens_analyzer = 1
let g:gitgutter_enabled = v:true
let g:gundo_prefer_python3 = 1                      " gundo
let g:mapleader = "\\"
let g:rustfmt_autosave = 1
let g:termdebug_wide = 160

colorscheme lucius

inoremap <silent><expr> <C-g> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>"

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" mine
nmap <space>e <Cmd>CocCommand explorer<CR>
noremap <Leader>e :CocCommand rust-analyzer.explainError<CR>


autocmd BufNewFile,BufRead *.ejs set filetype=html

""""""""""""""""""""""""""""""""
"     neosnippet               "
""""""""""""""""""""""""""""""""

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <leader>k     <Plug>(neosnippet_expand_or_jump)
smap <leader>k     <Plug>(neosnippet_expand_or_jump)
xmap <leader>k     <Plug>(neosnippet_expand_target)

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

""""""""""""""""""""""""""""""""
"     coc-rust-analyzer        "
""""""""""""""""""""""""""""""""
nmap <leader>a v<Plug>(coc-codeaction-selected)

""""""""""""""""""""""""""""""""
"     ac-adapter-rs-vim        "
""""""""""""""""""""""""""""""""
let g:ac_adapter_rs_vim#workspace = '~/repos/ac-adapter-rs'
function! ExpandAcAdapter(libname) abort
  let command = "procon-bundler find " . g:ac_adapter_rs_vim#workspace . " " . a:libname
  let result = system(command)
  if v:shell_error
    echo l:result
  endif
  call append(line('$'), split(l:result, '\n'))
endfunction
command! -narg=1 Snip :call ExpandAcAdapter(<args>)
