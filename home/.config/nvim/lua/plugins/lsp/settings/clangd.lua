local M = {}

M.setup_condition = true
M.setup_options = {
  cmd = { "clangd", "--offset-encoding=utf-16" },
}
return M
