-- 基本設定
vim.g.mapleader = "," -- リーダーキーを先に設定

-- 基本オプション
vim.opt.encoding = "utf-8"
vim.opt.belloff = "all"
vim.opt.clipboard = "" -- システムクリップボードを使用
vim.opt.number = true
vim.opt.completeopt = "menuone"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.foldmethod = "marker"
vim.opt.helplang = "ja,en"
vim.opt.hidden = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.listchars = { tab = ">-", trail = "#", extends = ">", precedes = "<", nbsp = "%" }
vim.opt.matchpairs = "(:),{:},[:]"
-- 日本語の括弧ペアを追加（現在は Lua API で直接追加できないため vim.cmd を使用）
vim.cmd([[set matchpairs+=「:」,『:』,【:】,《:》,〈:〉,［:］,':',":",（:）]])
-- 空白行の ~ を非表示にする
vim.opt.fillchars:append({ eob = " " })
vim.opt.matchtime = 1
vim.opt.mouse = "a"
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.scrolloff = 2
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.showtabline = 2
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.spell = false
vim.opt.spelllang:append({ "cjk" })
vim.opt.switchbuf = "useopen,usetab" -- 既存のバッファを再利用
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.updatetime = 300

-- カラースキーム設定
vim.opt.background = "light"
vim.opt.syntax = "enable" -- syntax enable を Lua API で設定

-- プラグイン設定
vim.g.gitgutter_enabled = true
vim.g.gundo_prefer_python3 = 1
-- rustfmt は conform.nvim で処理するため無効化
vim.g.rustfmt_autosave = 0
vim.g.termdebug_wide = 160

-- ac-adapter-rs-vim
vim.g.ac_adapter_rs_vim_workspace = "~/repos/ac-adapter-rs"
