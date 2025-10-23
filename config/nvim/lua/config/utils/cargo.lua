--- Cargo 関連のユーティリティ関数
--- Rustプロジェクトでのcargo実行を支援する機能を提供
local M = {}

-- 定数
local CARGO_INPUT_BUFFER_NAME = "cargo://input"
local CARGO_OUTPUT_BUFFER_NAME = "cargo://output"
local CARGO_WINDOW_WIDTH = 40
local CARGO_RUN_COMMAND = "cargo run --quiet"
local CARGO_CHECK_COMMAND = "cargo check"

--- 入力バッファを取得または作成
--- 既存のバッファがあればそれを返し、なければ新規作成する
---@return number buffer_number バッファ番号
function M.get_or_create_input_buffer()
  -- 既存のバッファを探す
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf) == CARGO_INPUT_BUFFER_NAME then
      return buf
    end
  end

  -- 新規作成
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, CARGO_INPUT_BUFFER_NAME)
  vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
  vim.api.nvim_set_option_value('bufhidden', 'hide', { buf = buf })
  vim.api.nvim_set_option_value('swapfile', false, { buf = buf })
  vim.api.nvim_set_option_value('filetype', 'text', { buf = buf })

  return buf
end

--- 出力バッファを取得または作成
--- 既存のバッファがあればそれを返し、なければ新規作成する
---@return number buffer_number バッファ番号
function M.get_or_create_output_buffer()
  -- 既存のバッファを探す
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf) == CARGO_OUTPUT_BUFFER_NAME then
      return buf
    end
  end

  -- 新規作成
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, CARGO_OUTPUT_BUFFER_NAME)
  vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
  vim.api.nvim_set_option_value('bufhidden', 'hide', { buf = buf })
  vim.api.nvim_set_option_value('swapfile', false, { buf = buf })
  vim.api.nvim_set_option_value('filetype', 'cargo-output', { buf = buf })

  return buf
end

--- 入力バッファに内容を書き込む
--- Windows改行コードを自動的に除去する
---@param buf number バッファ番号
---@param input string 書き込む入力テキスト
function M.write_input(buf, input)
  vim.api.nvim_set_option_value('modifiable', true, { buf = buf })
  -- Windows の改行コード (\r) を削除
  local cleaned_input = input:gsub("\r", "")
  local input_lines = vim.split(cleaned_input, "\n")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, input_lines)
end

--- 出力バッファに内容を書き込む
--- 実行結果と終了コードに応じて通知を表示する
---@param buf number バッファ番号
---@param lines string[] 書き込む行の配列
---@param exit_code number プロセスの終了コード
function M.write_output(buf, lines, exit_code)
  vim.schedule(function()
    vim.api.nvim_set_option_value('modifiable', true, { buf = buf })
    -- 成功・失敗に関わらず全出力を表示
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_set_option_value('modifiable', false, { buf = buf })

    -- 通知で成功/失敗を知らせる
    if exit_code == 0 then
      vim.notify("✓ cargo run completed", vim.log.levels.INFO)
    else
      vim.notify("✗ cargo run failed (exit code: " .. exit_code .. ")", vim.log.levels.ERROR)
    end
  end)
end

--- 2つのバッファを表示する
--- 右側に垂直分割し、上下に水平分割して入力・出力バッファを配置
---@param input_buf number 入力バッファ番号
---@param output_buf number 出力バッファ番号
function M.show_buffers(input_buf, output_buf)
  -- 既に表示されているか確認
  local input_wins = vim.fn.win_findbuf(input_buf)
  local output_wins = vim.fn.win_findbuf(output_buf)

  if #input_wins > 0 and #output_wins > 0 then
    -- 既に両方表示されている場合は何もしない
    return
  end

  -- 既存のウィンドウを閉じる
  for _, win in ipairs(input_wins) do
    vim.api.nvim_win_close(win, false)
  end
  for _, win in ipairs(output_wins) do
    vim.api.nvim_win_close(win, false)
  end

  -- 元のウィンドウを記憶
  local original_win = vim.api.nvim_get_current_win()

  -- 右側に垂直分割
  vim.cmd("botright vsplit")
  vim.cmd("vertical resize " .. CARGO_WINDOW_WIDTH)

  -- 入力バッファを表示
  vim.api.nvim_win_set_buf(0, input_buf)

  -- 上下に水平分割
  vim.cmd("split")

  -- 下側に出力バッファを表示
  vim.api.nvim_win_set_buf(0, output_buf)

  -- 元のウィンドウに戻る
  vim.api.nvim_set_current_win(original_win)
end

