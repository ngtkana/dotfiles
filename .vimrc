set encoding=utf-8
scriptencoding utf-8

source $VIMRUNTIME/defaults.vim

call plug#begin()

""""""""""""""""""""""""""""""""
"     general settings         "
""""""""""""""""""""""""""""""""
let g:mapleader = "\\"
syntax enable                   " シンタックスハイライティング

""""""""""""""""""""""""""""""""
"     general keymappings      "
""""""""""""""""""""""""""""""""
noremap <Leader>sv :source $MYVIMRC<CR>
noremap <Leader>ev :edit $MYVIMRC<CR>

""""""""""""""""""""""""""""""""
"     characters               "
""""""""""""""""""""""""""""""""
set tabstop=4       " 何個分のスペースで 1 つのタブとしてカウントするか
set softtabstop=4   " <Tab> を押した時, 何個分のスペースを挿入するか
set shiftwidth=4    " 自動インデントの幅
set expandtab       " タブをスペースに展開する
set backspace=indent,eol,start  " <BS> で消せるもの　
set ambiwidth=double    " 全角を正しく表示したい
set matchpairs+=「:」,『:』,（:）,【:】,《:》,〈:〉,［:］,‘:’,“:”   " 括弧の定義
set list listchars=tab:>-,trail:#,extends:>,precedes:<,nbsp:%   " 特殊文字の表示方法

digraphs tg 129300  "🤔


"""""""""""""""""""""""""""""""""
"     editing                   "
"""""""""""""""""""""""""""""""""
Plug 'easymotion/vim-easymotion'        " モーション
Plug 'tomtom/tcomment_vim'      " コメントアウト支援（他の選択肢は、nerdcommenter）
Plug 'tpope/vim-repeat'         " ドットコマンドで、対応したプラグイン定義のコマンドも繰り返す
Plug 'tpope/vim-surround'       " 囲みコマンド
Plug 'tpope/vim-unimpaired'     " ショートカット

set scrolloff=5     " ここまでくると自動でスクロールがされる
set foldmethod=marker   " 折りたたみをマーカーで行う


"""""""""""""""""""""""""""""""""
"     snippet                   "
"""""""""""""""""""""""""""""""""
Plug 'Shougo/deoplete.nvim'     " neosnippet に必要らしいです。
Plug 'roxma/nvim-yarp'          " neosnippet に必要らしいです。
Plug 'roxma/vim-hug-neovim-rpc' " neosnippet に必要らしいです。
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <Leader>k     <Plug>(neosnippet_expand_or_jump)
smap <Leader>k     <Plug>(neosnippet_expand_or_jump)
xmap <Leader>k     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
snoremap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"


"""""""""""""""""""""""""""""""""
"     apperance                 "
"""""""""""""""""""""""""""""""""
set cursorline      " カーソル行をハイライティング
set number          " 行番号 set shiftwidth=4    " << や >> の移動距離
colorscheme lucius

Plug 'altercation/vim-colors-solarized'
set background=light    "または dark


"""""""""""""""""""""""""""""""""
"     navigation                "
"""""""""""""""""""""""""""""""""
Plug 'jremmen/vim-ripgrep'      " 検索（Rg コマンド）
Plug 'majutsushi/tagbar'        " コードの要約。API は TagberToggle
nmap <F8> :TagbarToggle<CR>


"""""""""""""""""""""""""""""""""
"     undo                      "
"""""""""""""""""""""""""""""""""
Plug 'sjl/gundo.vim'            " アンドゥツリー

noremap <Leader>u :GundoToggle<CR>

set undodir=~/.vim/undodir  " アンドゥファイルのためのディレクトリ
set undofile        " アンドゥファイルを作る

let g:gundo_prefer_python3 = 1                      " gundo

"""""""""""""""""""""""""""""""""
"     status line               "
"""""""""""""""""""""""""""""""""
" airline の wili に 全テーマのスクリーンショットがあります。
" https://github.com/vim-airline/vim-airline/wiki/Screenshots
let g:airline_theme = 'alduin'

Plug 'vim-airline/vim-airline'  " ステータスライン（他の選択肢は、Powerline, Lightline）
Plug 'vim-airline/vim-airline-themes'   " airline のテーマ

" 他にも ligntline という後発のステータスラインがあります。
" airline に関して感じている不満がいくつか解消されそうなので、導入を検討したいです。
" https://github.com/itchyny/lightline.vim
" https://itchyny.hatenablog.com/entry/20130828/1377653592


