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
    -- vim.cmd([[
    --   augroup lsp_document_highlight
    --     autocmd! * <buffer>
    --     autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    --     autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    --   augroup END
    -- ]])
  end
end

vim.g.diagnostic_virtual_text_enabled = true
function _G.toggle_virtual_text()
  vim.g.diagnostic_virtual_text_enabled = not vim.g.diagnostic_virtual_text_enabled
  vim.diagnostic.config({
    virtual_text = vim.g.diagnostic_virtual_text_enabled,
  })
end

local opts = { noremap = true, silent = true }
local goto_opts = {
  border = "rounded",
  severity = {
    min = vim.diagnostic.severity.WARN,
  }
}

local vsplit_opts = {
  jump_type = "vsplit",
}

local goto_definition_in_split = function()

  -- Execute 'definition' request and handle the result
  vim.lsp.buf_request(0, 'textDocument/definition', vim.lsp.util.make_position_params(),
    function(err, result, ctx, config)
      if err then
        print("Error: " .. err.message)
        return
      end
      if not result or vim.tbl_isempty(result) then
        print("No definition found")
        return
      end

      -- Handling the possibility of a result being directly a location or a list of locations
      local def = result[1] or result
      if not def.uri then
        print("Definition missing URI")
        return
      end

      local target_buf = vim.uri_to_bufnr(vim.uri_from_buf(def.uri))
      if not target_buf or target_buf == 0 then
        print("Failed to resolve definition buffer from URI")
        return
      end

      local target_pos = def.range.start

      -- Check current window and move to the next one
      local current_win = vim.api.nvim_get_current_win()
      vim.cmd('wincmd w')   -- This cycles to the next window

      -- If still in the same window, split vertically
      if current_win == vim.api.nvim_get_current_win() then
        vim.cmd('vsplit')
      end

      -- Ensure buffer is loaded before setting it
      vim.api.nvim_buf_set_lines(target_buf, 0, -1, false, vim.api.nvim_buf_get_lines(target_buf, 0, -1, false))
      vim.api.nvim_set_current_buf(target_buf)
      vim.api.nvim_win_set_cursor(0, { target_pos.line + 1, target_pos.character })
    end)
end




local function lsp_keymaps()
  vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions() end, opts)
  -- vim.keymap.set('n', 'gv', goto_definition_in_split, opts) -- TODO: go to definition in split
  vim.keymap.set('n', 'gh', function() vim.lsp.buf.hover() end, opts)
  -- vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  -- vim.keymap.set('n', '<leader>k', function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set('n', 'gr', function() require('telescope.builtin').lsp_references({ include_declaration = false }) end,
    { noremap = true, silent = true })
  -- vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', 'gp', function() vim.diagnostic.goto_prev(goto_opts) end, opts)
  vim.keymap.set('n', 'gn', function() vim.diagnostic.goto_next(goto_opts) end, opts)
  vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set('n', '<leader>d', function() toggle_virtual_text() end, opts)
  vim.keymap.set('n', '<leader>q', function() vim.diagnostic.setloclist() end, opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

M.on_attach = function(client)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
  if client.server_capabilities.signatureHelpProvider then
    require('lsp-overloads').setup(client, {})
  end
  lsp_keymaps()
  lsp_highlight_document(client)
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
  M.capabilities.textDocument.completion.completionItem.snippetSupport = true
  M.capabilities.workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = true,
    }
  }
end

return M
