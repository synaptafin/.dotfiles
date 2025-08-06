local servers = require("config.lsp.general-opts").enabled_servers

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

local mason_managed_servers = { }
for _, server in ipairs(servers) do
  if server ~= "marksman" then
    table.insert(mason_managed_servers, server)
  end
end

require("mason").setup(mason_opts)
require("mason-lspconfig").setup({
  ensure_installed = mason_managed_servers,
  -- automatic_installation = true,
  -- automatic_enable = servers
})

