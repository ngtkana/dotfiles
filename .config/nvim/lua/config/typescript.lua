-- typescript.nvim 設定

local M = {}

function M.setup()
    local has_typescript, typescript = pcall(require, "typescript")
    if not has_typescript then
        return
    end

    -- エラーメッセージに基づいて修正
    -- "Lsserver is deprecated, use ts_ls instead"
    typescript.setup({
        -- TypeScript サーバーのオプション
        server = {
            -- LSP サーバーの設定
            on_attach = function(client, bufnr)
                -- キーマッピングなどの設定
            end,
            settings = {
                typescript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
                javascript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
            },
        },
        -- 明示的に ts_ls を使用するように設定
        server_capabilities = {},
    })

    -- キーマッピング
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        callback = function()
            -- TypeScript 固有のコマンド
            vim.keymap.set(
                "n",
                "<leader>li",
                ":TypescriptAddMissingImports<CR>",
                { buffer = true, desc = "Add Missing Imports" }
            )
            vim.keymap.set(
                "n",
                "<leader>lo",
                ":TypescriptOrganizeImports<CR>",
                { buffer = true, desc = "Organize Imports" }
            )
            vim.keymap.set("n", "<leader>lu", ":TypescriptRemoveUnused<CR>", { buffer = true, desc = "Remove Unused" })
            vim.keymap.set("n", "<leader>lf", ":TypescriptFixAll<CR>", { buffer = true, desc = "Fix All" })
            vim.keymap.set("n", "<leader>lr", ":TypescriptRenameFile<CR>", { buffer = true, desc = "Rename File" })
        end,
    })
end

return M
