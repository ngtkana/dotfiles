-- gitsigns.nvim 設定

local M = {}

function M.setup()
    local has_gitsigns, gitsigns = pcall(require, "gitsigns")
    if not has_gitsigns then
        return
    end

    gitsigns.setup({
        signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
        signcolumn = true, -- サインカラムに表示するかどうか
        numhl = false, -- 行番号をハイライトするかどうか
        linehl = false, -- 行全体をハイライトするかどうか
        word_diff = false, -- 単語単位の差分を表示するかどうか
        watch_gitdir = {
            interval = 1000, -- ミリ秒単位の更新間隔
            follow_files = true, -- ファイルの移動を追跡するかどうか
        },
        attach_to_untracked = true, -- 未追跡ファイルにアタッチするかどうか
        current_line_blame = false, -- 現在の行の blame を表示するかどうか
        current_line_blame_opts = {
            virt_text = true, -- 仮想テキストとして表示するかどうか
            virt_text_pos = "eol", -- 行末に表示するかどうか
            delay = 1000, -- ミリ秒単位の遅延
            ignore_whitespace = false, -- 空白を無視するかどうか
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6, -- サインの優先度
        update_debounce = 100, -- ミリ秒単位の更新間隔
        status_formatter = nil, -- ステータスフォーマッター
        max_file_length = 40000, -- 最大ファイル長
        preview_config = {
            -- プレビューウィンドウのオプション
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        yadm = {
            enable = false, -- yadm を有効にするかどうか
        },
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- ナビゲーション
            map("n", "]c", function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Next hunk" })

            map("n", "[c", function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Previous hunk" })

            -- アクション
            map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
            map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
            map("v", "<leader>gs", function()
                gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { desc = "Stage selected hunk" })
            map("v", "<leader>gr", function()
                gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { desc = "Reset selected hunk" })
            map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
            map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
            map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
            map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
            map("n", "<leader>gb", function()
                gs.blame_line({ full = true })
            end, { desc = "Blame line" })
            map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
            map("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
            map("n", "<leader>gD", function()
                gs.diffthis("~")
            end, { desc = "Diff this ~" })
            map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle deleted" })

            -- テキストオブジェクト
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
        end,
    })
end

return M
