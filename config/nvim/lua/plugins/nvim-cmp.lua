-- 自動補完
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "L3MON4D3/LuaSnip",           -- スニペットエンジン
    "saadparwaiz1/cmp_luasnip",   -- LuaSnip 補完ソース
    "neovim/nvim-lspconfig",      -- LSP 補完ソース
    "hrsh7th/cmp-emoji",          -- 絵文字補完
    "kdheepak/cmp-latex-symbols", -- LaTeX シンボル補完
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "emoji" },
        { name = "latex_symbols" },
      })
    })
  end
}
