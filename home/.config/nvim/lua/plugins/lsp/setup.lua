local servers = require("plugins.lsp.servers")
local hover_opts = {
  border = "rounded",
}

local function keymap_opts(desc)
  if desc then
    return { noremap = true, silent = true, desc = desc }
  end
  return { noremap = true, silent = true }
end

local goto_opts = {
  border = "rounded",
  severity = {
    min = vim.diagnostic.severity.WARN,
  }
}

vim.g.diagnostic_virtual_text_enabled = true
function _G.toggle_diagnostic_virtual_text()
  vim.g.diagnostic_virtual_text_enabled = not vim.g.diagnostic_virtual_text_enabled
  vim.diagnostic.config({
    virtual_text = vim.g.diagnostic_virtual_text_enabled,
  })
end

local operation_in_split = require("plugins.lsp.utilities").operation_in_split
local function default_keymaps()
  vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions() end,
    keymap_opts("Go To Definition"))
  -- vim.keymap.set('n', 'gr', function() require('telescope.builtin').lsp_references({ include_declaration = false }) end, keymap_opts("Go To Reference"))
  vim.keymap.set('n', 'gr', require('plugins.fzf-lua').fzf_lua_references_with_opts, keymap_opts("Go To Reference"))

  vim.keymap.set('n', 'gh', function() vim.lsp.buf.hover(hover_opts) end, keymap_opts("Hover"))
  vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, keymap_opts("Declaration"))
  -- vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, keymap_opts("Implementation"))
  vim.keymap.set('n', 'gi', require('plugins.fzf-lua').fzf_lua_implementations_with_opts,
    keymap_opts("Go To Implementation"))

  vim.keymap.set('n', 'gv',
    function() operation_in_split(vim.lsp.buf.definition) end,
    keymap_opts("Goto definition in split")
  )
  vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float() end, keymap_opts())
  vim.keymap.set('n', 'gs', function() require('fzf-lua').lsp_live_workspace_symbols() end,
    keymap_opts("Workspace Symbols"))
  vim.keymap.set('n', '<leader>lj', function() vim.diagnostic.goto_next(goto_opts) end, keymap_opts("Next Diagnostic"))
  vim.keymap.set('n', '<leader>lk', function() vim.diagnostic.goto_prev(goto_opts) end, keymap_opts("Prev Disgnostic"))
  vim.keymap.set('n', '<leader>ld', function() require('fzf-lua').lsp_document_diagnostics() end,
    keymap_opts("Document Diagnostics"))
  vim.keymap.set('n', '<leader>lD', function() toggle_diagnostic_virtual_text() end,
    { noremap = true, silent = true, desc = "Toggle disgnostic virtual text" })
  vim.keymap.set('n', '<leader>q', function() vim.diagnostic.setloclist() end, keymap_opts())
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlight then
    local group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = group,
      buffer = 0,
      callback = function()
        vim.lsp.buf.document_hightlight()
      end
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = group,
      buffer = 0,
      callback = function()
        vim.lsp.buf.clear_references()
      end
    })
  end
end

local function base_on_attach(client)
  default_keymaps()
  lsp_highlight_document(client)

  if (client.server_capabilities.signatureHelpProvider) then
    require("lsp-overloads").setup(client, {})
  end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.workspace = {
  didChangeWatchedFiles = {
    dynamicRegistration = true,
  }
}

for _, server_name in pairs(servers) do
  server_name = vim.split(server_name, "@")[1]
  local lsp_opts = {
    on_attach = base_on_attach,
    capabilities = capabilities,
  }

  local require_ok, server_opts = pcall(require, "plugins.lsp.settings." .. server_name)

  if (require_ok) then
    local extra_on_attach = server_opts.setup_options.on_attach
    if (extra_on_attach) then
      server_opts.setup_options.on_attach = function(client)
        base_on_attach(client)
        extra_on_attach(client)
      end
    end
    lsp_opts = vim.tbl_deep_extend("force", lsp_opts, server_opts.setup_options)
    if server_opts.setup_condition then
      require("lspconfig")[server_name].setup(lsp_opts)
    end
  else
    require("lspconfig")[server_name].setup(lsp_opts)
  end
end
