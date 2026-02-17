local map = vim.keymap.set

-- <leader>f{f,g,b,h,d}: telescope
map('n', '<leader>ff', function()
  require('telescope.builtin').find_files()
end, { desc = 'Files' })
map('n', '<leader>fg', function()
  require('telescope.builtin').live_grep()
end, { desc = 'Grep' })
map('n', '<leader>fb', function()
  require('telescope.builtin').buffers()
end, { desc = 'Buffers' })
map('n', '<leader>fh', function()
  require('telescope.builtin').help_tags()
end, { desc = 'Tags' })
map('n', '<leader>fd', function()
  require('telescope.builtin').diagnostics()
end, { desc = 'Diagnostics' })

--- ga: code action
map('n', 'ga', vim.lsp.buf.code_action, { desc = 'Code action' })

-- <leader>w: save
map("n", "<leader>w", function()
  vim.cmd("write")
  require("fidget").notify("ファイルを保存しました", vim.log.levels.INFO)
end, { desc = "Save file" })

-- <leader>sv: reload init.lua
map("n", "<leader>sv", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^user") or name:match("^config") or name:match("^plugins") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.fn.stdpath("config") .. "/init.lua")
  require("fidget").notify("init.luaと関連モジュールを再読み込みしました", vim.log.levels.INFO)
end, { desc = "Reload init.lua" })

-- <leader>ev: open .config/nvim
map("n", "<leader>ev", function()
  vim.cmd("edit " .. vim.fn.stdpath("config"))
end, { desc = "Open config folder" })

-- <leader>fa: procon-bundler (find ac-adapter library)
map("n", "<leader>fa", function()
  require("config.utils.procon-bundler").select_and_bundle()
end, { desc = "Find AC library" })

-- Lspsaga keymaps
map("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover doc" })
map("n", "gpd", "<cmd>Lspsaga peek_definition<cr>", { desc = "Peek definition" })
map("n", "gpt", "<cmd>Lspsaga peek_type_definition<cr>", { desc = "Peek type definition" })
map("n", "ga", "<cmd>Lspsaga code_action<cr>", { desc = "Code action" })
map("n", "gra", "<cmd>Lspsaga code_action<cr>", { desc = "Code action" })
map("n", "gd", "<cmd>Lspsaga goto_definition<cr>", { desc = "Goto definition" })
map("n", "grd", "<cmd>Lspsaga goto_definition<cr>", { desc = "Goto definition" })
map("n", "grt", "<cmd>Lspsaga goto_type_definition<cr>", { desc = "Goto type definition" })
map("n", "grr", "<cmd>Lspsaga finder<cr>", { desc = "References" })
map("n", "gri", "<cmd>Lspsaga finder imp<cr>", { desc = "Implimentations" })
map("n", "grc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", { desc = "Cursor diagnostics" })
map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Next diagnostics" })
map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Next diagnostics" })

-- Cargo 関連のキーマップ
local cargo = require("config.utils.cargo")
map("n", "<F3>", cargo.check, { desc = "Run cargo check" })
map("n", "<F4>", cargo.run_with_clipboard, { desc = "Run cargo with clipboard input" })
map("n", "<F5>", cargo.run_with_input_buffer, { desc = "Run cargo with input buffer" })
map("n", "<leader>cc", cargo.check, { desc = "Run cargo check" })
map("n", "<leader>ci", cargo.open_input_buffer, { desc = "Open input buffer for editing" })
map("n", "<leader>cs", cargo.run_with_input_buffer, { desc = "Run cargo with input buffer" })
map("n", "<leader>co", cargo.toggle_buffers, { desc = "Toggle cargo buffers" })
