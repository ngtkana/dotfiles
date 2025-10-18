-- 自動補完
---@type LazyPluginSpec
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
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "emoji" },
        { name = "latex_symbols" },
      })
    })
  end
}
