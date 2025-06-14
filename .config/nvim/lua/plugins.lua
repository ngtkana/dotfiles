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
    { "Shougo/deoplete.nvim", build = ":UpdateRemotePlugins", event = "InsertEnter" },
    { "Shougo/neosnippet-snippets", event = "InsertEnter" },
    { "Shougo/neosnippet.vim", event = "InsertEnter" },

    -- ファイル管理と UI
    { "nvim-tree/nvim-web-devicons" },
    { "scrooloose/nerdtree", cmd = "NERDTree" },
    { "ryanoasis/vim-devicons" },
    { "tpope/vim-vinegar", keys = { { "-", desc = "Open netrw" } } },
    { "lambdalisue/glyph-palette.vim", event = "VeryLazy" },
    { "lambdalisue/nerdfont.vim", event = "VeryLazy" },

    -- Coc.nvim（LSP と CocExplorer 用）
    { "neoclide/coc.nvim", branch = "release" },

    -- Git 統合
    { "lewis6991/gitsigns.nvim", event = "BufReadPre" }, -- vim-gitgutter の代替
    { "tpope/vim-fugitive", cmd = { "Git", "Gstatus", "Gblame", "Gdiff" } },

    -- カラースキーム
    { "altercation/vim-colors-solarized" },
    { "jonathanfilip/vim-lucius" },
    { "rebelot/kanagawa.nvim" },
    { "tssm/fairyfloss.vim" },

    -- ステータスラインとタブライン
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } }, -- タブライン

    -- 言語サポート
    { "rust-lang/rust.vim", ft = "rust" },
    { "rhysd/rust-doc.vim", ft = "rust" },
    { "ron-rs/ron.vim", ft = "ron" },
    { "leafgarland/typescript-vim", ft = { "typescript", "typescriptreact" } },
    { "peitalin/vim-jsx-typescript", ft = { "typescript", "typescriptreact" } },
    { "chrisbra/csv.vim", ft = "csv" },
    { "elzr/vim-json", ft = "json" },
    { "qnighy/satysfi.vim", ft = "satysfi" },

    -- LSP と補完 (NeoVim ネイティブ LSP)
    { "neovim/nvim-lspconfig" }, -- LSP 設定
    { "williamboman/mason.nvim" }, -- LSP サーバーインストーラー
    { "williamboman/mason-lspconfig.nvim", dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" } }, -- mason と lspconfig の連携
    { "folke/neodev.nvim" }, -- Neovim の Lua API 開発のためのヘルプ
    { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } }, -- TypeScript のサポート強化（最新版）
    { "j-hui/fidget.nvim", tag = "legacy" }, -- LSP の進行状況表示
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
    { "easymotion/vim-easymotion", keys = { { "<leader><leader>", desc = "EasyMotion" } } },
    { "editorconfig/editorconfig-vim", event = "BufReadPre" },
    { "mattn/emmet-vim", ft = { "html", "css", "javascript", "typescript", "typescriptreact", "javascriptreact" } },
    { "numToStr/Comment.nvim", event = "VeryLazy" }, -- tcomment_vim の代替
    { "tpope/vim-repeat", event = "VeryLazy" },
    { 
        "kylechui/nvim-surround", 
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = "VeryLazy"
    }, -- vim-surround の代替
    { "tpope/vim-unimpaired", event = "VeryLazy" },
    { "github/copilot.vim", event = "InsertEnter" },
    { "windwp/nvim-autopairs", event = "InsertEnter" }, -- 自動括弧閉じ

    -- 検索とナビゲーション
    { "jremmen/vim-ripgrep", cmd = "Rg" },
    { "junegunn/fzf", cmd = "FZF" },
    { "majutsushi/tagbar", cmd = "TagbarToggle" },
    { 
        "nvim-telescope/telescope.nvim", 
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Telescope",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
        }
    }, -- ファジーファインダー
    { "nvim-lua/plenary.nvim" }, -- Telescope に必要

    -- ユーティリティ
    { "sjl/gundo.vim", cmd = "GundoToggle" },
    { "tyru/open-browser.vim", cmd = { "OpenBrowser", "OpenBrowserSearch" } },
    { "vim-jp/vimdoc-ja", event = "VeryLazy" },
    { "vim-utils/vim-man", cmd = "Man" },

    -- 日本語入力
    { "vim-denops/denops.vim" },
    { "kawarimidoll/tuskk.vim", dependencies = { "vim-denops/denops.vim" } },

    -- 一部のプラグインに必要
    { "roxma/nvim-yarp" },
    { "roxma/vim-hug-neovim-rpc" },

    -- UI 改善
    { "folke/which-key.nvim", event = "VeryLazy" }, -- キーマップのヘルプを表示
    { "lukas-reineke/indent-blankline.nvim", event = "BufReadPost" }, -- インデントガイド
    { "echasnovski/mini.icons", version = false, event = "VeryLazy" }, -- which-key 用アイコン
    { 
        "goolord/alpha-nvim", 
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VimEnter"
    }, -- 起動画面
    { 
        "folke/noice.nvim", 
        dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
        event = "VeryLazy"
    }, -- コマンドラインと通知の改善
    { "rcarriga/nvim-notify", event = "VeryLazy" }, -- 通知システム
    { "stevearc/dressing.nvim", event = "VeryLazy" }, -- UI コンポーネントの見た目改善
}
