-- NeoVim 設定
-- 既存の .vimrc と init.lua に基づいています

-- vim-plug によるプラグイン管理
local Plug = vim.fn['plug#']
vim.call('plug#begin')
-- スニペットと補完
Plug('Shougo/deoplete.nvim')
Plug('Shougo/neosnippet-snippets')
Plug('Shougo/neosnippet.vim')

-- ファイル管理と UI
Plug('nvim-tree/nvim-web-devicons')
Plug('scrooloose/nerdtree')
Plug('ryanoasis/vim-devicons')
Plug('tpope/vim-vinegar')
Plug('lambdalisue/glyph-palette.vim')
Plug('lambdalisue/nerdfont.vim')

-- Coc.nvim（LSP と CocExplorer 用）
Plug('neoclide/coc.nvim', {branch = 'release'})

-- Git 統合
Plug('airblade/vim-gitgutter')
Plug('tpope/vim-fugitive')

-- カラースキーム
Plug('altercation/vim-colors-solarized')
Plug('jonathanfilip/vim-lucius')
Plug('rebelot/kanagawa.nvim')
Plug('tssm/fairyfloss.vim')

-- ステータスライン
Plug('nvim-lualine/lualine.nvim')

-- 言語サポート
Plug('rust-lang/rust.vim')
Plug('rhysd/rust-doc.vim')
Plug('ron-rs/ron.vim')
Plug('leafgarland/typescript-vim')
Plug('peitalin/vim-jsx-typescript')
Plug('chrisbra/csv.vim')
Plug('elzr/vim-json')
Plug('qnighy/satysfi.vim')

-- LSP と補完 (NeoVim ネイティブ LSP)
Plug('neovim/nvim-lspconfig')           -- LSP 設定
Plug('williamboman/mason.nvim')         -- LSP サーバーインストーラー
Plug('williamboman/mason-lspconfig.nvim') -- mason と lspconfig の連携
Plug('hrsh7th/nvim-cmp')                -- 補完フレームワーク
Plug('hrsh7th/cmp-nvim-lsp')            -- LSP 補完ソース
Plug('hrsh7th/cmp-buffer')              -- バッファ補完ソース
Plug('hrsh7th/cmp-path')                -- パス補完ソース
Plug('hrsh7th/cmp-cmdline')             -- コマンドライン補完ソース
Plug('L3MON4D3/LuaSnip')                -- スニペットエンジン
Plug('saadparwaiz1/cmp_luasnip')        -- スニペット補完ソース
Plug('onsails/lspkind-nvim')            -- 補完メニューのアイコン
Plug('folke/trouble.nvim')              -- 診断表示の改善
Plug('simrat39/rust-tools.nvim')        -- Rust 用追加ツール
Plug('mfussenegger/nvim-lint')         -- リンター統合
Plug('stevearc/conform.nvim')          -- フォーマッター統合
Plug('nvim-tree/nvim-tree.lua')         -- ファイルエクスプローラー
Plug('b0o/schemastore.nvim')            -- JSON スキーマ
Plug('mfussenegger/nvim-dap')           -- デバッガー
Plug('rcarriga/nvim-dap-ui')            -- デバッガー UI
Plug('theHamsta/nvim-dap-virtual-text') -- デバッガー仮想テキスト
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'}) -- 構文解析

-- 編集ツール
Plug('easymotion/vim-easymotion')
Plug('editorconfig/editorconfig-vim')
Plug('mattn/emmet-vim')
Plug('tomtom/tcomment_vim')
Plug('tpope/vim-repeat')
Plug('tpope/vim-surround')
Plug('tpope/vim-unimpaired')
Plug('github/copilot.vim')

-- 検索とナビゲーション
Plug('jremmen/vim-ripgrep')
Plug('junegunn/fzf')
Plug('majutsushi/tagbar')
Plug('nvim-telescope/telescope.nvim')   -- ファジーファインダー
Plug('nvim-lua/plenary.nvim')           -- Telescope に必要

-- ユーティリティ
Plug('sjl/gundo.vim')
Plug('tyru/open-browser.vim')
Plug('vim-jp/vimdoc-ja')
Plug('vim-utils/vim-man')

-- 日本語入力
Plug('vim-denops/denops.vim')
Plug('kawarimidoll/tuskk.vim')

