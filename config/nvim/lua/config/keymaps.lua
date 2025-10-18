local map = vim.keymap.set

-- <leader>f{f,g,b,h}: telescope
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- <leader>ca: code action
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action" })

-- <leader>w: svre
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- <leader>sv: reload init.lua
map("n", "<leader>sv", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^user") or name:match("^config") or name:match("^plugins") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.fn.stdpath("config") .. "/init.lua")
  vim.notify("Reloaded init.lua and related modules", vim.log.levels.INFO)
end, { desc = "Reload init.lua" })

-- <leader>ev: open .config/nvim
map("n", "<leader>ev", function()
  vim.cmd("edit " .. vim.fn.stdpath("config"))
end, { desc = "Open config folder" })

-- <leader>fa: procon-bundler (find ac-adapter library)
map("n", "<leader>fa", function()
  require("config.procon-bundler").select_and_bundle()
end, { desc = "Find AC library" })


map("n", "<leader>cc", function()
  vim.notify("Running cargo check...", vim.log.levels.INFO)
  
  vim.fn.jobstart("cargo check", {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.notify("✓ cargo check passed", vim.log.levels.INFO)
      else
        vim.notify("✗ cargo check failed", vim.log.levels.ERROR)
        vim.cmd("copen")
      end
    end,
    stdout_buffered = true,
    stderr_buffered = true,
    on_stderr = function(_, data)
      if data and #data > 0 then
        vim.fn.setqflist({}, 'r', {
          title = 'cargo check',
          lines = data
        })
      end
    end,
  })
end, { desc = "Run cargo check" })

-- cargo run 用の専用バッファを取得または作成
local function get_or_create_cargo_buffer()
  local bufname = "cargo://output"
  
  -- 既存のバッファを探す
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf) == bufname then
      return buf
    end
  end
  
  -- 新規作成
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, bufname)
  vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
  vim.api.nvim_set_option_value('bufhidden', 'hide', { buf = buf })
  vim.api.nvim_set_option_value('swapfile', false, { buf = buf })
  vim.api.nvim_set_option_value('filetype', 'cargo-output', { buf = buf })
  
  return buf
end

-- cargo run 用の専用バッファを取得または作成
local function get_or_create_cargo_buffer()
  local bufname = "cargo://output"
  
  -- 既存のバッファを探す
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf) == bufname then
      return buf
    end
  end
  
  -- 新規作成
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, bufname)
  vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
  vim.api.nvim_set_option_value('bufhidden', 'hide', { buf = buf })
  vim.api.nvim_set_option_value('swapfile', false, { buf = buf })
  vim.api.nvim_set_option_value('filetype', 'cargo-output', { buf = buf })
  
  return buf
end

map("n", "<leader>cr", function()
  local input = vim.fn.getreg('+')
  local buf = get_or_create_cargo_buffer()
  
  -- バッファをクリア
  vim.api.nvim_set_option_value('modifiable', true, { buf = buf })
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {"Running cargo run..."})
  vim.api.nvim_set_option_value('modifiable', false, { buf = buf })
  
  local output = {}
  
  local job_id = vim.fn.jobstart("cargo run --quiet", {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(output, line)
          end
        end
      end
    end,
    on_stderr = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(output, line)
          end
        end
      end
    end,
    on_exit = function(_, exit_code)
      -- バッファに結果を書き込む
      vim.schedule(function()
        vim.api.nvim_set_option_value('modifiable', true, { buf = buf })
        
        local header = {
          string.rep("=", 60),  -- 修正
          exit_code == 0 and "✓ cargo run (exit code: 0)" or "✗ cargo run (exit code: " .. exit_code .. ")",
          string.rep("=", 60),  -- 修正
          "",
        }

        local all_lines = vim.list_extend(header, output)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, all_lines)
        vim.api.nvim_set_option_value('modifiable', false, { buf = buf })
        
        -- 通知
        if exit_code == 0 then
          vim.notify("✓ cargo run completed", vim.log.levels.INFO)
        else
          vim.notify("✗ cargo run failed", vim.log.levels.ERROR)
        end
        
        -- バッファを split で開く（既に開いていれば何もしない）
        local wins = vim.fn.win_findbuf(buf)
        if #wins == 0 then
          vim.cmd("botright split")
          vim.api.nvim_win_set_buf(0, buf)
          vim.cmd("resize 15")  -- 高さを15行に
          vim.cmd("wincmd p")   -- 元のウィンドウに戻る
        end
      end)
    end,
  })
  
  -- クリップボードの内容を標準入力として送信
  vim.fn.chansend(job_id, input)
  vim.fn.chanclose(job_id, 'stdin')
  
  vim.notify("Running cargo with clipboard input...", vim.log.levels.INFO)
end, { desc = "Run cargo with clipboard input" })

-- 結果バッファを開く/閉じるトグル用のキーマップ（オプション）
map("n", "<leader>co", function()
  local bufname = "cargo://output"
  local buf = nil
  
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(b) and vim.api.nvim_buf_get_name(b) == bufname then
      buf = b
      break
    end
  end
  
  if not buf then
    vim.notify("No cargo output buffer found", vim.log.levels.WARN)
    return
  end
  
  local wins = vim.fn.win_findbuf(buf)
  if #wins > 0 then
    -- 既に開いている場合は閉じる
    for _, win in ipairs(wins) do
      vim.api.nvim_win_close(win, false)
    end
  else
    -- 開いていない場合は開く
    vim.cmd("botright split")
    vim.api.nvim_win_set_buf(0, buf)
    vim.cmd("resize 15")
  end
end, { desc = "Toggle cargo output buffer" })
