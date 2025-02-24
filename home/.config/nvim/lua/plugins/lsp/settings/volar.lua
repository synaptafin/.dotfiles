
local os_name = vim.loop.os_uname().sysname
local global_node_modules_path = '/opt/homebrew/lib/node_modules/'
if os_name == 'Linux' then
  global_node_modules_path = '/usr/local/lib/node_modules/'
elseif os_name == 'Darwin' then
  global_node_modules_path = '/opt/homebrew/lib/node_modules/'
elseif os_name == 'Windows' then
  global_node_modules_path = 'C:\\Users\\username\\AppData\\Roaming\\npm\\node_modules\\'
end

local M = { }

M.setup_condition = require("plugins.lsp.utilities").is_vue_project()

M.setup_options = {
  filetypes = { 'typescript', 'javascript', 'vue' },
  init_options = {
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = global_node_modules_path .. 'typescript/lib',
    },
  },
  autostart = true,
}

return M
