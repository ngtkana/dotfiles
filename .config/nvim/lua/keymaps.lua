-- キーマッピング設定

-- 基本キーマップ（新しい vim.keymap.set API を使用）
vim.keymap.set({ "n", "v" }, "<leader>w", ":w<CR>", { noremap = true, desc = "Save file" })
vim.keymap.set({ "n", "v" }, "<leader>q", ":q<CR>", { noremap = true, desc = "Quit" })
vim.keymap.set({ "n", "v" }, "<leader>sv", ":source $MYVIMRC<CR>", { noremap = true, desc = "Source init.lua" })
vim.keymap.set({ "n", "v" }, "<leader>ev", ":edit $MYVIMRC<CR>", { noremap = true, desc = "Edit init.lua" })
vim.keymap.set({ "n", "v" }, "<leader>ee", ":e!<CR>", { noremap = true, desc = "Reload file" })
vim.keymap.set({ "n", "v" }, "<leader>g", ":Git<CR>", { noremap = true, desc = "Open Git" })

-- ターミナルからの脱出
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, desc = "Exit terminal mode" })

-- Neosnippet
vim.keymap.set("", "<leader>k", "<Plug>(neosnippet_expand_or_jump)", { desc = "Expand snippet" })
vim.keymap.set("s", "<leader>k", "<Plug>(neosnippet_expand_or_jump)", { desc = "Expand snippet" })
vim.keymap.set("x", "<leader>k", "<Plug>(neosnippet_expand_target)", { desc = "Expand snippet target" })

-- tuskk による日本語入力
vim.keymap.set("i", "<C-j>", [[<Cmd>call tuskk#toggle()<CR>]], { desc = "Toggle Japanese input" })
vim.keymap.set("c", "<C-j>", function()
    return vim.call("tuskk#cmd_buf")
end, { expr = true, desc = "Japanese input in command" })

-- CocExplorer キーマッピング（無効化：nvim-tree を使用）
-- vim.keymap.set(
--     "n",
--     "<leader>e",
--     ":CocCommand explorer<CR>",
--     { noremap = true, silent = true, desc = "Open CocExplorer" }
-- )

-- 診断用キーマップ
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { noremap = true, silent = true })

-- フォーマットキーマップ
vim.keymap.set({ "n", "v" }, "<leader>f", function()
    local has_conform, conform = pcall(require, "conform")
    if has_conform then
        conform.format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
        })
    end
end, { desc = "Format file or range (in visual mode)" })

-- リントキーマップ
vim.keymap.set("n", "<leader>l", function()
    local has_lint, lint = pcall(require, "lint")
    if has_lint then
        lint.try_lint()
    end
end, { desc = "Lint current file" })

-- ac-adapter-rs-vim 用関数
function ExpandAcAdapter(libname)
    local command = "procon-bundler find " .. vim.g.ac_adapter_rs_vim_workspace .. " " .. libname
    local result = vim.fn.system(command)
    if vim.v.shell_error ~= 0 then
        print(result)
    end
    vim.api.nvim_buf_set_lines(0, -1, -1, false, vim.fn.split(result, "\n"))
end

-- ac-adapter-rs-vim 用コマンド
vim.api.nvim_create_user_command("Snip", function(opts)
    ExpandAcAdapter(opts.args)
end, { nargs = 1 })
