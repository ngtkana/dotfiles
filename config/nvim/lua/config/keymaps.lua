local map = vim.keymap.set
local init_path = vim.fn.stdpath("config") .. "/init.lua"

-- <leader>w: save
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- <leader>sr: reload init.lua
map("n", "<leader>sr", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^user") or name:match("^config") or name:match("^plugins") then
      package.loaded[name] = nil
    end
  end
  dofile(init_path)
  vim.notify("Reloaded init.lua and related modules", vim.log.levels.INFO)
end, { desc = "Reload init.lua" })

-- <leader>er: edit init.lua
map("n", "<leader>er", function()
  vim.cmd("edit " .. init_path)
end, { desc = "Edit init.lua" })

