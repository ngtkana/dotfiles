-- Lua 開発用の LSP 補完サポート
---@type LazyPluginSpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- lazy.nvimの型定義を読み込む
      { path = "lazy.nvim", words = { "lazy" } },
      -- LazyVimの型定義（使用している場合）
      -- { path = "LazyVim", words = { "LazyVim" } },
    },
  },
}