--- バッファの表示をトグルする
--- 開いている場合は閉じ、閉じている場合は開く
function M.toggle_buffers()
  local input_buf = nil
  local output_buf = nil

  -- バッファを探す
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(b) then
      local name = vim.api.nvim_buf_get_name(b)
      if name == CARGO_INPUT_BUFFER_NAME then
        input_buf = b
      elseif name == CARGO_OUTPUT_BUFFER_NAME then
        output_buf = b
      end
    end
  end

  if not input_buf and not output_buf then
    vim.notify("No cargo buffers found", vim.log.levels.WARN)
    return
  end

  -- ウィンドウを探す
  local input_wins = input_buf and vim.fn.win_findbuf(input_buf) or {}
  local output_wins = output_buf and vim.fn.win_findbuf(output_buf) or {}

  if #input_wins > 0 or #output_wins > 0 then
    -- どちらかが開いている場合は両方閉じる
    for _, win in ipairs(input_wins) do
      vim.api.nvim_win_close(win, false)
    end
    for _, win in ipairs(output_wins) do
      vim.api.nvim_win_close(win, false)
    end
  else
    -- 両方閉じている場合は開く
    if input_buf and output_buf then
      M.show_buffers(input_buf, output_buf)
    end
  end
end

--- cargo checkを実行する
--- エラーがある場合はquickfixリストを開く
function M.check()
  vim.notify("Running cargo check...", vim.log.levels.INFO)

  vim.fn.jobstart(CARGO_CHECK_COMMAND, {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.notify("✓ cargo check passed", vim.log.levels.INFO)
      else
        vim.notify("✗ cargo check failed", vim.log.levels.ERROR)
        vim.cmd("botright copen")
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
end

--- 入力バッファを開いて編集可能にする
--- バッファが空の場合はクリップボードの内容で初期化する
function M.open_input_buffer()
  local input_buf = M.get_or_create_input_buffer()
  local output_buf = M.get_or_create_output_buffer()

  -- クリップボードの内容で初期化（バッファが空の場合）
  local line_count = vim.api.nvim_buf_line_count(input_buf)
  local first_line = vim.api.nvim_buf_get_lines(input_buf, 0, 1, false)[1] or ""

  if line_count == 1 and first_line == "" then
    local clipboard = vim.fn.getreg('+')
    if clipboard ~= "" then
      M.write_input(input_buf, clipboard)
    end
  end

  -- バッファを表示
  M.show_buffers(input_buf, output_buf)

  -- 入力バッファにフォーカスを移動
  local input_wins = vim.fn.win_findbuf(input_buf)
  if #input_wins > 0 then
    vim.api.nvim_set_current_win(input_wins[1])
  end

  vim.notify("Edit input buffer and press <F5> to run", vim.log.levels.INFO)
end

--- 入力バッファの内容でcargo runを実行する
--- 入力バッファの内容を標準入力として渡す
function M.run_with_input_buffer()
  local input_buf = M.get_or_create_input_buffer()
  local output_buf = M.get_or_create_output_buffer()

  -- 入力バッファの内容を取得
  local input_lines = vim.api.nvim_buf_get_lines(input_buf, 0, -1, false)
  local input = table.concat(input_lines, "\n")

  if input == "" then
    vim.notify("Input buffer is empty", vim.log.levels.WARN)
    return
  end

  -- 出力バッファをクリア
  vim.api.nvim_set_option_value('modifiable', true, { buf = output_buf })
  vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, { "Running cargo run..." })
  vim.api.nvim_set_option_value('modifiable', false, { buf = output_buf })

  -- バッファを表示
  M.show_buffers(input_buf, output_buf)

  local output = {}

  local job_id = vim.fn.jobstart(CARGO_RUN_COMMAND, {
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
      M.write_output(output_buf, output, exit_code)
    end,
  })

  -- 入力バッファの内容を標準入力として送信
  vim.fn.chansend(job_id, input)
  vim.fn.chanclose(job_id, 'stdin')

  vim.notify("Running cargo with input buffer...", vim.log.levels.INFO)
end

--- cargo runをクリップボードの内容を入力として実行する
--- クリップボードの内容を入力バッファに保存してから実行
function M.run_with_clipboard()
  local input = vim.fn.getreg('+')
  local input_buf = M.get_or_create_input_buffer()
  local output_buf = M.get_or_create_output_buffer()

  -- 入力バッファに書き込む
  M.write_input(input_buf, input)

  -- 出力バッファをクリア
  vim.api.nvim_set_option_value('modifiable', true, { buf = output_buf })
  vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, { "Running cargo run..." })
  vim.api.nvim_set_option_value('modifiable', false, { buf = output_buf })

  -- バッファを表示
  M.show_buffers(input_buf, output_buf)

  local output = {}

  local job_id = vim.fn.jobstart(CARGO_RUN_COMMAND, {
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
      M.write_output(output_buf, output, exit_code)
    end,
  })

  -- クリップボードの内容を標準入力として送信
  vim.fn.chansend(job_id, input)
  vim.fn.chanclose(job_id, 'stdin')

  vim.notify("Running cargo with clipboard input...", vim.log.levels.INFO)
end

return M
