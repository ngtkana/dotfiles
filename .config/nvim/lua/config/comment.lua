-- Comment.nvim 設定

local M = {}

function M.setup()
    local has_comment, comment = pcall(require, "Comment")
    if not has_comment then
        return
    end

    comment.setup({
        padding = true, -- コメントの前後にスペースを追加するかどうか
        sticky = true, -- カーソル位置を維持するかどうか
        ignore = nil, -- 無視する行のパターン
        toggler = {
            -- 現在の行をコメントアウト/解除するキーマッピング
            line = "gcc", -- 行コメント
            block = "gbc", -- ブロックコメント
        },
        opleader = {
            -- 操作モードでコメントアウト/解除するキーマッピング
            line = "gc", -- 行コメント
            block = "gb", -- ブロックコメント
        },
        extra = {
            -- 現在の行の上/下にコメントを追加するキーマッピング
            above = "gcO", -- 上に追加
            below = "gco", -- 下に追加
            eol = "gcA", -- 行末に追加
        },
        mappings = {
            -- キーマッピングを有効にするかどうか
            basic = true, -- 基本的なマッピング
            extra = true, -- 追加のマッピング
            extended = false, -- 拡張マッピング
        },
        pre_hook = nil, -- コメントアウト前に実行する関数
        post_hook = nil, -- コメントアウト後に実行する関数
    })

    -- treesitter との連携
    local has_ts_comment, ts_comment = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
    if has_ts_comment then
        comment.setup({
            pre_hook = ts_comment.create_pre_hook(),
        })
    end
end

return M
