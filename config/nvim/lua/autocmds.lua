-- 自動コマンド設定

-- ファイルタイプ固有の設定（新しい callback スタイルを使用）
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.ejs",
    callback = function()
        vim.opt.filetype = "html"
    end,
    desc = "EJS ファイルを HTML として扱う",
})

-- アイコン設定（新しい callback スタイルを使用）
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "fern", "nerdtree", "startify" },
    callback = function()
        if vim.fn.exists("*glyph_palette#apply") == 1 then
            vim.fn["glyph_palette#apply"]()
        end
    end,
    desc = "アイコンパレットを適用",
})

-- ファイル保存時と開いた時に自動的にリントを実行
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
    callback = function()
        local has_lint, lint = pcall(require, "lint")
        if has_lint then
            lint.try_lint()
        end
    end,
    desc = "ファイル保存・読み込み時にリント実行",
})

-- tuskk 初期化（関数が存在する場合のみ）
if vim.fn.exists("*tuskk#initialize") == 1 then
    vim.call("tuskk#initialize", {})
end

-- ファイルを開いたときに新しいタブにならないようにする
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        -- 既存のバッファを再利用するための設定
        vim.opt.switchbuf = "useopen"
    end,
    desc = "ファイルを開いたときに新しいタブにならないようにする",
})

-- 新しいファイルを開くときの動作を設定
vim.api.nvim_create_autocmd("BufNew", {
    callback = function()
        -- 新しいバッファを現在のウィンドウで開く
        vim.opt.switchbuf = "useopen"
    end,
    desc = "新しいファイルを現在のウィンドウで開く",
})

-- LSP が有効なバッファでは deoplete を無効化（競合を避けるため）
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        -- LSP がアタッチされたバッファで deoplete を無効化
        if vim.fn.exists("*deoplete#disable") == 1 then
            vim.call("deoplete#disable")
        end

        -- LSP 補完が有効なことをユーザーに通知
        vim.notify("LSP active: nvim-cmp is now handling completion", vim.log.levels.INFO)
    end,
    desc = "LSP が有効な場合は deoplete を無効化",
})