-- 一部のプラグインに必要
Plug('roxma/nvim-yarp')
Plug('roxma/vim-hug-neovim-rpc')
vim.call('plug#end')

-- 基本設定
vim.opt.encoding = 'utf-8'
vim.opt.belloff = 'all'
vim.opt.number = true
vim.opt.completeopt = 'menuone'
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.foldmethod = 'marker'
vim.opt.helplang = 'ja,en'
vim.opt.hidden = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.listchars = {tab='>-', trail='#', extends='>', precedes='<', nbsp='%'}
vim.opt.matchpairs = '(:),{:},[:]'
vim.cmd[[set matchpairs+=「:」,『:』,【:】,《:》,〈:〉,［:］,':',":",（:）]]
vim.cmd[[set fillchars+=eob:\ ]]
vim.opt.matchtime = 1
vim.opt.mouse = 'a'
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.scrolloff = 2
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.showtabline = 2
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.spell = false
vim.opt.spelllang:append({'cjk'})
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.updatetime = 300

-- カラースキーム
vim.cmd[[set background=light]]
vim.cmd[[syntax enable]]
vim.cmd[[colorscheme lucius]]

-- リーダーキー
vim.g.mapleader = ','

-- 基本キーマップ
vim.api.nvim_set_keymap('', '<leader>w', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<leader>q', ':q<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<leader>sv', ':source $MYVIMRC<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<leader>ev', ':edit $MYVIMRC<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<leader>ee', ':e!<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<leader>g', ':Git<CR>', { noremap = true })

-- ターミナルからの脱出
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- Neosnippet
vim.api.nvim_set_keymap('', '<leader>k', '<Plug>(neosnippet_expand_or_jump)', {})
vim.api.nvim_set_keymap('s', '<leader>k', '<Plug>(neosnippet_expand_or_jump)', {})
vim.api.nvim_set_keymap('x', '<leader>k', '<Plug>(neosnippet_expand_target)', {})

-- tuskk による日本語入力
vim.api.nvim_set_keymap('i', '<C-j>', [[<Cmd>call tuskk#toggle()<CR>]], {})
vim.api.nvim_set_keymap('c', '<C-j>', 'call tuskk#cmd_buf()', { expr = true })
vim.call("tuskk#initialize", {})

-- CocExplorer キーマッピング
vim.api.nvim_set_keymap('n', '<leader>e', ':CocCommand explorer<CR>', { noremap = true, silent = true })


-- ネイティブ LSP 設定
-- プラグインがまだインストールされていない場合に対応するため pcall でラップ
local has_lspconfig, lspconfig = pcall(require, 'lspconfig')
local has_cmp, cmp = pcall(require, 'cmp')
local has_luasnip, luasnip = pcall(require, 'luasnip')
local has_lspkind, lspkind = pcall(require, 'lspkind')
local has_mason, mason = pcall(require, 'mason')

if has_mason then
  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })

  -- 必要なツールを自動インストール
  local ensure_installed = {
    -- LSP
    "rust-analyzer",
    "typescript-language-server",
    "pyright",
    "eslint-lsp",
    "css-lsp",
    "html-lsp",
    "tailwindcss-language-server",
    "json-lsp",
    "lua-language-server",

    -- Linter
    "eslint_d",

    -- Formatter
    "prettier",
    "black",
    "rustfmt",

    -- DAP (デバッガー)
    "codelldb",
    "js-debug-adapter",
    "debugpy"
  }

  -- mason-registry を使用して必要なツールをインストール
  local mr = require("mason-registry")
  for _, tool in ipairs(ensure_installed) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end

  -- mason-lspconfig の設定は後で servers 変数を使用するため、後で設定します
end

-- LSP セットアップ関数の定義
local on_attach = function(client, bufnr)
  -- フォーマットは conform.nvim で行うため、LSP のフォーマット機能を無効化
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  
  -- マッピング
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

  -- カーソルを置いた時に参照をハイライト
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function() vim.lsp.buf.document_highlight() end
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      callback = function() vim.lsp.buf.clear_references() end
    })
  end
end

