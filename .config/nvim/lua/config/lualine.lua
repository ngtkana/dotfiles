-- lualine 設定

local M = {}

function M.setup()
    local has_lualine, lualine = pcall(require, "lualine")
    if not has_lualine then
        return
    end

    -- tuskk の状態を表示する関数
    local function tuskk_status()
        if vim.call("tuskk#is_enabled") then
            return "あ"
        else
            return "A"
        end
    end

    -- airline に似たスタイルで lualine を設定
    lualine.setup({
        options = {
            theme = "solarized_light",
            component_separators = { left = "", right = "" },
            section_separators = { left = "◤", right = "◢" },
            globalstatus = false,
        },
        sections = {
            lualine_a = {
                {
                    "mode",
                    fmt = function(str)
                        return str:sub(1, 1)
                    end,
                },
                { tuskk_status },
            },
            lualine_b = {
                function()
                    return os.date("%m/%d(%a) %H:%M:%S")
                end,
            },
            lualine_c = {
                "filename",
                "diagnostics",
            },
            lualine_x = {
                function()
                    local msg = ""
                    -- 非推奨の vim.lsp.get_active_clients() から vim.lsp.get_clients() に更新
                    local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
                    if #buf_clients == 0 then
                        return msg
                    end

                    local client_names = {}
                    for _, client in ipairs(buf_clients) do
                        table.insert(client_names, client.name)
                    end

                    return "[" .. table.concat(client_names, ", ") .. "]"
                end,
                "filetype",
            },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
    })
end

return M
