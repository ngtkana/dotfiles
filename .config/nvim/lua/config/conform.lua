-- conform.nvim 設定

local M = {}

function M.setup()
    local has_conform, conform = pcall(require, "conform")
    if not has_conform then
        return
    end

    conform.setup({
        formatters_by_ft = {
            -- JavaScript/TypeScript
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            -- Web
            css = { "prettier" },
            scss = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            -- Rust
            rust = { "rustfmt" },
            -- Python
            python = { "black" },
            -- Lua
            lua = { "stylua" },
        },
        format_on_save = {
            -- `timeout_ms` を設定して、フォーマットが完了するまでの最大待機時間を指定
            timeout_ms = 500,
            lsp_fallback = true,
        },
    })

    -- キーマップでフォーマットを手動実行
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
        conform.format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
        })
    end, { desc = "Format file or range (in visual mode)" })
end

return M
