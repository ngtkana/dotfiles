-- nvim-lint 設定

local M = {}

function M.setup()
    local has_lint, lint = pcall(require, "lint")
    if not has_lint then
        return
    end

    lint.linters_by_ft = {
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
        python = { "flake8" },
        lua = { "luacheck" },
    }
    
    -- luacheck の設定
    lint.linters.luacheck.args = {
        "--globals", "vim",
        "--no-max-line-length",
    }

    -- キーマップでリントを手動実行
    vim.keymap.set("n", "<leader>l", function()
        require("lint").try_lint()
    end, { desc = "Lint current file" })
end

return M
