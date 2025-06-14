-- NeoVim 設定
-- lazy.nvim によるプラグイン管理

-- 基本設定
vim.g.mapleader = "," -- リーダーキーを先に設定

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
require("lazy").setup({
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
    { "airblade/vim-gitgutter" },
    { "tpope/vim-fugitive" },

    -- カラースキーム
    { "altercation/vim-colors-solarized" },
    { "jonathanfilip/vim-lucius" },
    { "rebelot/kanagawa.nvim" },
    { "tssm/fairyfloss.vim" },

    -- ステータスライン
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

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

    -- 編集ツール
    { "easymotion/vim-easymotion" },
    { "editorconfig/editorconfig-vim" },
    { "mattn/emmet-vim" },
    { "tomtom/tcomment_vim" },
    { "tpope/vim-repeat" },
    { "tpope/vim-surround" },
    { "tpope/vim-unimpaired" },
    { "github/copilot.vim" },

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
})

-- 基本設定
vim.opt.encoding = "utf-8"
vim.opt.belloff = "all"
vim.opt.number = true
vim.opt.completeopt = "menuone"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.foldmethod = "marker"
vim.opt.helplang = "ja,en"
vim.opt.hidden = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.listchars = { tab = ">-", trail = "#", extends = ">", precedes = "<", nbsp = "%" }
vim.opt.matchpairs = "(:),{:},[:]"
-- 日本語の括弧ペアを追加（現在は Lua API で直接追加できないため vim.cmd を使用）
vim.cmd([[set matchpairs+=「:」,『:』,【:】,《:》,〈:〉,［:］,':',":",（:）]])
-- 空白行の ~ を非表示にする
vim.opt.fillchars:append({ eob = " " })
vim.opt.matchtime = 1
vim.opt.mouse = "a"
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.scrolloff = 2
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.showtabline = 2
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.spell = false
vim.opt.spelllang:append({ "cjk" })
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.updatetime = 300

-- カラースキーム（Lua API を使用）
vim.opt.background = "light"
vim.opt.syntax = "enable" -- syntax enable を Lua API で設定
vim.cmd([[colorscheme lucius]]) -- colorscheme は現在 Lua API で直接設定できないため vim.cmd を使用

-- リーダーキーは既に設定済み（上部で設定しているため削除）

-- 基本キーマップ（新しい vim.keymap.set API を使用）
vim.keymap.set({ "n", "v" }, "<leader>w", ":w<CR>", { noremap = true, desc = "Save file" })
vim.keymap.set({ "n", "v" }, "<leader>q", ":q<CR>", { noremap = true, desc = "Quit" })
vim.keymap.set({ "n", "v" }, "<leader>sv", ":source $MYVIMRC<CR>", { noremap = true, desc = "Source init.lua" })
vim.keymap.set({ "n", "v" }, "<leader>ev", ":edit $MYVIMRC<CR>", { noremap = true, desc = "Edit init.lua" })
vim.keymap.set({ "n", "v" }, "<leader>ee", ":e!<CR>", { noremap = true, desc = "Reload file" })
vim.keymap.set({ "n", "v" }, "<leader>g", ":Git<CR>", { noremap = true, desc = "Open Git" })

-- ターミナルからの脱出
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, desc = "Exit terminal mode" })

-- Neosnippet（新しい vim.keymap.set API を使用）
vim.keymap.set("", "<leader>k", "<Plug>(neosnippet_expand_or_jump)", { desc = "Expand snippet" })
vim.keymap.set("s", "<leader>k", "<Plug>(neosnippet_expand_or_jump)", { desc = "Expand snippet" })
vim.keymap.set("x", "<leader>k", "<Plug>(neosnippet_expand_target)", { desc = "Expand snippet target" })

