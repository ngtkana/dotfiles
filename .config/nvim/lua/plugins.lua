-- プラグイン定義

-- lazy.nvim のブートストラップ
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- 安定版を使用
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- プラグイン定義
return {
    -- スニペットと補完
    { "Shougo/deoplete.nvim", build = ":UpdateRemotePlugins" },
    { "Shougo/neosnippet-snippets" },
    { "Shougo/neosnippet.vim" },

    -- ファイル管理と UI
    { "nvim-tree/nvim-web-devicons" },
    { "scrooloose/nerdtree" },
    { "ryanoasis/vim-devicons" },
    { "tpope/vim-vinegar" },
    { "lambdalisue/glyph-palette.vim" },
    { "lambdalisue/nerdfont.vim" },

    -- Coc.nvim（LSP と CocExplorer 用）
    { "neoclide/coc.nvim", branch = "release" },

    -- Git 統合
    { "lewis6991/gitsigns.nvim" }, -- vim-gitgutter の代替
    { "tpope/vim-fugitive" },

    -- カラースキーム
    { "altercation/vim-colors-solarized" },
    { "jonathanfilip/vim-lucius" },
    { "rebelot/kanagawa.nvim" },
    { "tssm/fairyfloss.vim" },

    -- ステータスラインとタブライン
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } }, -- タブライン

    -- 言語サポート
    { "rust-lang/rust.vim" },
    { "rhysd/rust-doc.vim" },
    { "ron-rs/ron.vim" },
    { "leafgarland/typescript-vim" },
    { "peitalin/vim-jsx-typescript" },
    { "chrisbra/csv.vim" },
    { "elzr/vim-json" },
    { "qnighy/satysfi.vim" },

    -- LSP と補完 (NeoVim ネイティブ LSP)
    { "neovim/nvim-lspconfig" }, -- LSP 設定
    { "williamboman/mason.nvim" }, -- LSP サーバーインストーラー
    { "williamboman/mason-lspconfig.nvim", dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" } }, -- mason と lspconfig の連携
    { "hrsh7th/nvim-cmp" }, -- 補完フレームワーク
    { "hrsh7th/cmp-nvim-lsp" }, -- LSP 補完ソース
    { "hrsh7th/cmp-buffer" }, -- バッファ補完ソース
    { "hrsh7th/cmp-path" }, -- パス補完ソース
    { "hrsh7th/cmp-cmdline" }, -- コマンドライン補完ソース
    { "L3MON4D3/LuaSnip" }, -- スニペットエンジン
    { "saadparwaiz1/cmp_luasnip" }, -- スニペット補完ソース
    { "onsails/lspkind-nvim" }, -- 補完メニューのアイコン
    { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } }, -- 診断表示の改善
    { "simrat39/rust-tools.nvim", dependencies = { "neovim/nvim-lspconfig" } }, -- Rust 用追加ツール
    { "mfussenegger/nvim-lint" }, -- リンター統合
    { "stevearc/conform.nvim" }, -- フォーマッター統合
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } }, -- ファイルエクスプローラー
    { "b0o/schemastore.nvim" }, -- JSON スキーマ
    { "mfussenegger/nvim-dap" }, -- デバッガー
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } }, -- デバッガー UI
    { "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" } }, -- デバッガー仮想テキスト
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- 構文解析
    { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } }, -- 高度なテキストオブジェクト

    -- 編集ツール
    { "easymotion/vim-easymotion" },
    { "editorconfig/editorconfig-vim" },
    { "mattn/emmet-vim" },
    { "numToStr/Comment.nvim" }, -- tcomment_vim の代替
    { "tpope/vim-repeat" },
    { "kylechui/nvim-surround", dependencies = { "nvim-treesitter/nvim-treesitter" } }, -- vim-surround の代替
    { "tpope/vim-unimpaired" },
    { "github/copilot.vim" },
    { "windwp/nvim-autopairs" }, -- 自動括弧閉じ

    -- 検索とナビゲーション
    { "jremmen/vim-ripgrep" },
    { "junegunn/fzf" },
    { "majutsushi/tagbar" },
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } }, -- ファジーファインダー
    { "nvim-lua/plenary.nvim" }, -- Telescope に必要

    -- ユーティリティ
    { "sjl/gundo.vim" },
    { "tyru/open-browser.vim" },
    { "vim-jp/vimdoc-ja" },
    { "vim-utils/vim-man" },

    -- 日本語入力
    { "vim-denops/denops.vim" },
    { "kawarimidoll/tuskk.vim", dependencies = { "vim-denops/denops.vim" } },

    -- 一部のプラグインに必要
    { "roxma/nvim-yarp" },
    { "roxma/vim-hug-neovim-rpc" },
    
    -- UI 改善
    { "folke/which-key.nvim" }, -- キーマップのヘルプを表示
    { "lukas-reineke/indent-blankline.nvim" }, -- インデントガイド
    { "echasnovski/mini.icons", version = false }, -- which-key 用アイコン
}
