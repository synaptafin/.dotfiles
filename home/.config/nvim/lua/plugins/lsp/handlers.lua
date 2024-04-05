local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  -- local border = {
  --   { "", "FloatBorder" },
  --   { "▔", "FloatBorder" },
  --   { "", "FloatBorder" },
  --   { "▕", "FloatBorder" },
  --   { "", "FloatBorder" },
  --   { "▁", "FloatBorder" },
  --   { "", "FloatBorder" },
  --   { "▏", "FloatBorder" },
  -- }
  local border = "rounded"

  local config = {
    -- enable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style     = "minimal",
      border    = border,
      source    = "always",
      header    = "",
      prefix    = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

-- local diagnostics_active = true
-- function _G.toggle_virtual_text()
--   diagnostics_active = not diagnostics_active
--   if diagnostics_active then
--     vim.diagnostic.show()
--   else
--     vim.diagnostic.hide()
--   end
-- end

local goto_opts = {
  border = "rounded",
  severity = {
    vim.diagnostic.severity.ERROR,
  }
}


local function lsp_keymaps()
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions() end, opts)
  vim.keymap.set('n', 'gh', function() vim.lsp.buf.hover() end, opts)
  -- vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  -- vim.keymap.set('n', '<leader>k', function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set('n', 'gr', function() require('telescope.builtin').lsp_references({ include_declaration = false }) end,
    { noremap = true, silent = true })
  -- vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', 'gp', function() vim.diagnostic.goto_prev(goto_opts) end, opts)
  vim.keymap.set('n', 'gn', function() vim.diagnostic.goto_next(goto_opts) end, opts)
  vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float() end, opts)
  -- vim.keymap.set('n', '<leader>d', function() toggle_virtual_text() end, opts)
  vim.keymap.set('n', '<leader>q', function() vim.diagnostic.setloclist() end, opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

M.on_attach = function(client)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
  lsp_keymaps()
  lsp_highlight_document(client)
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = cmp_nvim_lsp.default_capabilities()
end

return M
