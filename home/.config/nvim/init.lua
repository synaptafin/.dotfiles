-- Entry for neovim config

-- Keymap before plugin loaded for basic keymap, which can be override by plugin keymap config
require "pluginconfig.keymaps"

-- lazy plugin manager
require "pluginconfig.lazynvim"

-- Configuration plugin managed by lazynvim
require "pluginconfig.cmp"
require "pluginconfig.lsp"
require "pluginconfig.telescope"
require "pluginconfig.treesitter"
require "pluginconfig.gitsigns"
require "pluginconfig.nvim-tree"
require "pluginconfig.whichkey"
require "pluginconfig.copilot"
require "pluginconfig.lualine"
require "pluginconfig.symbols-outline"
require "pluginconfig.luasnip"
require "pluginconfig.hop";
require "pluginconfig.autopairs"
require "pluginconfig.nvim-dap"
require "pluginconfig.nvim-dap-ui"
require "pluginconfig.mini"
require "pluginconfig.indent_blankline"
require "pluginconfig.functions"

-- Options after plugin loaded for override plugin default options
require "pluginconfig.options"

-- legacy setup
-- require "pluginconfig.packer"
-- require "pluginconfig.bufferline"
-- require "pluginconfig.toggleterm"
