-- alpha-nvim 設定

local M = {}

function M.setup()
    local has_alpha, alpha = pcall(require, "alpha")
    if not has_alpha then
        return
    end

    local dashboard = require("alpha.themes.dashboard")

    -- ヘッダー部分のカスタマイズ
    dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
    }

    -- メニュー部分のカスタマイズ
    dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
        dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
        dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
    }

    -- フッター部分のカスタマイズ
    local function footer()
        local version = vim.version()
        local nvim_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
        local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
        local plugins_count = #vim.tbl_keys(require("lazy").plugins())
        return "Neovim " .. nvim_version .. "  " .. plugins_count .. " plugins" .. datetime
    end

    dashboard.section.footer.val = footer()

    -- レイアウトの設定
    dashboard.config.layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
    }

    -- 設定を適用
    alpha.setup(dashboard.config)

    -- Neovim 起動時に自動的に alpha を開く
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            -- すでに開いているバッファがある場合は alpha を開かない
            local should_skip = false
            if vim.fn.argc() > 0 or vim.fn.line2byte("$") ~= -1 or not vim.o.modifiable then
                should_skip = true
            else
                for _, arg in pairs(vim.v.argv) do
                    if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
                        should_skip = true
                        break
                    end
                end
            end

            if not should_skip then
                require("alpha").start(true)
            end
        end,
        desc = "Start Alpha when Neovim is opened with no arguments",
    })
end

return M
