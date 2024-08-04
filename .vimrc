set encoding=utf-8
scriptencoding utf-8

if !has('nvim')
    source $VIMRUNTIME/defaults.vim
endif

packadd termdebug

call plug#begin()
Plug 'Shougo/deoplete.nvim'     " neosnippet->
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'airblade/vim-gitgutter'   " 左に変更行の印を出せます。
Plug 'altercation/vim-colors-solarized'
Plug 'chrisbra/csv.vim'         " CSV 操作
Plug 'easymotion/vim-easymotion'        " モーション
Plug 'editorconfig/editorconfig-vim'    " editorconfig を使う
Plug 'elzr/vim-json'            " JSON のハイライティング
Plug 'enricobacis/vim-airline-clock'    " 時計
Plug 'github/copilot.vim'
Plug 'jonathanfilip/vim-lucius' " colorscheme lucs
Plug 'jremmen/vim-ripgrep'      " 検索（Rg コマンド）
Plug 'junegunn/fzf'
Plug 'leafgarland/typescript-vim'       " typescript
Plug 'majutsushi/tagbar'        " コードの要約。API は TagberToggle
Plug 'mattn/emmet-vim'          " html / css 入力支援
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP 対応の補完
Plug 'peitalin/vim-jsx-typescript'      " typescript （どうやらこっちもいるらしい）
Plug 'qnighy/satysfi.vim'       " SATySFi
Plug 'rebelot/kanagawa.nvim'    " カラースキーム kanagawa
Plug 'rhysd/rust-doc.vim'       " :RustDoc でドキュメントを見る
Plug 'ron-rs/ron.vim'           " .ron
Plug 'roxma/nvim-yarp'          " neosnippet->
Plug 'roxma/vim-hug-neovim-rpc' " neosnippet->
Plug 'rust-lang/rust.vim'
Plug 'ryanoasis/vim-devicons'   " アイコンのフォント
Plug 'scrooloose/nerdtree'      " ファイルエクスプローラ
Plug 'sjl/gundo.vim'            " アンドゥツリー
Plug 'tomtom/tcomment_vim'      " コメントアウト支援（他の選択肢は、nerdcommenter）
Plug 'tpope/vim-fugitive'       " Git 操作ができます。Gdiff などです。
Plug 'tpope/vim-repeat'         " ドットコマンドで、対応したプラグイン定義のコマンドも繰り返す
Plug 'tpope/vim-surround'       " 囲みコマンド
Plug 'tpope/vim-unimpaired'     " ショートカット
Plug 'tpope/vim-vinegar'        " press '-' to open the directory
Plug 'tssm/fairyfloss.vim'
Plug 'tyru/open-browser.vim'    " ブラウザを開く
Plug 'vim-airline/vim-airline'  " ステータスライン（他の選択肢は、Powerline, Lightline）
Plug 'vim-airline/vim-airline-themes'   " airline のテーマ
Plug 'vim-denops/denops.vim'    " Write plugins in deno
Plug 'vim-jp/vimdoc-ja'
Plug 'vim-utils/vim-man'        " マニュアルを読む（Man コマンド）
if !has('nvim')
    Plug 'bfrg/vim-jqplay'          " :Jqplay など
    Plug 'skanehira/denops-gh.vim'  " GitHub
endif
call plug#end()

" set ambiwidth=double  " double にすると '' が全角になってつらい
set background=light    " light/dark theme
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
set noswapfile          " swp ファイルを作らない
set nowrap              " 折返しをしない
set number              " 行番号 set shiftwidth=4
set scrolloff=2         " ここまでくると自動でスクロールがされる
set shiftwidth=4        " 自動インデントの幅
set showmatch           " 対応する括弧をハイライト
set showtabline=2       " タブページのラベルを常に表示する
set smartindent         " カッコの後ろなどにインデント
set softtabstop=4       " <Tab> を押した時, 何個分のスペースを挿入するか
set spell               " スペルチェックあり
set spelllang+=cjk      " 日本語がエラーになるのがいやなのv
set tabstop=4           " 何個分のスペースで 1 つのタブとしてカウントするか
set undodir=~/.vim/undodir      " アンドゥファイルのためのディレクトリ
set undofile            " アンドゥファイルを作る
set updatetime=300      " <CursorHold> が発動するまでの時間 (x 1 ms)

