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
let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'keymap', 'capslock', 'xkblayout', 'iminsert'])
let g:airline_section_error = airline#section#create([])
let g:airline_section_warning = airline#section#create([])
let g:airline_section_x = airline#section#create_right(['bookmark', 'tagbar', 'vista', 'gutentags', 'grepper', 'filetype'])
let g:airline_section_y = airline#section#create_right([])
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
let g:rustfmt_options = ""
let g:termdebug_wide = 160

colorscheme lucius

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

inoremap <silent><expr> <C-g> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>"
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <space>e <Cmd>CocCommand explorer<CR>
nnoremap <silent> K :call ShowDocumentation()<CR>
noremap <Leader>d <Plug>(coc-definition)<CR>
noremap <Leader>u :GundoToggle<CR>
xmap <leader>f <Plug>(coc-format)

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
if isdirectory(g:ac_adapter_rs_vim#workspace)
    source ~/repos/ac-adapter-rs-vim/plugin/ac_adapter_rs_vim.vim
    command! -narg=1 Snip :call ac_adapter_rs_vim#Fire(<args>)
endif
