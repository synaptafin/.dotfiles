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

require("plugins.lsp.setup")
require("plugins.lsp.mason")
require("plugins.lsp.null-ls")
