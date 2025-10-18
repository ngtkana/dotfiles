local map = vim.keymap.set

local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- <leader>w: sare
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
  require("config.procon").select_and_bundle()
end, { desc = "Find AC library" })
