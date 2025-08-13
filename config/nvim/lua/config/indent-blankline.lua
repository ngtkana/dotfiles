-- indent-blankline.nvim 設定

local M = {}

function M.setup()
    local has_ibl, ibl = pcall(require, "ibl")
    if not has_ibl then
        return
    end

    -- 最新バージョンの indent-blankline.nvim (v3.x) の設定
    ibl.setup({
        indent = {
            char = "│", -- インデントラインに使用する文字
            tab_char = "│", -- タブのインデントラインに使用する文字
        },
        scope = {
            enabled = true, -- スコープのハイライトを有効にする
            show_start = true, -- スコープの開始位置を表示する
            show_end = false, -- スコープの終了位置を表示する
            injected_languages = true, -- 埋め込み言語のスコープを表示する
            highlight = { "Function", "Label" }, -- スコープのハイライトグループ
            priority = 500, -- スコープのハイライト優先度
        },
        exclude = {
            filetypes = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
            buftypes = {
                "terminal",
                "nofile",
                "quickfix",
                "prompt",
            },
        },
    })

    -- キーマッピング
    vim.keymap.set("n", "<leader>ti", ":IBLToggle<CR>", { noremap = true, silent = true, desc = "Toggle indent lines" })
end

return M
