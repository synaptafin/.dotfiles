local enabled_servers = {
  "lua_ls",
  "pyright",
  "jsonls",
  "ts_ls",
  "marksman",
  "bashls",
  "tailwindcss",
  "clangd",
  "omnisharp",
  "html",
  "cssls",
  "vue_ls",
  "rust_analyzer",
}

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

local function general_on_attach(client, bufnr)
  lsp_highlight_document(client)

  if (client.server_capabilities.signatureHelpProvider) then
    require("lsp-overloads").setup(client, lsp_overloads_opts)
  end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.workspace = {
  didChangeWatchedFiles = {
    dynamicRegistration = true,
  }
}

return {
  general_client_opts = {
    on_attach = general_on_attach,
    capabilities = capabilities,
  },
  enabled_servers = enabled_servers,
}
