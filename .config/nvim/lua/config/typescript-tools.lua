-- typescript-tools.nvim 設定

local M = {}

function M.setup()
    local has_typescript_tools, typescript_tools = pcall(require, "typescript-tools")
    if not has_typescript_tools then
        return
    end

    typescript_tools.setup({
        -- TypeScript サーバーのオプション
        settings = {
            -- TypeScript ツールの設定
            expose_as_code_action = "all", -- すべてのコードアクションを公開
            -- 診断設定
            tsserver_file_preferences = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
        -- キーマッピング
        handlers = {
            ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
                if result.diagnostics == nil then
                    return
                end
                -- デフォルトの処理を実行
                vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
            end,
        },
    })

    -- キーマッピング
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        callback = function()
            -- TypeScript 固有のコマンド
            vim.keymap.set(
                "n",
                "<leader>li",
                "<cmd>TSToolsAddMissingImports<CR>",
                { buffer = true, desc = "Add Missing Imports" }
            )
            vim.keymap.set(
                "n",
                "<leader>lo",
                "<cmd>TSToolsOrganizeImports<CR>",
                { buffer = true, desc = "Organize Imports" }
            )
            vim.keymap.set("n", "<leader>lu", "<cmd>TSToolsRemoveUnused<CR>", { buffer = true, desc = "Remove Unused" })
            vim.keymap.set("n", "<leader>lf", "<cmd>TSToolsFixAll<CR>", { buffer = true, desc = "Fix All" })
            vim.keymap.set("n", "<leader>lr", "<cmd>TSToolsRenameFile<CR>", { buffer = true, desc = "Rename File" })
            vim.keymap.set("n", "<leader>ls", "<cmd>TSToolsSortImports<CR>", { buffer = true, desc = "Sort Imports" })
            vim.keymap.set(
                "n",
                "<leader>lg",
                "<cmd>TSToolsGoToSourceDefinition<CR>",
                { buffer = true, desc = "Go To Source Definition" }
            )
        end,
    })
end

return M
