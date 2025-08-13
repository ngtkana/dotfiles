-- nvim-autopairs 設定

local M = {}

function M.setup()
    local has_autopairs, autopairs = pcall(require, "nvim-autopairs")
    if not has_autopairs then
        return
    end

    autopairs.setup({
        check_ts = true, -- treesitter を使用して括弧を閉じるかどうか
        ts_config = {
            lua = { "string", "source" }, -- lua の文字列と source ノードでは括弧を閉じない
            javascript = { "string", "template_string" }, -- javascript の文字列とテンプレート文字列では括弧を閉じない
            java = false, -- java では無効にする
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" }, -- 無効にするファイルタイプ
        fast_wrap = {
            map = "<M-e>", -- 括弧を素早く閉じるためのマッピング
            chars = { "{", "[", "(", '"', "'" }, -- 括弧の種類
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""), -- 括弧を閉じるパターン
            offset = 0, -- オフセット
            end_key = "$", -- 終了キー
            keys = "qwertyuiopzxcvbnmasdfghjkl", -- 使用するキー
            check_comma = true, -- カンマをチェックするかどうか
            highlight = "PmenuSel", -- ハイライトグループ
            highlight_grey = "LineNr", -- グレーのハイライトグループ
        },
    })

    -- nvim-cmp との連携
    local has_cmp, cmp = pcall(require, "cmp")
    if has_cmp then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
end

return M
