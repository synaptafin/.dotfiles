if vim.g.vscode then
  -- for vscode-neovim only
  require "config.vscode-neovim"
else
  require "plugins.lazynvim"
  -- Keymap before plugin loaded for basic keymap, which can be override by plugin keymap config
  -- lazy plugin manager
  -- Color
  -- Configuration plugin managed by lazynvim
  require "config.keymaps"
  require "config.options"
  require "config.color-scheme"

  require "plugins.treesitter"
  require "plugins.hop";
  require "plugins.cmp"
  require "plugins.lsp"
  require "plugins.telescope"
  require "plugins.fzf-lua"
  require "plugins.nvim-tree" -- file explorer

  require "plugins.lualine"
  require "plugins.luasnip"
  require "plugins.autopairs"
  require "plugins.mini"
  require "plugins.indent_blankline"
  require "plugins.gitsigns"
  require "plugins.file-outline"
  require "plugins.whichkey"
  require "plugins.copilot"
  require "plugins.functions"
end

-- debug plugin inactivate
-- require "plugins.nvim-dap"
-- require "plugins.nvim-dap-ui"

