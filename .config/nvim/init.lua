-- NeoVim configuration
-- Based on existing .vimrc and init.lua

-- Plugin management with vim-plug
local Plug = vim.fn['plug#']
vim.call('plug#begin')
-- Snippets and completion
Plug('Shougo/deoplete.nvim')
Plug('Shougo/neosnippet-snippets')
Plug('Shougo/neosnippet.vim')

-- File management and UI
Plug('nvim-tree/nvim-web-devicons')
Plug('scrooloose/nerdtree')
Plug('ryanoasis/vim-devicons')
Plug('tpope/vim-vinegar')
Plug('lambdalisue/glyph-palette.vim')
Plug('lambdalisue/nerdfont.vim')

-- Git integration
Plug('airblade/vim-gitgutter')
Plug('tpope/vim-fugitive')

-- Color schemes
Plug('altercation/vim-colors-solarized')
Plug('jonathanfilip/vim-lucius')
Plug('rebelot/kanagawa.nvim')
Plug('tssm/fairyfloss.vim')

-- Status line
Plug('nvim-lualine/lualine.nvim')
Plug('enricobacis/vim-airline-clock')
Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')

-- Language support
Plug('rust-lang/rust.vim')
Plug('rhysd/rust-doc.vim')
Plug('ron-rs/ron.vim')
Plug('leafgarland/typescript-vim')
Plug('peitalin/vim-jsx-typescript')
Plug('chrisbra/csv.vim')
Plug('elzr/vim-json')
Plug('qnighy/satysfi.vim')

-- LSP and completion
Plug('neoclide/coc.nvim', {branch = 'release'})

-- Editing tools
Plug('easymotion/vim-easymotion')
Plug('editorconfig/editorconfig-vim')
Plug('mattn/emmet-vim')
Plug('tomtom/tcomment_vim')
Plug('tpope/vim-repeat')
Plug('tpope/vim-surround')
Plug('tpope/vim-unimpaired')
Plug('github/copilot.vim')

-- Search and navigation
Plug('jremmen/vim-ripgrep')
Plug('junegunn/fzf')
Plug('majutsushi/tagbar')

-- Utilities
Plug('sjl/gundo.vim')
Plug('tyru/open-browser.vim')
Plug('vim-jp/vimdoc-ja')
Plug('vim-utils/vim-man')

-- Japanese input
Plug('vim-denops/denops.vim')
Plug('kawarimidoll/tuskk.vim')

-- Required for some plugins
Plug('roxma/nvim-yarp')
Plug('roxma/vim-hug-neovim-rpc')
vim.call('plug#end')

-- Basic settings
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
-- Set default matchpairs
vim.opt.matchpairs = '(:),{:},[:]'
-- Add additional matchpairs
vim.cmd[[set matchpairs+=「:」,『:』,【:】,《:》,〈:〉,［:］,':',":",（:）]]
vim.cmd[[set fillchars+=eob:\ ]]
vim.opt.matchtime = 1
vim.opt.mouse = 'a'
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 2
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.showtabline = 2
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.spell = true
vim.opt.spelllang:append({'cjk'})
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.updatetime = 300

-- Color scheme
vim.cmd[[set background=light]]
vim.cmd[[syntax enable]]
vim.cmd[[colorscheme lucius]]

-- Leader key
vim.g.mapleader = ','