"""""""""""""""""""""""""""""""""
"     git                       "
"""""""""""""""""""""""""""""""""
let g:gitgutter_enabled = v:true

Plug 'tpope/vim-fugitive'       " Git 操作ができます。Gdiff などです。
Plug 'airblade/vim-gitgutter'   " 左に変更行の印を出せます。



"""""""""""""""""""""""""""""""""
"     file explorer             "
"""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree'      " ファイルエクスプローラ
Plug 'tpope/vim-vinegar'        " ファイルエクスプローラ

"""""""""""""""""""""""""""""""""
"     rust                      "
"""""""""""""""""""""""""""""""""
Plug 'rust-lang/rust.vim'       " Rust
Plug 'racer-rust/vim-racer'     " Rust

let g:rustfmt_autosave = 1                          " rust-fmt

" rusty-tags
augroup rusty-tags
  autocmd!
  autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
  autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
augroup END

let g:racer_cmd = '$HOME/.cargo/bin/racer'          " racer

"""""""""""""""""""""""""""""""""
"     TypeScript                "
"""""""""""""""""""""""""""""""""
Plug 'leafgarland/typescript-vim'       " typescript
Plug 'peitalin/vim-jsx-typescript'      " typescript （どうやらこっちもいるらしい）

"""""""""""""""""""""""""""""""""
"     man                       "
"""""""""""""""""""""""""""""""""
Plug 'vim-utils/vim-man'        " マニュアルを読む（Man コマンド）

"""""""""""""""""""""""""""""""""
"     sound                     "
"""""""""""""""""""""""""""""""""
set belloff=all     " これもエラーベルを鳴らさない（noerrorbells はだめなのか？）
set noerrorbells    " エラーベルを鳴らさない

"""""""""""""""""""""""""""""""""
"     autocompletion            "
"""""""""""""""""""""""""""""""""
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP 対応の補完

" coc-rls

" これで文字色は変わるけど、背景も黄色と赤にしたい
highlight CocWarningFloat ctermfg=White
highlight CocErrorFloat ctermfg=White

"""""""""""""""""""""""""""""""""
"     help in japanese          "
"""""""""""""""""""""""""""""""""
Plug 'vim-jp/vimdoc-ja'
set helplang=ja,en              " ヘルプを常に日本語で出します。

"""""""""""""""""""""""""""""""""
"     others                    "
"""""""""""""""""""""""""""""""""
set noswapfile      " swp ファイルを作らない
set nobackup        " 上書き時にバックアップを作らない
set smartindent     " カッコの後ろなどにインデント
set showmatch       " 対応する括弧をハイライト
set matchtime=1     " 対応する括弧のハイライトまでの遅延 (x 100 ms)
set nowrap          " 折返しをしない
set incsearch       " パターンの入力中に検索をする
set spell spelllang=en_us,cjk   " スペルチェック
set hidden          " 保存されていないバッファーがあっても新規バッファーを開くことができる

Plug 'editorconfig/editorconfig-vim'    " editorconfig を使う
Plug 'elzr/vim-json'            " JSON のハイライティング
Plug 'chrisbra/csv.vim'         " CSV 操作
Plug 'mattn/emmet-vim'          " html / css 入力支援
Plug 'ryanoasis/vim-devicons'   " アイコンのフォント

call plug#end()


"""""""""""""""""""""""""""""""""
"     after care                "
"""""""""""""""""""""""""""""""""
" colorscheme solarized

function! Airline_init_sections()
    " 'capslock' の前に 'spell'があった
    let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'keymap', 'capslock', 'xkblayout', 'iminsert'])
    let g:airline_section_x = airline#section#create_right(['bookmark', 'tagbar', 'vista', 'gutentags', 'grepper', 'filetype'])
    let g:airline_section_y = airline#section#create_right([])
    let g:airline_section_error = airline#section#create([])
    let g:airline_section_warning = airline#section#create([])
endfunction

call Airline_init_sections()

""""""""""""""""""""""""""""""""
"     ac-adapter-rs-vim        "
""""""""""""""""""""""""""""""""
let g:ac_adapter_rs_path = '~/procon/ac-adapter-rs'
source ~/procon/ac-adapter-rs-vim/plugin/ac_adapter_rs_vim.vim
command! -narg=1 Snip :call ac_adapter_rs_vim#Fire(<args>)
