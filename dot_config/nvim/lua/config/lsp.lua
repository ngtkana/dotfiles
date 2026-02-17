if not vim.g.vscode then
  -- 定数
  local FORMAT_TIMEOUT_MS = 1000

  -- nvim-cmp の capabilities を取得
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  vim.lsp.enable({
    "lua_ls",
    "rust_analyzer",
    "tinymist",
  })

  -- LSP サーバーに capabilities を設定
  vim.lsp.config('*', {
    capabilities = capabilities,
  })

  -- rust-analyzer で cargo make clippy を使用
  vim.lsp.config('rust_analyzer', {
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {
        check = {
          command = "clippy",
        },
      },
    },
  })

  -- 言語サーバーがアタッチされた時に呼ばれる
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      local buf = args.buf

      if client:supports_method("textDocument/definition") then
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to definition" })
      end

      if client:supports_method("textDocument/hover") then
        vim.keymap.set("n", "<leader>k",
          function() vim.lsp.buf.hover({ border = "single" }) end,
          { buffer = buf, desc = "Show hover documentation" })
      end

      -- Auto-format ("lint") on save.
      -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
      if not client:supports_method("textDocument/willSaveWaitUntil")
          and client:supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
          buffer = args.buf,
          callback = function()
            vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = FORMAT_TIMEOUT_MS })
          end,
        })
      end
    end
  })
end
