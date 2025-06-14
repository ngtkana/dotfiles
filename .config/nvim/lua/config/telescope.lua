-- Telescope 設定

local M = {}

function M.setup()
    local has_telescope, telescope = pcall(require, "telescope")
    if not has_telescope then
        return
    end

    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                    ["<C-n>"] = "move_selection_next",
                    ["<C-p>"] = "move_selection_previous",
                    ["<C-c>"] = "close",
                    ["<C-u>"] = "preview_scrolling_up",
                    ["<C-d>"] = "preview_scrolling_down",
                },
            },
            -- 検索結果の見た目
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                vertical = {
                    mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            -- プロンプトの位置を上部に
            sorting_strategy = "ascending",
            -- ボーダースタイル
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            -- ファイル無視設定
            file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
        },
        -- 拡張機能の設定
        extensions = {
            -- FZF 拡張
            fzf = {
                fuzzy = true,                    -- ファジー検索を有効化
                override_generic_sorter = true,  -- デフォルトのソーターを上書き
                override_file_sorter = true,     -- ファイルソーターを上書き
                case_mode = "smart_case",        -- 大文字小文字の区別（"ignore_case", "respect_case", "smart_case"）
            },
            -- ファイルブラウザ拡張
            file_browser = {
                theme = "dropdown",
                hijack_netrw = false,            -- netrw の代わりに使用しない（nvim-tree を使用）
                mappings = {
                    ["i"] = {
                        ["<C-w>"] = function() vim.cmd('normal vbd') end, -- 単語を削除
                    },
                    ["n"] = {
                        ["N"] = "create",        -- 新規ファイル作成
                        ["h"] = "goto_parent_dir", -- 親ディレクトリへ
                        -- ["/"] = "filter" の代わりに以下を使用
                        ["/"] = function()
                            vim.cmd("startinsert")
                        end,
                    },
                },
                -- 追加の設定
                hidden = true,                   -- 隠しファイルを表示
                respect_gitignore = false,       -- .gitignore を尊重しない
                initial_mode = "normal",         -- 初期モードを normal に設定
                path = "%:p:h",                  -- 現在のファイルのディレクトリを開く
            },
            -- プロジェクト拡張
            project = {
                base_dirs = {
                    { path = "~/repos", max_depth = 4 },
                    { path = "~/.config", max_depth = 2 },
                },
                hidden_files = true,             -- 隠しファイルを表示
                theme = "dropdown",
                order_by = "asc",
                search_by = "title",
                sync_with_nvim_tree = true,      -- nvim-tree と同期
            },
        },
    })

    -- 拡張機能を読み込む
    local function load_extension(name)
        local success, err = pcall(telescope.load_extension, name)
        if not success then
            vim.notify("Failed to load telescope extension: " .. name .. "\n" .. err, vim.log.levels.WARN)
        end
    end
    
    load_extension("fzf")
    load_extension("file_browser")
    load_extension("project")

    -- Telescope キーマップ
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true, desc = "Find Files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { noremap = true, desc = "Live Grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { noremap = true, desc = "Buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { noremap = true, desc = "Help Tags" })
    vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { noremap = true, desc = "Document Symbols" })
    vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { noremap = true, desc = "References" })
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { noremap = true, desc = "Diagnostics" })
    vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { noremap = true, desc = "Recent Files" })
    vim.keymap.set("n", "<leader>fc", builtin.commands, { noremap = true, desc = "Commands" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { noremap = true, desc = "Keymaps" })
    
    -- 拡張機能のキーマップ
    vim.keymap.set("n", "<leader>fe", function()
        require("telescope").extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = vim.fn.expand('%:p:h'),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 }
        })
    end, { noremap = true, desc = "File Browser" })
    
    vim.keymap.set("n", "<leader>fp", ":Telescope project<CR>", { noremap = true, desc = "Projects" })
end

return M
