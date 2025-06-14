-- NeoVim 設定
-- モジュール化された設定ファイル

-- エラー処理を追加
local function safe_require(module)
    local status, result = pcall(require, module)
    if not status then
        print("Error loading module: " .. module)
        return nil
    end
    return result
end

-- 基本設定を読み込む
safe_require("options")

-- プラグイン定義を読み込む
local plugins = safe_require("plugins")
if plugins then
    require("lazy").setup(plugins)
end

-- キーマッピングを読み込む
safe_require("keymaps")

-- 自動コマンドを読み込む
safe_require("autocmds")

-- プラグイン設定を読み込む
-- LSP 関連の設定を読み込む
local neodev = safe_require("config.neodev")
if neodev then
    neodev.setup()
end

local lsp = safe_require("config.lsp")
if lsp then
    lsp.setup()
end

local typescript_tools = safe_require("config.typescript-tools")
if typescript_tools then
    typescript_tools.setup()
end

local fidget = safe_require("config.fidget")
if fidget then
    fidget.setup()
end

local treesitter = safe_require("config.treesitter")
if treesitter then
    treesitter.setup()
end

local telescope = safe_require("config.telescope")
if telescope then
    telescope.setup()
end

local lint = safe_require("config.lint")
if lint then
    lint.setup()
end

local conform = safe_require("config.conform")
if conform then
    conform.setup()
end

local nvim_tree = safe_require("config.nvim-tree")
if nvim_tree then
    nvim_tree.setup()
end

local lualine = safe_require("config.lualine")
if lualine then
    lualine.setup()
end

-- 新しく追加したプラグインの設定を読み込む
local mini_icons = safe_require("config.mini-icons")
if mini_icons then
    mini_icons.setup()
end

local which_key = safe_require("config.which-key")
if which_key then
    which_key.setup()
end

local gitsigns = safe_require("config.gitsigns")
if gitsigns then
    gitsigns.setup()
end

local bufferline = safe_require("config.bufferline")
if bufferline then
    bufferline.setup()
end

local indent_blankline = safe_require("config.indent-blankline")
if indent_blankline then
    indent_blankline.setup()
end

local autopairs = safe_require("config.autopairs")
if autopairs then
    autopairs.setup()
end

local comment = safe_require("config.comment")
if comment then
    comment.setup()
end

local surround = safe_require("config.surround")
if surround then
    surround.setup()
end

-- UI 改善プラグインの設定を読み込む
local alpha = safe_require("config.alpha")
if alpha then
    alpha.setup()
end

local notify = safe_require("config.notify")
if notify then
    notify.setup()
end

local noice = safe_require("config.noice")
if noice then
    noice.setup()
end

local dressing = safe_require("config.dressing")
if dressing then
    dressing.setup()
end

-- カラースキーム設定
vim.cmd([[colorscheme lucius]])
