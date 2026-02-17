--- ProCon Bundler ユーティリティ
--- 競技プログラミング用のライブラリをバンドルする機能を提供
local M = {}

-- 定数
local LIBS_DIR = vim.fn.expand("~/repos/ac-adapter-rs/libs")

--- ライブラリディレクトリの存在確認
---@return boolean exists ディレクトリが存在する場合true
local function check_libs_dir()
  local stat = vim.loop.fs_stat(LIBS_DIR)
  return stat ~= nil and stat.type == "directory"
end

--- ライブラリ一覧を取得
--- LIBS_DIRからライブラリ名のリストを取得する
---@return string[] libraries ライブラリ名の配列
function M.get_libraries()
  if not check_libs_dir() then
    require("fidget").notify(
      string.format("Library directory not found: %s", LIBS_DIR),
      vim.log.levels.ERROR
    )
    return {}
  end

  local handle = io.popen("ls -1 " .. LIBS_DIR .. " 2>/dev/null")
  if not handle then
    require("fidget").notify("Failed to list libraries", vim.log.levels.ERROR)
    return {}
  end

  local result = handle:read("*a")
  local success, _, exit_code = handle:close()

  if not success or (exit_code ~= nil and exit_code ~= 0) then
    require("fidget").notify("Failed to read library directory", vim.log.levels.ERROR)
    return {}
  end

  local libraries = {}
  for lib in result:gmatch("[^\r\n]+") do
    if lib ~= "" then
      table.insert(libraries, lib)
    end
  end

  return libraries
end

--- procon-bundlerを実行してバッファに挿入
--- 指定されたライブラリをバンドルし、現在のバッファの最後に挿入する
---@param library_name string バンドルするライブラリ名
function M.bundle_library(library_name)
  if not check_libs_dir() then
    require("fidget").notify(
      string.format("Library directory not found: %s", LIBS_DIR),
      vim.log.levels.ERROR
    )
    return
  end

  local lib_path = string.format("%s/%s", LIBS_DIR, library_name)

  -- ライブラリの存在確認
  local stat = vim.loop.fs_stat(lib_path)
  if not stat then
    require("fidget").notify(
      string.format("Library not found: %s", library_name),
      vim.log.levels.ERROR
    )
    return
  end

  local cmd = string.format("procon-bundler bundle %s 2>&1", lib_path)

  local handle = io.popen(cmd)
  if not handle then
    require("fidget").notify("Failed to execute procon-bundler", vim.log.levels.ERROR)
    return
  end

  local output = handle:read("*a")
  local success, _, exit_code = handle:close()

  if not success or (exit_code ~= nil and exit_code ~= 0) then
    require("fidget").notify(
      string.format("procon-bundler failed:\n%s", output),
      vim.log.levels.ERROR
    )
    return
  end

  -- 現在のバッファの最後に挿入
  local lines = vim.split(output, "\n")
  local buf = vim.api.nvim_get_current_buf()
  local line_count = vim.api.nvim_buf_line_count(buf)

  vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, lines)

  require("fidget").notify(string.format("✓ Bundled: %s", library_name), vim.log.levels.INFO)
end

--- Telescopeでライブラリを選択
--- Telescopeのピッカーを使用してライブラリを選択し、バンドルする
function M.select_and_bundle()
  -- Telescope の遅延読み込みに対応
  local ok, pickers = pcall(require, "telescope.pickers")
  if not ok then
    require("fidget").notify("Telescope not available", vim.log.levels.ERROR)
    return
  end

  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local libraries = M.get_libraries()

  if #libraries == 0 then
    require("fidget").notify("No libraries found in " .. LIBS_DIR, vim.log.levels.WARN)
    return
  end

  pickers.new({}, {
    prompt_title = "AC Adapter Libraries",
    finder = finders.new_table({
      results = libraries,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          M.bundle_library(selection[1])
        end
      end)
      return true
    end,
  }):find()
end

return M
