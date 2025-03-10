local os_name = vim.loop.os_uname().sysname
local global_node_modules_path = '/opt/homebrew/lib/node_modules/'
if os_name == 'Linux' then
  global_node_modules_path = '/usr/local/lib/node_modules/'
elseif os_name == 'Darwin' then
  global_node_modules_path = '/opt/homebrew/lib/node_modules/'
elseif os_name == 'Windows' then
  global_node_modules_path = 'C:\\Users\\username\\AppData\\Roaming\\npm\\node_modules\\'
end

local function vue_component_reference_request(volar_client, bufnr)
  if volar_client == nil then
    return
  end
  local request_method = "volar/client/findFileReference"
  local params = {
    textDocument = vim.lsp.util.make_text_document_params(bufnr),
  }
  volar_client.request(request_method, params, function(_, result, context)
    local items = vim.lsp.util.locations_to_items(result, volar_client.offset_encoding)
    vim.fn.setqflist({ }, ' ', { title = "Vue Component References", items = items, context = context })
    require('fzf-lua').quickfix()
  end)
end

local function override_keymap(client, bufnr)
  vim.keymap.set('n', 'gR', function() vue_component_reference_request(client, bufnr) end, { noremap = true, silent = true, buffer = true, desc = "Vue Component References" })
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
  on_attach = function(client, bufnr)
    override_keymap(client, bufnr)
  end
}

return M
