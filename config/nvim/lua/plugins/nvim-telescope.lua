-- ファジーファインダー
---@type LazyPluginSpec
return {
  "nvim-telescope/telescope.nvim",
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    defaults = {
      -- See :h vimgrep_arguments
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--case-sensitive',
      },
    },
  },
}
