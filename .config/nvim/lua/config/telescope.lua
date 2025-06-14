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
                },
            },
        },
    })

    -- Telescope キーマップ
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { noremap = true })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { noremap = true })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { noremap = true })
    vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { noremap = true })
    vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { noremap = true })
end

return M
