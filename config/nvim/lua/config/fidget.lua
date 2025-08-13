-- fidget.nvim 設定

local M = {}

function M.setup()
    local has_fidget, fidget = pcall(require, "fidget")
    if not has_fidget then
        return
    end

    -- legacy タグを使用しているため、古い設定方法を使用
    fidget.setup({
        text = {
            spinner = "pipe", -- アニメーション表示（"dots", "line", "pipe", "dots_negative", "dots_ellipsis"）
            done = "✓", -- 完了時の表示
            commenced = "Started", -- 開始時のメッセージ
            completed = "Completed", -- 完了時のメッセージ
        },
        align = {
            bottom = true, -- 下部に表示
            right = true, -- 右側に表示
        },
        timer = {
            spinner_rate = 125, -- スピナーの更新間隔（ms）
            fidget_decay = 2000, -- 表示が消えるまでの時間（ms）
            task_decay = 1000, -- タスク表示が消えるまでの時間（ms）
        },
        window = {
            relative = "win", -- 表示位置の基準（"win", "editor"）
            blend = 100, -- 背景の透明度（0-100）
            zindex = nil, -- ウィンドウの重なり順序
            border = "none", -- ボーダースタイル
        },
        fmt = {
            leftpad = true, -- 左側にパディングを追加
            stack_upwards = true, -- タスクを上に積み上げる
            max_width = 0, -- 最大幅（0は無制限）
            fidget = function(fidget_name, spinner)
                return string.format("%s %s", spinner, fidget_name)
            end,
            task = function(task_name, message, percentage)
                return string.format(
                    "%s%s [%s]",
                    message,
                    percentage and string.format(" (%s%%)", percentage) or "",
                    task_name
                )
            end,
        },
        debug = {
            logging = false, -- デバッグログを有効化
            strict = false, -- 厳密なエラーチェック
        },
    })
end

return M
