-- カラースキーム
---@type LazyPluginSpec
return {
  "jonathanfilip/vim-lucius",
  config = function()
    vim.opt.background = "light"
    vim.cmd("colorscheme lucius")
  end
}
