-- ProCon Bundler ユーティリティ
local M = {}

-- 定数
local LIBS_DIR = vim.fn.expand("~/repos/ac-adapter-rs/libs")

-- ライブラリディレクトリの存在確認
---@return boolean
local function check_libs_dir()
  local stat = vim.loop.fs_stat(LIBS_DIR)
  if not stat or stat.type ~= "directory" then
    vim.notify(
      string.format("Library directory not found: %s", LIBS_DIR),
      vim.log.levels.ERROR
    )
    return false
  end
  return true
end

-- ライブラリ一覧を取得
---@return string[] list of library names
function M.get_libraries()
  if not check_libs_dir() then
    return {}
  end

  local handle = io.popen("ls -1 " .. LIBS_DIR .. " 2>/dev/null")
  if not handle then
    vim.notify("Failed to list libraries", vim.log.levels.ERROR)
    return {}
  end
  
  local result = handle:read("*a")
  local success, _, exit_code = handle:close()
  
  if not success or exit_code ~= 0 then
    vim.notify("Failed to read library directory", vim.log.levels.ERROR)
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

-- procon-bundler を実行してバッファに挿入
---@param library_name string library name to bundle
function M.bundle_library(library_name)
  if not check_libs_dir() then
    return
  end

  local lib_path = string.format("%s/%s", LIBS_DIR, library_name)
  
  -- ライブラリの存在確認
  local stat = vim.loop.fs_stat(lib_path)
  if not stat then
    vim.notify(
      string.format("Library not found: %s", library_name),
      vim.log.levels.ERROR
    )
    return
  end

  local cmd = string.format("procon-bundler bundle %s 2>&1", lib_path)
  
  local handle = io.popen(cmd)
  if not handle then
    vim.notify("Failed to execute procon-bundler", vim.log.levels.ERROR)
    return
  end
  
  local output = handle:read("*a")
  local success, _, exit_code = handle:close()
  
  if not success or exit_code ~= 0 then
    vim.notify(
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
  
  vim.notify(string.format("✓ Bundled: %s", library_name), vim.log.levels.INFO)
end

-- Telescope でライブラリを選択
function M.select_and_bundle()
  -- Telescope の遅延読み込みに対応
  local ok, pickers = pcall(require, "telescope.pickers")
  if not ok then
    vim.notify("Telescope not available", vim.log.levels.ERROR)
    return
  end

  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local libraries = M.get_libraries()
  
  if #libraries == 0 then
    vim.notify("No libraries found in " .. LIBS_DIR, vim.log.levels.WARN)
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
