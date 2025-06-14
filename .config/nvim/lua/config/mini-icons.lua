-- mini.icons 設定

local M = {}

function M.setup()
    local has_mini_icons, mini_icons = pcall(require, "mini.icons")
    if not has_mini_icons then
        return
    end

    mini_icons.setup({
        -- デフォルト設定を使用
    })
end

return M
