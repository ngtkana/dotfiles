local opt = vim.opt

-- 行番号
opt.number = true
opt.relativenumber = false

-- 検索
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true

-- インデント
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
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
