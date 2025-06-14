-- which-key.nvim 設定

local M = {}

function M.setup()
    local has_which_key, which_key = pcall(require, "which-key")
    if not has_which_key then
        return
    end

    which_key.setup({
        plugins = {
            marks = true, -- マークを表示
            registers = true, -- レジスタを表示
            spelling = {
                enabled = false, -- スペルチェックを有効にする
                suggestions = 20, -- 候補の数
            },
            presets = {
                operators = true, -- 演算子のヘルプを追加
                motions = true, -- モーションのヘルプを追加
                text_objects = true, -- テキストオブジェクトのヘルプを追加
                windows = true, -- ウィンドウのヘルプを追加
                nav = true, -- ナビゲーションのヘルプを追加
                z = true, -- z コマンドのヘルプを追加
                g = true, -- g コマンドのヘルプを追加
            },
        },
        icons = {
            breadcrumb = "»", -- 階層の区切り文字
            separator = "➜", -- グループとマッピングの区切り文字
            group = "+", -- グループアイコン
        },
        keys = {
            scroll_down = "<c-d>", -- ポップアップをスクロールダウン
            scroll_up = "<c-u>", -- ポップアップをスクロールアップ
        },
        window = {
            border = "rounded", -- none, single, double, shadow, rounded
            margin = { 1, 0, 1, 0 }, -- 上下左右のマージン
            padding = { 2, 2, 2, 2 }, -- 上下左右のパディング
            winblend = 0, -- 透明度（0-100）
        },
        layout = {
            height = { min = 4, max = 25 }, -- 最小と最大の高さ
            width = { min = 20, max = 50 }, -- 最小と最大の幅
            spacing = 3, -- 間隔
            align = "left", -- 配置（left, center, right）
        },
        -- filter オプションを削除（エラーの原因）
        show_help = true, -- ヘルプを表示するかどうか
        show_keys = true, -- キーを表示するかどうか
        triggers = { -- 自動的にトリガーするキー
            { mode = { "n", "v" }, "<leader>" },
            { mode = { "n", "v" }, "g" },
            { mode = { "n", "v" }, "z" },
            { mode = { "n", "v" }, "]" },
            { mode = { "n", "v" }, "[" },
        },
    })

    -- リーダーキーのグループ登録（最新の推奨形式）
    which_key.register({
        f = { 
            name = "+Find/Telescope",
            f = { "<cmd>Telescope find_files<cr>", "Find Files" },
            g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
            b = { "<cmd>Telescope buffers<cr>", "Buffers" },
            h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
            s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
            r = { "<cmd>Telescope lsp_references<cr>", "References" },
            d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
            o = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
            c = { "<cmd>Telescope commands<cr>", "Commands" },
            k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
            e = { "<cmd>Telescope file_browser<cr>", "File Browser" },
            p = { "<cmd>Telescope project<cr>", "Projects" },
        },
        g = { name = "+Git" },
        l = { name = "+LSP" },
        t = { name = "+Toggle" },
        w = { name = "+Workspace" },
        x = { name = "+Diagnostics/Quickfix" },
        b = { name = "+Buffer" },
    }, { prefix = "<leader>" })
end

return M
