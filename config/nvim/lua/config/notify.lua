-- nvim-notify 設定

local M = {}

function M.setup()
    local has_notify, notify = pcall(require, "notify")
    if not has_notify then
        return
    end

    -- 基本設定
    notify.setup({
        -- アニメーションスタイル
        -- "fade", "slide", "fade_in_slide_out", "static"
        stages = "fade",

        -- デフォルトのタイムアウト（ミリ秒）
        timeout = 3000,

        -- 通知の最大数
        max_width = 80,
        max_height = 20,

        -- 通知の背景色
        background_colour = "#000000",

        -- アイコン
        icons = {
            ERROR = "",
            WARN = "",
            INFO = "",
            DEBUG = "",
            TRACE = "✎",
        },

        -- 通知の位置
        -- "top_right", "top_left", "bottom_right", "bottom_left", "top", "bottom", "left", "right"
        position = "top_right",
    })

    -- vim.notify を nvim-notify で置き換え
    vim.notify = notify

    -- ハイライトグループの設定
    vim.cmd([[
        highlight NotifyERRORBorder guifg=#8A1F1F
        highlight NotifyWARNBorder guifg=#79491D
        highlight NotifyINFOBorder guifg=#4F6752
        highlight NotifyDEBUGBorder guifg=#8B8B8B
        highlight NotifyTRACEBorder guifg=#4F3552
        highlight NotifyERRORIcon guifg=#F70067
        highlight NotifyWARNIcon guifg=#F79000
        highlight NotifyINFOIcon guifg=#A9FF68
        highlight NotifyDEBUGIcon guifg=#8B8B8B
        highlight NotifyTRACEIcon guifg=#D484FF
        highlight NotifyERRORTitle guifg=#F70067
        highlight NotifyWARNTitle guifg=#F79000
        highlight NotifyINFOTitle guifg=#A9FF68
        highlight NotifyDEBUGTitle guifg=#8B8B8B
        highlight NotifyTRACETitle guifg=#D484FF
    ]])

    -- 通知履歴を表示するキーマッピング
    vim.keymap.set("n", "<leader>tn", function()
        require("telescope").extensions.notify.notify()
    end, { desc = "Notification History" })
end

return M