" Favorite airline themes
" alduin
" base16_adwaita
" base16_mocha
" base16_ocean
" fairyfloss
" sol
" zenburn
let g:airline#extensions#clock#auto = 0
let g:airline#extensions#clock#format = '%m/%d %a %H:%M %S'
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#default#enabled = 1
let g:airline_theme = 'base16_adwaita'
let g:airline_powerline_fonts = 1
let g:airline#extensions#default#layout = [
  \ [ 'a', 'b', 'c' ],
  \ [ 'x', 'y', 'z']
  \ ]
let g:airline_mode_map = {
  \ '__'     : '-',
  \ 'c'      : 'C',
  \ 'i'      : 'I',
  \ 'ic'     : 'I',
  \ 'ix'     : 'I',
  \ 'n'      : 'N',
  \ 'multi'  : 'M',
  \ 'ni'     : 'N',
  \ 'no'     : 'N',
  \ 'R'      : 'R',
  \ 'Rv'     : 'R',
  \ 's'      : 'S',
  \ 'S'      : 'S',
  \ ''     : 'S',
  \ 't'      : 'T',
  \ 'v'      : 'V',
  \ 'V'      : 'V',
  \ ''     : 'V',
  \ }
function! AirlineInit()
  let g:airline_symbols.linenr = ''
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.colnr = ':'
  let spc = g:airline_symbols.space
  let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'keymap', 'capslock', 'xkblayout', 'iminsert'])
  let g:airline_section_b = airline#section#create(['%{airline#extensions#clock#get()}'])
  let g:airline_section_c = airline#section#create(['coc_status', 'lsp_progress'])
  let g:airline_section_x = airline#section#create_right(['coc_current_function', 'bookmark', 'scrollbar', 'tagbar', 'taglist', 'vista', 'gutentags', 'gen_tags', 'omnisharp', 'grepper'])
  let g:airline_section_y = airline#section#create(['%<', 'path', spc, 'readonly'])
  let g:airline_section_z = airline#section#create(['linenr', 'maxlinenr', 'colnr'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
let g:fsharp#automatic_reload_workspace = 1
let g:fsharp#linter = 1
let g:fsharp#show_signature_on_cursor_move = 1
let g:fsharp#unused_declarations_analyzer = 1
let g:fsharp#unused_opens_analyzer = 1
let g:gitgutter_enabled = v:true
let g:gundo_prefer_python3 = 1                      " gundo
let g:mapleader = ","
let g:rustfmt_autosave = 1
let g:termdebug_wide = 160

syntax enable                   " シンタックスハイライティング
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

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

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

autocmd BufNewFile,BufRead *.ejs set filetype=html

map     <silent><leader>k  <Plug>(neosnippet_expand_or_jump)
nmap    <silent><leader>a  <Plug>(coc-codeaction-selected)
nmap    <silent><leader>cl <Plug>(coc-codelens-action)
nmap    <silent><leader>e  <Cmd>CocCommand explorer<CR>
nmap    <silent><leader>qf <Plug>(coc-fix-current)
nmap    <silent><leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap    <silent><leader>re <Plug>(coc-codeaction-refactor)
nmap    <silent><leader>rn <Plug>(coc-rename)
noremap <leader>ee :e!<CR>
noremap <leader>ev :edit $MYVIMRC<CR>
noremap <leader>g  :Git<CR>
noremap <leader>q  :q<CR>
noremap <leader>w  :w<CR>
noremap <leader>sv :source $MYVIMRC<CR>
smap    <silent><leader>k  <Plug>(neosnippet_expand_or_jump)
xmap    <silent><leader>a  <Plug>(coc-codeaction-selected)
xmap    <silent><leader>k  <Plug>(neosnippet_expand_target)
xmap    <silent><leader>r  <Plug>(coc-codeaction-refactor-selected)

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
