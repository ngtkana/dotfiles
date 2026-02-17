local opt = vim.opt

-- 行番号
opt.number = true
opt.relativenumber = false

opt.wrap = false

-- 検索
opt.hlsearch = false
opt.ignorecase = false
opt.smartcase = true

-- インデント
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

-- 折りたたみ
opt.foldmethod = "marker"

-- UI
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- バックアップ・スワップ
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- その他
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true

-- 見た目
opt.background = "light"
vim.cmd("colorscheme catppuccin-latte")

vim.diagnostic.config({
  virtual_text = true
})
