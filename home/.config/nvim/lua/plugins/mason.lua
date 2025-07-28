local servers = require("config.lsp").enabled_servers

local mason_opts = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

require("mason").setup(mason_opts)
require("mason-lspconfig").setup({
  ensure_installed = servers,
  -- automatic_installation = true,
  -- automatic_enable = servers
})

