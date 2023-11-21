-- Entry for neovim config

-- Keymap before plugin loaded for basic keymap, which can be override by plugin keymap config
require "config.keymaps"

-- lazy plugin manager
require "plugins.lazynvim"

-- Configuration plugin managed by lazynvim
require "plugins.cmp"
require "plugins.lsp"
require "plugins.treesitter"
require "plugins.telescope"
require "plugins.nvim-tree"
require "plugins.whichkey"
require "plugins.copilot"
require "plugins.lualine"
require "plugins.symbols-outline"
require "plugins.luasnip"
require "plugins.hop";
require "plugins.autopairs"
require "plugins.nvim-dap"
require "plugins.nvim-dap-ui"
require "plugins.mini"
require "plugins.indent_blankline"
require "plugins.gitsigns"
require "plugins.functions"
require "plugins.lsp-signature"

-- Options after plugin loaded for override plugin default options
require "config.options"

-- legacy setup
-- require "plugins.packer"
-- require "plugins.bufferline"
-- require "plugins.toggleterm"

