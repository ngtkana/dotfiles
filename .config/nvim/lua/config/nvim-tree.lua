-- nvim-tree.lua 設定

local M = {}

function M.setup()
    local has_nvim_tree, nvim_tree = pcall(require, "nvim-tree")
    if not has_nvim_tree then
        return
    end

    nvim_tree.setup({
        sort_by = "case_sensitive",
        view = {
            width = 30,
        },
        renderer = {
            group_empty = true,
            icons = {
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                },
            },
        },
        filters = {
            dotfiles = false,
        },
        git = {
            enable = true,
            ignore = false,
        },
    })

    -- ファイルエクスプローラーのキーマッピング (NvimTree)
    vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })
    vim.keymap.set(
        "n",
        "<leader>N",
        ":NvimTreeFindFile<CR>",
        { noremap = true, silent = true, desc = "Find file in NvimTree" }
    )
end

return M
