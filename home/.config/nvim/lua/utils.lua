local M = { }

---@type fun(function):nil
function M.operation_in_split(operation)
  local function is_normal_window(win)
    local available = false
    local config = vim.api.nvim_win_get_config(win)
    if not config.relative or config.relative == "" then
      available = true
    end
    return available
  end

  local wins = vim.api.nvim_tabpage_list_wins(0)
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local current_buf = vim.api.nvim_get_current_buf()
  local current_win_id = vim.api.nvim_get_current_win()
  local split_win_id = nil

  -- search for opened normal split window
  for _, win_id in pairs(wins) do
    if win_id ~= current_win_id and is_normal_window(win_id) then
      split_win_id = win_id
      break
    end
  end

  if split_win_id then
    vim.api.nvim_set_current_win(split_win_id)
    local half_width = math.floor(vim.o.columns / 2)
    vim.api.nvim_win_set_width(split_win_id, half_width)
    vim.api.nvim_win_set_buf(split_win_id, current_buf)
    vim.api.nvim_win_set_cursor(split_win_id, cursor_pos)
  else
    vim.api.nvim_open_win(0, true, { split = 'right', win = 0, })
  end
  operation()
end

function M.is_vue_project()
  local paths = vim.fs.find('@vue', { path = "./node_modules", type = 'directory' })
  return #paths > 0
end

function M.toggle_diagnostic_virtual_text()
  vim.g.diagnostic_virtual_text_enabled = not vim.g.diagnostic_virtual_text_enabled
  vim.diagnostic.config({
    virtual_text = vim.g.diagnostic_virtual_text_enabled,
  })
end


function M.diagnostic_goto_opts(count)
  return {
    count = count,
    float = true,
    border = "rounded",
    severity = {
      min = vim.diagnostic.severity.WARN,
    }
  }
end

M.listed_borders = {
  { "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌" },
  { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" },
}

return M
