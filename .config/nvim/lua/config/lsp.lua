-- LSP 設定

-- LSP セットアップ関数の定義
local on_attach = function(client, bufnr)
    -- フォーマットは conform.nvim で行うため、LSP のフォーマット機能を無効化
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- マッピング
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

    -- カーソルを置いた時に参照をハイライト
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd("CursorHold", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.clear_references()
            end,
        })
    end
end

local M = {}

function M.setup()
    -- プラグインがまだインストールされていない場合に対応するため pcall でラップ
    local has_lspconfig, lspconfig = pcall(require, "lspconfig")
    local has_cmp, cmp = pcall(require, "cmp")
    local has_luasnip, luasnip = pcall(require, "luasnip")
    local has_lspkind, lspkind = pcall(require, "lspkind")
    local has_mason, mason = pcall(require, "mason")

    if has_mason then
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        -- 必要なツールを自動インストール
        local ensure_installed = {
            -- LSP
            "rust-analyzer",
            "typescript-language-server",
            "pyright",
            "eslint-lsp",
            "css-lsp",
            "html-lsp",
            "tailwindcss-language-server",
            "json-lsp",
            "lua-language-server",

            -- Linter
            "eslint_d",
            "luacheck",

            -- Formatter
            "prettier",
            "black",
            "rustfmt",
            "stylua",

            -- DAP (デバッガー)
            "codelldb",
            "js-debug-adapter",
            "debugpy",
        }

        -- mason-registry を使用して必要なツールをインストール
        local mr = require("mason-registry")
        for _, tool in ipairs(ensure_installed) do
            local p = mr.get_package(tool)
            if not p:is_installed() then
                p:install()
            end
        end
    end

    -- 必要なプラグインが利用可能な場合のみ LSP を設定
    if has_lspconfig and has_cmp and has_luasnip and has_lspkind then
        -- capabilities の設定
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        if has_cmp then
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
        end
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.completion.completionItem.resolveSupport = {
            properties = {
                "documentation",
                "detail",
                "additionalTextEdits",
            },
        }
        -- 直接 LSP サーバーを設定
        local servers =
            { "rust_analyzer", "ts_ls", "pyright", "eslint", "cssls", "html", "tailwindcss", "jsonls", "lua_ls" }

        for _, server in ipairs(servers) do
            local ok, _ = pcall(function()
                lspconfig[server].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end)
            if not ok then
                print("Failed to set up LSP server: " .. server)
            end
        end

        -- 言語サーバーの設定
        -- Rust
        local has_rust_tools, rust_tools = pcall(require, "rust-tools")
        if has_rust_tools then
            -- Mason でインストールされた rust-analyzer のパスを取得（lazy.nvim 対応版）
            local mason_bin_path = vim.fn.stdpath("data") .. "/mason/bin/"
            local rust_analyzer_path = nil

            -- OS に応じたパスを設定
            if vim.fn.has("win32") == 1 then
                rust_analyzer_path = mason_bin_path .. "rust-analyzer.cmd"
            else
                rust_analyzer_path = mason_bin_path .. "rust-analyzer"
            end

            -- ファイルが存在するか確認
            if vim.fn.filereadable(rust_analyzer_path) == 0 then
                rust_analyzer_path = nil
            end

            rust_tools.setup({
                server = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    cmd = rust_analyzer_path and { rust_analyzer_path } or nil,
                    settings = {
                        ["rust-analyzer"] = {
                            checkOnSave = true,
                            check = {
                                command = "clippy",
                            },
                            procMacro = {
                                enable = true,
                            },
                            cargo = {
                                loadOutDirsFromCheck = true,
                            },
                            -- Rust ツールチェーンの設定
                            rustc = {
                                source = nil,
                            },
                            imports = {
                                granularity = {
                                    group = "module",
                                },
                                prefix = "self",
                            },
                            assist = {
                                importGranularity = "module",
                                importPrefix = "self",
                            },
                            completion = {
                                autoimport = {
                                    enable = true,
                                },
                                autoself = {
                                    enable = true,
                                },
                            },
                        },
                    },
                },
                -- デバッガの設定
                dap = {
                    adapter = {
                        type = "executable",
                        command = "lldb-vscode",
                        name = "rt_lldb",
                    },
                },
            })
        end

        -- TypeScript
        if has_lspconfig then
            pcall(function()
                lspconfig.ts_ls.setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
                    root_dir = function(fname)
                        return lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git")(
                            fname
                        )
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
                })
            end)

            -- ESLint
            pcall(function()
                lspconfig.eslint.setup({
                    on_attach = function(client, bufnr)
                        on_attach(client, bufnr)
                        -- ESLint 自動修正を有効化
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            command = "EslintFixAll",
                        })
                    end,
                    capabilities = capabilities,
                    settings = {
                        packageManager = "npm",
                        autoFixOnSave = true,
                        format = true,
                    },
                })
            end)

            -- CSS
            pcall(function()
                lspconfig.cssls.setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end)

            -- HTML
            pcall(function()
                lspconfig.html.setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end)

            -- Tailwind CSS
            pcall(function()
                lspconfig.tailwindcss.setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    root_dir = function(fname)
                        return lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts")(fname)
                            or lspconfig.util.root_pattern("package.json", ".git")(fname)
                    end,
                })
            end)

            -- JSON
            pcall(function()
                lspconfig.jsonls.setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                            validate = { enable = true },
                        },
                    },
                })
            end)

            -- Lua
            pcall(function()
                lspconfig.lua_ls.setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            runtime = {
                                -- LuaJIT for NeoVim
                                version = "LuaJIT",
                                path = vim.split(package.path, ";"),
                            },
                            diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                globals = { "vim" },
                            },
                            workspace = {
                                -- Make the server aware of NeoVim runtime files
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                                },
                                maxPreload = 2000,
                                preloadFileSize = 50000,
                            },
                            telemetry = {
                                enable = false,
                            },
                        },
                    },
                })
            end)
        end

        -- 補完の設定
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ 
                    select = true,
                    behavior = cmp.ConfirmBehavior.Replace,
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp", keyword_length = 1 },
                { name = "luasnip", keyword_length = 2 },
            }, {
                { name = "buffer", keyword_length = 3 },
                { name = "path" },
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                    ellipsis_char = "...",
                }),
            },
            experimental = {
                ghost_text = true,
            },
            preselect = cmp.PreselectMode.Item,
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
        })

        -- 診断の設定
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        -- Trouble 設定
        local has_trouble, trouble = pcall(require, "trouble")
        if has_trouble then
            trouble.setup({
                position = "bottom",
                icons = true,
                mode = "workspace_diagnostics",
                action_keys = {
                    close = "q",
                    cancel = "<esc>",
                    refresh = "r",
                    jump = { "<cr>", "<tab>" },
                    open_split = { "<c-x>" },
                    open_vsplit = { "<c-v>" },
                    open_tab = { "<c-t>" },
                    jump_close = { "o" },
                    toggle_mode = "m",
                    toggle_preview = "P",
                    hover = "K",
                    preview = "p",
                    close_folds = { "zM", "zm" },
                    open_folds = { "zR", "zr" },
                    toggle_fold = { "zA", "za" },
                    previous = "k",
                    next = "j",
                },
            })

            vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
            vim.keymap.set(
                "n",
                "<leader>xw",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                { silent = true, noremap = true }
            )
            vim.keymap.set(
                "n",
                "<leader>xd",
                "<cmd>TroubleToggle document_diagnostics<cr>",
                { silent = true, noremap = true }
            )
            vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
            vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
            vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
        end
    end
end

return M
