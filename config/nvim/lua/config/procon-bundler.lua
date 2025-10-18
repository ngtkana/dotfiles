local M = {}

-- ライブラリディレクトリのパス
local LIBS_DIR = vim.fn.expand("~/repos/ac-adapter-rs/libs")

-- ライブラリ一覧を取得
function M.get_libraries()
  local handle = io.popen("ls -1 " .. LIBS_DIR)
  if not handle then
    vim.notify("Failed to list libraries", vim.log.levels.ERROR)
    return {}
  end
  
  local result = handle:read("*a")
  handle:close()
  
  local libraries = {}
  for lib in result:gmatch("[^\r\n]+") do
    table.insert(libraries, lib)
  end
  
  return libraries
end

-- procon-bundler を実行してバッファに挿入
function M.bundle_library(library_name)
  local cmd = string.format("procon-bundler bundle %s/%s", LIBS_DIR, library_name)
  
  local handle = io.popen(cmd)
  if not handle then
    vim.notify("Failed to execute procon-bundler", vim.log.levels.ERROR)
    return
  end
  
  local output = handle:read("*a")
  handle:close()
  
  -- 現在のバッファの最後に挿入
  local lines = vim.split(output, "\n")
  local buf = vim.api.nvim_get_current_buf()
  local line_count = vim.api.nvim_buf_line_count(buf)
  
  vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, lines)
  
  vim.notify(string.format("Bundled: %s", library_name), vim.log.levels.INFO)
end

-- Telescope でライブラリを選択
function M.select_and_bundle()
  local pickers = require("telescope.pickers")
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