-- 必要なプラグインが利用可能な場合のみ LSP を設定
if has_lspconfig and has_cmp and has_luasnip and has_lspkind then
  -- capabilities の設定
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if has_cmp then
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  end
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }
  -- 直接 LSP サーバーを設定
  local servers = { "rust_analyzer", "ts_ls", "pyright", "eslint", "cssls", "html", "tailwindcss", "jsonls", "lua_ls" }

  -- mason-lspconfig は現在問題があるため、一時的に無効化
  -- if has_mason_lspconfig then
  --   mason_lspconfig.setup()
  -- end
  for _, server in ipairs(servers) do
    local ok, _ = pcall(function()
      lspconfig[server].setup({
        on_attach = on_attach
      })
    end)
    if not ok then
      print("Failed to set up LSP server: " .. server)
    end
  end

  -- 言語サーバーの設定
  -- Rust
  local has_rust_tools, rust_tools = pcall(require, 'rust-tools')
  if has_rust_tools then
    rust_tools.setup({
      server = {
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = true,
            procMacro = {
              enable = true
            }
          }
        }
      }
    })
  end

  -- TypeScript
  if has_lspconfig then
    pcall(function()
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
        root_dir = function(fname)
          return lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git")(fname)
        end,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true
            }
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true
            }
          }
        }
      })
    end)

    -- ESLint
    pcall(function()
      lspconfig.eslint.setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          -- ESLint 自動修正を有効化
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        settings = {
          packageManager = "npm",
          autoFixOnSave = true,
          format = true
        }
      })
    end)

    -- CSS
    pcall(function()
      lspconfig.cssls.setup({
        on_attach = on_attach,
        capabilities = capabilities
      })
    end)

    -- HTML
    pcall(function()
      lspconfig.html.setup({
        on_attach = on_attach,
        capabilities = capabilities
      })
    end)

    -- Tailwind CSS
    pcall(function()
      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = function(fname)
          return lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts")(fname) or
                 lspconfig.util.root_pattern("package.json", ".git")(fname)
        end
      })
    end)

    -- JSON
    pcall(function()
      lspconfig.jsonls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true }
          }
        }
      })
    end)

    -- Lua
    pcall(function()
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              -- LuaJIT for NeoVim
              version = 'LuaJIT',
              path = vim.split(package.path, ';'),
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
            },
            workspace = {
              -- Make the server aware of NeoVim runtime files
              library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
              },
              maxPreload = 2000,
              preloadFileSize = 50000,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
    end)
  end

  -- 補完の設定
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
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
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
      { name = 'path' },
    }),
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol_text',
        maxwidth = 50,
        ellipsis_char = '...',
      })
    }
  })

  -- 診断の設定
  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  -- 診断用キーマップ
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { noremap = true, silent = true })

  -- Trouble キーマップ
  local has_trouble, trouble = pcall(require, 'trouble')
  if has_trouble then
    trouble.setup({
      position = "bottom",
      icons = true,
      mode = "workspace_diagnostics",
      action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = {"<cr>", "<tab>"},
        open_split = {"<c-x>"},
        open_vsplit = {"<c-v>"},
        open_tab = {"<c-t>"},
        jump_close = {"o"},
        toggle_mode = "m",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        close_folds = {"zM", "zm"},
        open_folds = {"zR", "zr"},
        toggle_fold = {"zA", "za"},
        previous = "k",
        next = "j"
      },
    })

    vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
    vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
    vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
    vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
    vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
    vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
  end
end -- End of LSP configuration block

-- より良いナビゲーションのための Telescope 設定
local has_telescope, telescope = pcall(require, 'telescope')
if has_telescope then
  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        }
      }
    }
  })

  -- Telescope キーマップ
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { noremap = true })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { noremap = true })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { noremap = true })
  vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { noremap = true })
  vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { noremap = true })
end

-- ファイルタイプ固有の設定
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.ejs",
  command = "set filetype=html"
})

-- Treesitter 設定
local has_treesitter, treesitter = pcall(require, 'nvim-treesitter.configs')
if has_treesitter then
  treesitter.setup({
    ensure_installed = {
      "typescript",
      "javascript",
      "tsx",
      "html",
      "css",
      "json",
      "yaml",
      "lua",
      "rust",
      "python",
      "markdown",
      "markdown_inline"
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        scope_incremental = "<S-CR>",
        node_decremental = "<BS>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
        },
      },
    },
  })
end

