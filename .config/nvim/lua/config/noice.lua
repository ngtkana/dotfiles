-- noice.nvim 設定

local M = {}

function M.setup()
    local has_noice, noice = pcall(require, "noice")
    if not has_noice then
        return
    end

    noice.setup({
        -- コマンドラインの設定
        cmdline = {
            enabled = true, -- コマンドラインを有効化
            view = "cmdline_popup", -- コマンドラインの表示方法
            opts = {
                -- ポップアップの位置と外観
                position = {
                    row = -2,
                    col = "50%",
                },
                size = {
                    width = "auto",
                    height = "auto",
                },
                border = {
                    style = "rounded",
                },
            },
        },

        -- メッセージの設定
        messages = {
            -- メッセージの表示方法
            enabled = true, -- メッセージを有効化
            view = "notify", -- メッセージの表示方法
            view_error = "notify", -- エラーメッセージの表示方法
            view_warn = "notify", -- 警告メッセージの表示方法
            view_history = "messages", -- 履歴の表示方法
            view_search = "virtualtext", -- 検索結果の表示方法
        },

        -- 通知の設定
        notify = {
            -- 通知の有効化
            enabled = true,
            view = "notify",
        },

        -- LSP の設定
        lsp = {
            -- LSP の進行状況表示
            progress = {
                enabled = true,
                format = "lsp_progress",
                format_done = "lsp_progress_done",
                throttle = 1000 / 30, -- 更新頻度（ms）
            },
            -- LSP のメッセージ表示
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            -- LSP のホバー表示
            hover = {
                enabled = true,
                silent = false, -- エラーを表示するかどうか
                view = nil, -- ビューを指定（nil の場合はデフォルト）
            },
            -- LSP のシグネチャヘルプ
            signature = {
                enabled = true,
                auto_open = {
                    enabled = true,
                    trigger = true, -- 自動的に開くかどうか
                    luasnip = true, -- LuaSnip と連携するかどうか
                    throttle = 50, -- 更新頻度（ms）
                },
                view = nil, -- ビューを指定（nil の場合はデフォルト）
            },
            -- LSP のメッセージ
            message = {
                enabled = true,
                view = "notify",
                opts = {},
            },
            -- LSP のドキュメント
            documentation = {
                view = "hover",
                opts = {
                    lang = "markdown",
                    replace = true,
                    render = "plain",
                    format = { "{message}" },
                    win_options = { concealcursor = "n", conceallevel = 3 },
                },
            },
        },

        -- マークダウンの設定
        markdown = {
            hover = {
                ["|(%S-)|"] = vim.cmd.help, -- ヘルプリンク
                ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- Markdown リンク
            },
            highlights = {
                ["|%S-|"] = "@text.reference",
                ["@%S+"] = "@parameter",
                ["^%s*(Parameters:)"] = "@text.title",
                ["^%s*(Return:)"] = "@text.title",
                ["^%s*(See also:)"] = "@text.title",
                ["{%S-}"] = "@parameter",
            },
        },

        -- 健全性チェックの設定
        health = {
            checker = true, -- 健全性チェッカーを有効化
        },

        -- スマート移動の設定
        smart_move = {
            enabled = true, -- スマート移動を有効化
            excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
        },

        -- プリセットの設定
        presets = {
            bottom_search = true, -- 検索を画面下部に表示
            command_palette = true, -- コマンドパレットを使用
            long_message_to_split = true, -- 長いメッセージを分割
            inc_rename = false, -- インクリメンタルリネームを使用しない
            lsp_doc_border = true, -- LSP ドキュメントにボーダーを表示
        },

        -- 無視するイベント
        routes = {
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                opts = { skip = true },
            },
        },
    })

    -- キーマッピング
    vim.keymap.set("n", "<leader>nl", function()
        require("noice").cmd("last")
    end, { desc = "Noice Last Message" })

    vim.keymap.set("n", "<leader>nh", function()
        require("noice").cmd("history")
    end, { desc = "Noice History" })

    vim.keymap.set("n", "<leader>na", function()
        require("noice").cmd("all")
    end, { desc = "Noice All" })

    vim.keymap.set("n", "<leader>nd", function()
        require("noice").cmd("dismiss")
    end, { desc = "Dismiss All Notifications" })
end

return M
