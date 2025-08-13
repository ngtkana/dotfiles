-- nvim-surround 設定

local M = {}

function M.setup()
    local has_surround, surround = pcall(require, "nvim-surround")
    if not has_surround then
        return
    end

    surround.setup({
        keymaps = {
            insert = "<C-g>s", -- インサートモードで囲みを追加
            insert_line = "<C-g>S", -- インサートモードで行全体を囲む
            normal = "ys", -- ノーマルモードで囲みを追加
            normal_cur = "yss", -- ノーマルモードで行全体を囲む
            normal_line = "yS", -- ノーマルモードで行全体を囲み、インデントを追加
            normal_cur_line = "ySS", -- ノーマルモードで行全体を囲み、インデントを追加
            visual = "S", -- ビジュアルモードで選択範囲を囲む
            visual_line = "gS", -- ビジュアルモードで行全体を囲む
            delete = "ds", -- 囲みを削除
            change = "cs", -- 囲みを変更
            change_line = "cS", -- 行全体の囲みを変更
        },
        aliases = {
            ["a"] = ">", -- HTML タグ用のエイリアス
            ["b"] = ")", -- 括弧用のエイリアス
            ["B"] = "}", -- 中括弧用のエイリアス
            ["r"] = "]", -- 角括弧用のエイリアス
            ["q"] = { '"', "'", "`" }, -- クォート用のエイリアス
            ["s"] = { "}", "]", ")", ">", '"', "'", "`" }, -- すべての囲み文字用のエイリアス
        },
        highlight = {
            duration = 0, -- ハイライトの持続時間（ミリ秒）
        },
        move_cursor = "begin", -- カーソル位置を囲みの開始位置に移動
        indent_lines = function(start, stop)
            -- インデントを追加する関数
            local b = vim.api.nvim_get_current_buf()
            vim.cmd(string.format("silent normal! %dG=%dG", start, stop))
        end,
    })
end

return M