-- tuskk による日本語入力（新しい vim.keymap.set API を使用）
vim.keymap.set("i", "<C-j>", [[<Cmd>call tuskk#toggle()<CR>]], { desc = "Toggle Japanese input" })
vim.keymap.set("c", "<C-j>", function()
    return vim.call("tuskk#cmd_buf")
end, { expr = true, desc = "Japanese input in command" })
vim.call("tuskk#initialize", {})

-- CocExplorer キーマッピング（新しい vim.keymap.set API を使用）
vim.keymap.set(
    "n",
    "<leader>e",
    ":CocCommand explorer<CR>",
    { noremap = true, silent = true, desc = "Open CocExplorer" }
)

-- ネイティブ LSP 設定
-- プラグインがまだインストールされていない場合に対応するため pcall でラップ
local has_lspconfig, lspconfig = pcall(require, "lspconfig")
local has_cmp, cmp = pcall(require, "cmp")
local has_luasnip, luasnip = pcall(require, "luasnip")
local has_lspkind, lspkind = pcall(require, "lspkind")
local has_mason, mason = pcall(require, "mason")

if has_mason then
    mason.setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    })

    -- 必要なツールを自動インストール
    local ensure_installed = {
        -- LSP
        "rust-analyzer",
        "typescript-language-server",
        "pyright",
        "eslint-lsp",
        "css-lsp",
        "html-lsp",
        "tailwindcss-language-server",
        "json-lsp",
        "lua-language-server",

        -- Linter
        "eslint_d",

        -- Formatter
        "prettier",
        "black",
        "rustfmt",

        -- DAP (デバッガー)
        "codelldb",
        "js-debug-adapter",
        "debugpy",
    }

    -- mason-registry を使用して必要なツールをインストール
    local mr = require("mason-registry")
    for _, tool in ipairs(ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
            p:install()
        end
    end

    -- mason-lspconfig の設定は後で servers 変数を使用するため、後で設定します
end

-- LSP セットアップ関数の定義
local on_attach = function(client, bufnr)
    -- フォーマットは conform.nvim で行うため、LSP のフォーマット機能を無効化
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- マッピング
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

    -- カーソルを置いた時に参照をハイライト
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd("CursorHold", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.clear_references()
            end,
        })
    end
end

-- 必要なプラグインが利用可能な場合のみ LSP を設定
if has_lspconfig and has_cmp and has_luasnip and has_lspkind then
    -- capabilities の設定
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if has_cmp then
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    end
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    }
    -- 直接 LSP サーバーを設定
    local servers =
        { "rust_analyzer", "ts_ls", "pyright", "eslint", "cssls", "html", "tailwindcss", "jsonls", "lua_ls" }

    -- mason-lspconfig は現在問題があるため、一時的に無効化
    -- if has_mason_lspconfig then
    --   mason_lspconfig.setup()
    -- end
    for _, server in ipairs(servers) do
        local ok, _ = pcall(function()
            lspconfig[server].setup({
                on_attach = on_attach,
            })
        end)
        if not ok then
            print("Failed to set up LSP server: " .. server)
        end
    end

    -- 言語サーバーの設定
    -- Rust
    local has_rust_tools, rust_tools = pcall(require, "rust-tools")
    if has_rust_tools then
        -- Mason でインストールされた rust-analyzer のパスを取得（lazy.nvim 対応版）
        local mason_bin_path = vim.fn.stdpath("data") .. "/mason/bin/"
        local rust_analyzer_path = nil

        -- OS に応じたパスを設定
        if vim.fn.has("win32") == 1 then
            rust_analyzer_path = mason_bin_path .. "rust-analyzer.cmd"
        else
            rust_analyzer_path = mason_bin_path .. "rust-analyzer"
        end

        -- ファイルが存在するか確認
        if vim.fn.filereadable(rust_analyzer_path) == 0 then
            rust_analyzer_path = nil
        end

        rust_tools.setup({
            server = {
                on_attach = on_attach,
                cmd = rust_analyzer_path and { rust_analyzer_path } or nil,
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = true,
                        check = {
                            command = "clippy",
                        },
                        procMacro = {
                            enable = true,
                        },
                        cargo = {
                            loadOutDirsFromCheck = true,
                        },
                        -- Rust ツールチェーンの設定
                        rustc = {
                            source = nil,
                        },
                    },
                },
            },
            -- デバッガの設定
            dap = {
                adapter = {
                    type = "executable",
                    command = "lldb-vscode",
                    name = "rt_lldb",
                },
            },
        })
    end

    -- TypeScript
    if has_lspconfig then
        pcall(function()
            lspconfig.ts_ls.setup({
                on_attach = on_attach,
                filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
                root_dir = function(fname)
                    return lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git")(fname)
                end,
                settings = {
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                },
            })
        end)

        -- ESLint
        pcall(function()
            lspconfig.eslint.setup({
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    -- ESLint 自動修正を有効化
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
                settings = {
                    packageManager = "npm",
                    autoFixOnSave = true,
                    format = true,
                },
            })
        end)

        -- CSS
        pcall(function()
            lspconfig.cssls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end)

        -- HTML
        pcall(function()
            lspconfig.html.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end)

        -- Tailwind CSS
        pcall(function()
            lspconfig.tailwindcss.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                root_dir = function(fname)
                    return lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts")(fname)
                        or lspconfig.util.root_pattern("package.json", ".git")(fname)
                end,
            })
        end)

        -- JSON
        pcall(function()
            lspconfig.jsonls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
        end)

        -- Lua
        pcall(function()
            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            -- LuaJIT for NeoVim
                            version = "LuaJIT",
                            path = vim.split(package.path, ";"),
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { "vim" },
                        },
                        workspace = {
                            -- Make the server aware of NeoVim runtime files
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                            },
                            maxPreload = 2000,
                            preloadFileSize = 50000,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
        end)
    end

    -- 補完の設定
    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
        }, {
            { name = "buffer" },
            { name = "path" },
        }),
        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol_text",
                maxwidth = 50,
                ellipsis_char = "...",
            }),
        },
    })

    -- 診断の設定
    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })

    -- 診断用キーマップ
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { noremap = true, silent = true })

    -- Trouble キーマップ
    local has_trouble, trouble = pcall(require, "trouble")
    if has_trouble then
        trouble.setup({
            position = "bottom",
            icons = true,
            mode = "workspace_diagnostics",
            action_keys = {
                close = "q",
                cancel = "<esc>",
                refresh = "r",
                jump = { "<cr>", "<tab>" },
                open_split = { "<c-x>" },
                open_vsplit = { "<c-v>" },
                open_tab = { "<c-t>" },
                jump_close = { "o" },
                toggle_mode = "m",
                toggle_preview = "P",
                hover = "K",
                preview = "p",
                close_folds = { "zM", "zm" },
                open_folds = { "zR", "zr" },
                toggle_fold = { "zA", "za" },
                previous = "k",
                next = "j",
            },
        })

        vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
        vim.keymap.set(
            "n",
            "<leader>xw",
            "<cmd>TroubleToggle workspace_diagnostics<cr>",
            { silent = true, noremap = true }
        )
        vim.keymap.set(
            "n",
            "<leader>xd",
            "<cmd>TroubleToggle document_diagnostics<cr>",
            { silent = true, noremap = true }
        )
        vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
        vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
        vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
    end