-- lualine によるステータスライン設定（最新、NeoVim 推奨）
local function setup_statusline()
  local function tuskk_status()
    if vim.call("tuskk#is_enabled") then return 'あ' else return 'A' end
  end

  -- airline に似たスタイルで lualine を設定
  local has_lualine, lualine = pcall(require, 'lualine')
  if not has_lualine then
    return
  end
  lualine.setup({
    options = {
      theme = 'solarized_light',
      component_separators = { left = '', right = ''},
      section_separators = { left = '◤', right = '◢'},
      globalstatus = false,
    },
    sections = {
      lualine_a = {
        { 'mode', fmt = function(str) return str:sub(1,1) end },
        { tuskk_status }
      },
      lualine_b = {
        function()
          return os.date('%m/%d(%a) %H:%M:%S')
        end
      },
      lualine_c = {
        'filename',
        'diagnostics'
      },
      lualine_x = {
        function()
          local msg = ''
          -- 非推奨の vim.lsp.get_active_clients() から vim.lsp.get_clients() に更新
          local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
          if #buf_clients == 0 then
            return msg
          end

          local client_names = {}
          for _, client in ipairs(buf_clients) do
            table.insert(client_names, client.name)
          end

          return '[' .. table.concat(client_names, ', ') .. ']'
        end,
        'filetype'
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    }
  })
end

-- ステータスラインを設定
setup_statusline()

-- アイコン設定
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"fern", "nerdtree", "startify"},
  callback = function()
    if vim.fn.exists('*glyph_palette#apply') == 1 then
      vim.fn['glyph_palette#apply']()
    end
  end
})

-- ファイルエクスプローラー設定（nvim-tree.lua）
local has_nvim_tree, nvim_tree = pcall(require, 'nvim-tree')
if has_nvim_tree then
  nvim_tree.setup({
    sort_by = "case_sensitive",
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
    },
    filters = {
      dotfiles = false,
    },
    git = {
      enable = true,
      ignore = false,
    },
  })

  -- ファイルエクスプローラーのキーマッピング (NvimTree)
  vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>N', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
end

-- リンター設定（nvim-lint）
local has_lint, lint = pcall(require, 'lint')
if has_lint then
  lint.linters_by_ft = {
    javascript = {'eslint'},
    typescript = {'eslint'},
    javascriptreact = {'eslint'},
    typescriptreact = {'eslint'},
  }

  -- ファイル保存時と開いた時に自動的にリントを実行
  vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
    callback = function()
      require("lint").try_lint()
    end,
  })

  -- キーマップでリントを手動実行
  vim.keymap.set("n", "<leader>l", function()
    require("lint").try_lint()
  end, { desc = "Lint current file" })
end

-- フォーマッタ設定（conform.nvim）
local has_conform, conform = pcall(require, 'conform')
if has_conform then
  conform.setup({
    formatters_by_ft = {
      -- JavaScript/TypeScript
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      -- Web
      css = { "prettier" },
      scss = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      -- Rust
      rust = { "rustfmt" },
      -- Python
      python = { "black" },
      -- Lua
      lua = { "stylua" },
    },
    format_on_save = {
      -- `timeout_ms` を設定して、フォーマットが完了するまでの最大待機時間を指定
      timeout_ms = 500,
      lsp_fallback = true,
    },
  })
  
  -- キーマップでフォーマットを手動実行
  vim.keymap.set({ "n", "v" }, "<leader>f", function()
    conform.format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    })
  end, { desc = "Format file or range (in visual mode)" })
end

-- LSP キーマッピングはすでに on_attach 関数内で設定されているため、ここでは不要
-- グローバルなキーマッピングは必要に応じて追加

-- プラグイン設定
vim.g.gitgutter_enabled = true
vim.g.gundo_prefer_python3 = 1
-- rustfmt は conform.nvim で処理するため無効化
vim.g.rustfmt_autosave = 0
vim.g.termdebug_wide = 160

-- ac-adapter-rs-vim
vim.g.ac_adapter_rs_vim_workspace = '~/repos/ac-adapter-rs'
function ExpandAcAdapter(libname)
  local command = "procon-bundler find " .. vim.g.ac_adapter_rs_vim_workspace .. " " .. libname
  local result = vim.fn.system(command)
  if vim.v.shell_error ~= 0 then
    print(result)
  end
  vim.api.nvim_buf_set_lines(0, -1, -1, false, vim.fn.split(result, '\n'))
end

vim.api.nvim_create_user_command('Snip', function(opts)
  ExpandAcAdapter(opts.args)
end, { nargs = 1 })
