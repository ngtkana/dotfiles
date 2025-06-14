-- possession.nvim 設定

local M = {}

function M.setup()
    local has_possession, possession = pcall(require, "possession")
    if not has_possession then
        return
    end

    possession.setup({
        -- セッションの保存先
        session_dir = vim.fn.stdpath("data") .. "/possession",
        
        -- 無視するバッファのパターン
        silent = false,
        
        -- セッションに含めないプラグイン
        plugins = {
            -- デフォルトで無視されるプラグイン
            delete = {
                "alpha-nvim",
                "gitsigns.nvim",
                "nvim-tree.lua",
            },
            -- 追加で無視するプラグイン
            append = {
                "telescope.nvim",
                "trouble.nvim",
            },
        },
        
        -- セッションに保存する追加情報
        hooks = {
            -- セッション保存前のフック
            before_save = function(name)
                -- 保存前に実行する処理
                return {}
            end,
            
            -- セッション読み込み後のフック
            after_load = function(name, user_data)
                -- 読み込み後に実行する処理
            end,
        },
        
        -- Telescope 拡張機能の設定
        telescope = {
            -- Telescope での表示オプション
            list = {
                default_action = "load",
                mappings = {
                    save = { n = "<c-s>", i = "<c-s>" },
                    load = { n = "<c-l>", i = "<c-l>" },
                    delete = { n = "<c-d>", i = "<c-d>" },
                    rename = { n = "<c-r>", i = "<c-r>" },
                },
            },
        },
    })
    
    -- Telescope 拡張機能を読み込む
    pcall(require("telescope").load_extension, "possession")
    
    -- キーマッピング
    vim.keymap.set("n", "<leader>ss", function()
        require("telescope").extensions.possession.list()
    end, { desc = "List Sessions" })
    
    vim.keymap.set("n", "<leader>sn", function()
        vim.ui.input({ prompt = "Session name: " }, function(name)
            if name and name ~= "" then
                require("possession.session").save(name)
            end
        end)
    end, { desc = "New Session" })
    
    vim.keymap.set("n", "<leader>sl", function()
        vim.ui.input({ prompt = "Session name: " }, function(name)
            if name and name ~= "" then
                require("possession.session").load(name)
            end
        end)
    end, { desc = "Load Session" })
    
    vim.keymap.set("n", "<leader>sd", function()
        vim.ui.input({ prompt = "Session name: " }, function(name)
            if name and name ~= "" then
                require("possession.session").delete(name)
            end
        end)
    end, { desc = "Delete Session" })
end

return M