end -- End of LSP configuration block

-- より良いナビゲーションのための Telescope 設定
local has_telescope, telescope = pcall(require, "telescope")
if has_telescope then
    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                },
            },
        },
    })

    -- Telescope キーマップ
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { noremap = true })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { noremap = true })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { noremap = true })
    vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { noremap = true })
    vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { noremap = true })
end

-- ファイルタイプ固有の設定（新しい callback スタイルを使用）
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.ejs",
    callback = function()
        vim.opt.filetype = "html"
    end,
    desc = "EJS ファイルを HTML として扱う",
})

-- Treesitter 設定
local has_treesitter, treesitter = pcall(require, "nvim-treesitter.configs")
if has_treesitter then
    treesitter.setup({
        ensure_installed = {
            "typescript",
            "javascript",
            "tsx",
            "html",
            "css",
            "json",
            "yaml",
            "lua",
            "rust",
            "python",
            "markdown",
            "markdown_inline",
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                scope_incremental = "<S-CR>",
                node_decremental = "<BS>",
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["]c"] = "@class.outer",
                },
                goto_next_end = {
                    ["]F"] = "@function.outer",
                    ["]C"] = "@class.outer",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[c"] = "@class.outer",
                },
                goto_previous_end = {
                    ["[F"] = "@function.outer",
                    ["[C"] = "@class.outer",
                },
            },
        },
    })
end

