-- Lua 開発用の LSP 補完サポート
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      "lazy.nvim",
    },
  },
}
