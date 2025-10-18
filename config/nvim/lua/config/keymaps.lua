local map = vim.keymap.set

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

