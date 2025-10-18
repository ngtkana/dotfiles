local map = vim.keymap.set

-- <leader>f{f,g,b,h}: telescope
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- <leader>ca: code action
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action" })

-- <leader>w: save
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- <leader>sv: reload init.lua
map("n", "<leader>sv", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^user") or name:match("^config") or name:match("^plugins") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.fn.stdpath("config") .. "/init.lua")
  vim.notify("Reloaded init.lua and related modules", vim.log.levels.INFO)
end, { desc = "Reload init.lua" })

-- <leader>ev: open .config/nvim
map("n", "<leader>ev", function()
  vim.cmd("edit " .. vim.fn.stdpath("config"))
end, { desc = "Open config folder" })

-- <leader>fa: procon-bundler (find ac-adapter library)
map("n", "<leader>fa", function()
  require("config.utils.procon-bundler").select_and_bundle()
end, { desc = "Find AC library" })


-- Cargo 関連のキーマップ
local cargo = require("config.utils.cargo")

map("n", "<leader>cc", cargo.check, { desc = "Run cargo check" })
map("n", "<leader>cr", cargo.run_with_clipboard, { desc = "Run cargo with clipboard input" })
map("n", "<F5>", cargo.run_with_clipboard, { desc = "Run cargo with clipboard input" })
map("n", "<leader>co", cargo.toggle_buffers, { desc = "Toggle cargo output buffer" })
