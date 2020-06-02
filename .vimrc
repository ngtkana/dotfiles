" Vundle{{{
    set nocompatible
    filetype off
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'

    " 導入したいプラグインを以下に列挙
    " Plugin '[Github Author]/[Github repo]' の形式で記入

    " neosnippet
        Plugin 'Shougo/deoplete.nvim'
        if !has('nvim')
          Plugin 'roxma/nvim-yarp'
          Plugin 'roxma/vim-hug-neovim-rpc'
        endif

        Plugin 'Shougo/neosnippet.vim'
        Plugin 'Shougo/neosnippet-snippets'
    " ! neosnippet

    " rust
         Plugin 'rust-lang/rust.vim'
         Plugin 'racer-rust/vim-racer'

    " vim-clang: off
    "    Plugin 'vim-clang'
    call vundle#end()
    filetype plugin indent on
" !}}}
" options {{{
set noerrorbells
set expandtab
set noswapfile
set nobackup
set list
set listchars=tab:»-,trail:·,extends:»,precedes:«,nbsp:%
set number
set shiftwidth=4
set smartindent
set tabstop=4
set showmatch
set matchtime=1
set nowrap
set incsearch
set spell spelllang=en_us,cjk
set hidden
set foldmethod=marker
set backspace=indent,eol,start
set scrolloff=5
set matchpairs+=「:」,『:』,（:）,【:】,《:》,〈:〉,［:］,‘:’,“:”
syntax enable
" !}}}
command Copy :w !make c
command Remove !rm -r test
command -narg=1 Download url !oj d url

digraphs tg 129300  "🤔

colorscheme lucius

let mapleader = "\\"

" rust-fmt
let g:rustfmt_autosave = 1

" racer
let g:racer_cmd = '$HOME/.cargo/bin/racer'

" rusty-tags
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" neosnippet
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
    " \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " For conceal markers.
    if has('conceal')
      set conceallevel=2 concealcursor=niv
    endif
" ! neosnippet

" :! コマンド
cabbrev Sh ShellRead

" yupana
function  MOF(x)
	return float2nr(round(a:x * 1.15))
endfunction

