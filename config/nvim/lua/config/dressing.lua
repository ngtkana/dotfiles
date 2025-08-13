-- dressing.nvim 設定

local M = {}

function M.setup()
    local has_dressing, dressing = pcall(require, "dressing")
    if not has_dressing then
        return
    end

    dressing.setup({
        -- 入力ダイアログの設定
        input = {
            -- デフォルトで有効にするかどうか
            enabled = true,

            -- 入力ダイアログのデフォルトオプション
            default_prompt = "Input:", -- デフォルトのプロンプト
            title_pos = "left", -- タイトルの位置（"left", "center", "right"）
            insert_only = true, -- 挿入モードのみ許可
            start_in_insert = true, -- 挿入モードで開始

            -- ボーダーの設定
            border = "rounded", -- ボーダースタイル
            -- "none", "single", "double", "rounded", "solid", "shadow"
            relative = "cursor", -- 位置の基準

            -- ウィンドウの設定
            prefer_width = 40, -- 好ましい幅
            width = nil, -- 幅（nil の場合は自動）
            max_width = { 140, 0.9 }, -- 最大幅（絶対値と画面の割合）
            min_width = { 20, 0.2 }, -- 最小幅（絶対値と画面の割合）

            win_options = {
                winblend = 0, -- 透明度（0-100）
                winhighlight = "Normal:Normal,NormalNC:Normal",
            },

            -- マッピングの設定
            mappings = {
                n = {
                    ["<Esc>"] = "Close",
                    ["<CR>"] = "Confirm",
                },
                i = {
                    ["<C-c>"] = "Close",
                    ["<CR>"] = "Confirm",
                    ["<Up>"] = "HistoryPrev",
                    ["<Down>"] = "HistoryNext",
                },
            },

            -- オーバーライドの設定
            override = function(conf)
                -- 特定の関数呼び出しに対する設定のオーバーライド
                return conf
            end,

            -- 入力履歴の設定
            get_config = function(opts)
                if opts.kind == "auto" then
                    -- 自動的に種類を判断
                    if opts.title and opts.title:match("Rename") then
                        return { relative = "cursor" }
                    end
                end
                return {} -- デフォルト設定を使用
            end,
        },

        -- 選択ダイアログの設定
        select = {
            -- デフォルトで有効にするかどうか
            enabled = true,

            -- バックエンドの設定
            backend = { "telescope", "fzf", "builtin" },
            -- 優先順位: telescope > fzf > builtin

            -- Telescope の設定
            telescope = {
                layout_config = {
                    width = 0.5,
                    height = 0.6,
                },
            },

            -- 組み込みの選択ダイアログの設定
            builtin = {
                -- ボーダーの設定
                border = "rounded",
                -- "none", "single", "double", "rounded", "solid", "shadow"
                relative = "editor", -- 位置の基準

                -- ウィンドウの設定
                win_options = {
                    winblend = 0, -- 透明度（0-100）
                    winhighlight = "Normal:Normal,NormalNC:Normal",
                },

                -- ウィンドウの位置とサイズ
                width = nil, -- 幅（nil の場合は自動）
                max_width = { 140, 0.8 }, -- 最大幅（絶対値と画面の割合）
                min_width = { 40, 0.2 }, -- 最小幅（絶対値と画面の割合）
                height = nil, -- 高さ（nil の場合は自動）
                max_height = 0.9, -- 最大高さ（画面の割合）
                min_height = { 10, 0.2 }, -- 最小高さ（絶対値と画面の割合）

                -- マッピングの設定
                mappings = {
                    ["<Esc>"] = "Close",
                    ["<C-c>"] = "Close",
                    ["<CR>"] = "Confirm",
                },

                -- オーバーライドの設定
                override = function(conf)
                    -- 特定の関数呼び出しに対する設定のオーバーライド
                    return conf
                end,
            },

            -- 選択ダイアログの設定
            get_config = function(opts)
                if opts.kind == "codeaction" then
                    return {
                        backend = "telescope",
                        telescope = {
                            layout_config = {
                                width = 0.6,
                                height = 0.7,
                            },
                        },
                    }
                end
                return {} -- デフォルト設定を使用
            end,
        },
    })
end

return M
