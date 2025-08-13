-- neodev.nvim 設定

local M = {}

function M.setup()
    local has_neodev, neodev = pcall(require, "neodev")
    if not has_neodev then
        return
    end

    neodev.setup({
        -- Neovim の Lua API 開発のための設定
        library = {
            enabled = true, -- ライブラリを有効化
            runtime = true, -- ランタイムファイルを含める
            types = true, -- 型定義を含める
            plugins = true, -- インストール済みプラグインを含める
        },
        setup_jsonls = true, -- JSON LSP の設定を自動化
        lspconfig = true, -- lspconfig との統合
        pathStrict = true, -- 厳密なパス解決
    })
end

return M
