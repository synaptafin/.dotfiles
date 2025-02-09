-- Entry for neovim config

-- Keymap before plugin loaded for basic keymap, which can be override by plugin keymap config
require "config.keymaps"

-- lazy plugin manager
require "plugins.lazynvim"

-- Color
-- require "plugins.colorscheme"

-- Configuration plugin managed by lazynvim
require "plugins.cmp"
require "plugins.lsp"
require "plugins.treesitter"
require "plugins.telescope"
require "plugins.fzf-lua"
require "plugins.nvim-tree"  -- file explorer

require "plugins.lualine"
require "plugins.luasnip"
require "plugins.hop";
require "plugins.autopairs"
require "plugins.mini"
require "plugins.indent_blankline"
require "plugins.gitsigns"
require "plugins.file-outline"
require "plugins.whichkey"
require "plugins.copilot"
require "plugins.lsp-signature"
require "plugins.functions"

-- debug plugin inactivate
-- require "plugins.nvim-dap"
-- require "plugins.nvim-dap-ui"

-- Options after plugin loaded for override plugin default options
require "config.options"

-- legacy setup
-- require "plugins.bufferline"