-- lualine によるステータスライン設定（最新、NeoVim 推奨）
local function setup_statusline()
    local function tuskk_status()
        if vim.call("tuskk#is_enabled") then
            return "あ"
        else
            return "A"
        end
    end

    -- airline に似たスタイルで lualine を設定
    local has_lualine, lualine = pcall(require, "lualine")
    if not has_lualine then
        return
    end
    lualine.setup({
        options = {
            theme = "solarized_light",
            component_separators = { left = "", right = "" },
            section_separators = { left = "◤", right = "◢" },
            globalstatus = false,
        },
        sections = {
            lualine_a = {
                {
                    "mode",
                    fmt = function(str)
                        return str:sub(1, 1)
                    end,
                },
                { tuskk_status },
            },
            lualine_b = {
                function()
                    return os.date("%m/%d(%a) %H:%M:%S")
                end,
            },
            lualine_c = {
                "filename",
                "diagnostics",
            },
            lualine_x = {
                function()
                    local msg = ""
                    -- 非推奨の vim.lsp.get_active_clients() から vim.lsp.get_clients() に更新
                    local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
                    if #buf_clients == 0 then
                        return msg
                    end

                    local client_names = {}
                    for _, client in ipairs(buf_clients) do
                        table.insert(client_names, client.name)
                    end

                    return "[" .. table.concat(client_names, ", ") .. "]"
                end,
                "filetype",
            },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
    })
end

-- ステータスラインを設定
setup_statusline()

-- アイコン設定（新しい callback スタイルを使用）
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "fern", "nerdtree", "startify" },
    callback = function()
        if vim.fn.exists("*glyph_palette#apply") == 1 then
            vim.fn["glyph_palette#apply"]()
        end
    end,
    desc = "アイコンパレットを適用",
})

-- ファイルエクスプローラー設定（nvim-tree.lua）
local has_nvim_tree, nvim_tree = pcall(require, "nvim-tree")
if has_nvim_tree then
    nvim_tree.setup({
        sort_by = "case_sensitive",
        view = {
            width = 30,
        },
        renderer = {
            group_empty = true,
            icons = {
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                },
            },
        },
        filters = {
            dotfiles = false,
        },
        git = {
            enable = true,
            ignore = false,
        },
    })

    -- ファイルエクスプローラーのキーマッピング (NvimTree)（新しい vim.keymap.set API を使用）
    vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })
    vim.keymap.set(
        "n",
        "<leader>N",
        ":NvimTreeFindFile<CR>",
        { noremap = true, silent = true, desc = "Find file in NvimTree" }
    )
end

-- リンター設定（nvim-lint）
local has_lint, lint = pcall(require, "lint")
if has_lint then
    lint.linters_by_ft = {
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
    }

    -- ファイル保存時と開いた時に自動的にリントを実行
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
        callback = function()
            require("lint").try_lint()
        end,
    })

    -- キーマップでリントを手動実行
    vim.keymap.set("n", "<leader>l", function()
        require("lint").try_lint()
    end, { desc = "Lint current file" })
end

-- フォーマッタ設定（conform.nvim）
local has_conform, conform = pcall(require, "conform")
if has_conform then
    conform.setup({
        formatters_by_ft = {
            -- JavaScript/TypeScript
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            -- Web
            css = { "prettier" },
            scss = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            -- Rust
            rust = { "rustfmt" },
            -- Python
            python = { "black" },
            -- Lua
            lua = { "stylua" },
        },
        format_on_save = {
            -- `timeout_ms` を設定して、フォーマットが完了するまでの最大待機時間を指定
            timeout_ms = 500,
            lsp_fallback = true,
        },
    })

    -- キーマップでフォーマットを手動実行
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
        conform.format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
        })
    end, { desc = "Format file or range (in visual mode)" })
end

-- LSP キーマッピングはすでに on_attach 関数内で設定されているため、ここでは不要
-- グローバルなキーマッピングは必要に応じて追加

-- プラグイン設定
vim.g.gitgutter_enabled = true
vim.g.gundo_prefer_python3 = 1
-- rustfmt は conform.nvim で処理するため無効化
vim.g.rustfmt_autosave = 0
vim.g.termdebug_wide = 160

-- ac-adapter-rs-vim
vim.g.ac_adapter_rs_vim_workspace = "~/repos/ac-adapter-rs"
function ExpandAcAdapter(libname)
    local command = "procon-bundler find " .. vim.g.ac_adapter_rs_vim_workspace .. " " .. libname
    local result = vim.fn.system(command)
    if vim.v.shell_error ~= 0 then
        print(result)
    end
    vim.api.nvim_buf_set_lines(0, -1, -1, false, vim.fn.split(result, "\n"))
end

vim.api.nvim_create_user_command("Snip", function(opts)
    ExpandAcAdapter(opts.args)
end, { nargs = 1 })
