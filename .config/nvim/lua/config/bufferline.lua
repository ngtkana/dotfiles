-- bufferline.nvim 設定

local M = {}

function M.setup()
    local has_bufferline, bufferline = pcall(require, "bufferline")
    if not has_bufferline then
        return
    end

    bufferline.setup({
        options = {
            mode = "buffers", -- "buffers" または "tabs"
            numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both" | function
            close_command = "bdelete! %d", -- バッファを閉じるコマンド
            right_mouse_command = "bdelete! %d", -- 右クリックでバッファを閉じる
            left_mouse_command = "buffer %d", -- 左クリックでバッファを選択
            middle_mouse_command = nil, -- 中クリックの動作
            indicator = {
                icon = "▎", -- インジケーターアイコン
                style = "icon", -- "icon" | "underline" | "none"
            },
            buffer_close_icon = "",
            modified_icon = "●",
            close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
            max_name_length = 18,
            max_prefix_length = 15, -- プレフィックスの最大長
            tab_size = 18,
            diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc"
            diagnostics_update_in_insert = false, -- インサートモードで診断を更新するかどうか
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local s = " "
                for e, n in pairs(diagnostics_dict) do
                    local sym = e == "error" and " " or (e == "warning" and " " or "")
                    s = s .. n .. sym
                end
                return s
            end,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "left",
                    separator = true,
                    highlight = "Directory",
                },
            },
            color_icons = true, -- アイコンに色を付けるかどうか
            show_buffer_icons = true, -- バッファアイコンを表示するかどうか
            show_buffer_close_icons = true, -- バッファ閉じるアイコンを表示するかどうか
            -- show_buffer_default_icon は非推奨のため削除
            show_close_icon = true, -- 閉じるアイコンを表示するかどうか
            show_tab_indicators = true, -- タブインジケーターを表示するかどうか
            persist_buffer_sort = true, -- バッファソートを保持するかどうか
            separator_style = "thin", -- "slant" | "thick" | "thin" | { 'any', 'any' }
            enforce_regular_tabs = false, -- タブサイズを強制するかどうか
            always_show_bufferline = true, -- バッファラインを常に表示するかどうか
            sort_by = "id", -- 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function
        },
        highlights = {
            buffer_selected = {
                bold = true,
                italic = false,
            },
        },
    })

    -- キーマッピング
    vim.keymap.set("n", "<leader>bp", ":BufferLinePick<CR>", { noremap = true, silent = true, desc = "Pick buffer" })
    vim.keymap.set(
        "n",
        "<leader>bc",
        ":BufferLinePickClose<CR>",
        { noremap = true, silent = true, desc = "Pick buffer to close" }
    )
    vim.keymap.set(
        "n",
        "<leader>bl",
        ":BufferLineCloseLeft<CR>",
        { noremap = true, silent = true, desc = "Close buffers to the left" }
    )
    vim.keymap.set(
        "n",
        "<leader>br",
        ":BufferLineCloseRight<CR>",
        { noremap = true, silent = true, desc = "Close buffers to the right" }
    )
    vim.keymap.set(
        "n",
        "<leader>bo",
        ":BufferLineCloseOthers<CR>",
        { noremap = true, silent = true, desc = "Close other buffers" }
    )
    vim.keymap.set(
        "n",
        "<leader>bj",
        ":BufferLineCyclePrev<CR>",
        { noremap = true, silent = true, desc = "Previous buffer" }
    )
    vim.keymap.set(
        "n",
        "<leader>bk",
        ":BufferLineCycleNext<CR>",
        { noremap = true, silent = true, desc = "Next buffer" }
    )
    vim.keymap.set(
        "n",
        "<leader>bJ",
        ":BufferLineMovePrev<CR>",
        { noremap = true, silent = true, desc = "Move buffer left" }
    )
    vim.keymap.set(
        "n",
        "<leader>bK",
        ":BufferLineMoveNext<CR>",
        { noremap = true, silent = true, desc = "Move buffer right" }
    )

    -- gt/gT でバッファを切り替えるためのキーマッピング
    vim.keymap.set("n", "gt", ":BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
    vim.keymap.set("n", "gT", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
end

return M