-- Basic keymaps
vim.api.nvim_set_keymap('', '<leader>w', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<leader>q', ':q<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<leader>sv', ':source $MYVIMRC<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<leader>ev', ':edit $MYVIMRC<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<leader>ee', ':e!<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<leader>g', ':Git<CR>', { noremap = true })

-- Terminal escape
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- Neosnippet
vim.api.nvim_set_keymap('', '<leader>k', '<Plug>(neosnippet_expand_or_jump)', {})
vim.api.nvim_set_keymap('s', '<leader>k', '<Plug>(neosnippet_expand_or_jump)', {})
vim.api.nvim_set_keymap('x', '<leader>k', '<Plug>(neosnippet_expand_target)', {})

-- Japanese input with tuskk
vim.api.nvim_set_keymap('i', '<C-j>', [[<Cmd>call tuskk#toggle()<CR>]], {})
vim.api.nvim_set_keymap('c', '<C-j>', 'call tuskk#cmd_buf()', { expr = true })
vim.call("tuskk#initialize", {})

-- CoC configuration
vim.api.nvim_set_keymap('i', '<C-g>', 'coc#pum#visible() ? coc#pum#confirm() : "<C-g>"', { silent = true, expr = true })

-- Use <c-space> to trigger completion
vim.api.nvim_set_keymap('i', '<c-space>', 'coc#refresh()', { silent = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics
vim.api.nvim_set_keymap('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
vim.api.nvim_set_keymap('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true })

-- GoTo code navigation
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', { silent = true })

-- Use K to show documentation in preview window
vim.api.nvim_set_keymap('n', 'K', ':lua ShowDocumentation()<CR>', { silent = true, noremap = true })

function ShowDocumentation()
  if vim.fn.CocAction('hasProvider', 'hover') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_feedkeys('K', 'in', false)
  end
end

-- Highlight the symbol and its references when holding the cursor
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    vim.fn.CocActionAsync('highlight')
  end
})

-- Map function and class text objects
vim.api.nvim_set_keymap('x', 'if', '<Plug>(coc-funcobj-i)', {})
vim.api.nvim_set_keymap('o', 'if', '<Plug>(coc-funcobj-i)', {})
vim.api.nvim_set_keymap('x', 'af', '<Plug>(coc-funcobj-a)', {})
vim.api.nvim_set_keymap('o', 'af', '<Plug>(coc-funcobj-a)', {})
vim.api.nvim_set_keymap('x', 'ic', '<Plug>(coc-classobj-i)', {})
vim.api.nvim_set_keymap('o', 'ic', '<Plug>(coc-classobj-i)', {})
vim.api.nvim_set_keymap('x', 'ac', '<Plug>(coc-classobj-a)', {})
vim.api.nvim_set_keymap('o', 'ac', '<Plug>(coc-classobj-a)', {})

-- Remap <C-f> and <C-b> to scroll float windows/popups
vim.api.nvim_set_keymap('n', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', { silent = true, nowait = true, expr = true })
vim.api.nvim_set_keymap('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', { silent = true, nowait = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-f>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', { silent = true, nowait = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-b>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', { silent = true, nowait = true, expr = true })
vim.api.nvim_set_keymap('v', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', { silent = true, nowait = true, expr = true })
vim.api.nvim_set_keymap('v', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', { silent = true, nowait = true, expr = true })

-- CoC actions
vim.api.nvim_set_keymap('n', '<leader>a', '<Plug>(coc-codeaction-selected)', {})
vim.api.nvim_set_keymap('x', '<leader>a', '<Plug>(coc-codeaction-selected)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>cl', '<Plug>(coc-codelens-action)', {})
vim.api.nvim_set_keymap('n', '<leader>e', '<Cmd>CocCommand explorer<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>qf', '<Plug>(coc-fix-current)', {})
vim.api.nvim_set_keymap('n', '<leader>r', '<Cmd>CocCommand rust-analyzer.run<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>re', '<Plug>(coc-codeaction-refactor)', {})
vim.api.nvim_set_keymap('x', '<leader>r', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', {})
vim.api.nvim_set_keymap('n', '<leader>u', '<Cmd>CocCommand rust-analyzer.moveItemUp<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>d', '<Cmd>CocCommand rust-analyzer.moveItemDown<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>t', '<Cmd>CocCommand rust-analyzer.testCurrent<CR>', {})

-- File type specific settings
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.ejs",
  command = "set filetype=html"
})

-- Status line configuration with lualine (modern, recommended for NeoVim)
local function setup_statusline()
  local function tuskk_status()
    if vim.call("tuskk#is_enabled") then return 'あ' else return 'A' end
  end

  -- Set up lualine with a style similar to airline
  local lualine = require('lualine')
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
        function() return vim.fn['coc#status']() end
      },
      lualine_x = { 
        function() 
          if vim.fn['coc#status']() ~= '' then
            return vim.fn['coc#status']()
          end
          return ''
        end,
        'filetype'
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    }
  })
end

-- Set up the status line
setup_statusline()

-- Icon configuration
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"fern", "nerdtree", "startify"},
  callback = function()
    if vim.fn.exists('*glyph_palette#apply') == 1 then
      vim.fn['glyph_palette#apply']()
    end
  end
})

-- Plugin settings
vim.g.gitgutter_enabled = true
vim.g.gundo_prefer_python3 = 1
vim.g.rustfmt_autosave = 1
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
