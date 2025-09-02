local enabled_servers = require("config.lsp.general-opts").enabled_servers
local general_client_opts = require("config.lsp.general-opts").general_client_opts

local diagnostic_config = {
  virtual_text = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style     = "minimal",
    border    = "rounded",
    source    = "always",
    header    = "",
    prefix    = "",
  },
  signs = {
    priority = 10,
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.INFO]  = "",
      [vim.diagnostic.severity.HINT]  = "",
    },
    -- linehl = {
    --   [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
    -- },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
    },
  }
}

local lsp_overloads_opts = {
  ui = {
    border = "single", -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
    height = nil,      -- Height of the signature popup window (nil allows dynamic sizing based on content of the help)
    width = nil,       -- Width of the signature popup window (nil allows dynamic sizing based on content of the help)
    wrap = true,       -- Wrap long lines
    wrap_at = nil,     -- Character to wrap at for computing height when wrap enabled
    max_width = nil,   -- Maximum signature popup width
    max_height = nil,  -- Maximum signature popup height
    -- Events that will close the signature popup window: use {"CursorMoved", "CursorMovedI", "InsertCharPre"} to hide the window when typing
    close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
    focusable = true,                       -- Make the popup float focusable
    focus = false,                          -- If focusable is also true, and this is set to true, navigating through overloads will focus into the popup window (probably not what you want)
    offset_x = 0,                           -- Horizontal offset of the floating window relative to the cursor position
    offset_y = 0,                           -- Vertical offset of the floating window relative to the cursor position
    floating_window_above_cur_line = false, -- Attempt to float the popup above the cursor position
    -- (note, if the height of the float would be greater than the space left above the cursor, it will default
    -- to placing the float below the cursor. The max_height option allows for finer tuning of this)
    silent = true, -- Prevents noisy notifications (make false to help debug why signature isn't working)
    -- Highlight options is null by default, but this just shows an example of how it can be used to modify the LspSignatureActiveParameter highlight property
    highlight = {
      italic = true,
      bold = true,
      fg = "#ffffff",
      ... -- Other options accepted by the `val` parameter of vim.api.nvim_set_hl()
    }
  },
  keymaps = {
    next_signature = "<C-n>",
    previous_signature = "<C-p>",
    next_parameter = "<C-l>",
    previous_parameter = "<C-h>",
    close_signature = "<A-s>"
  },
  display_automatically = true -- Uses trigger characters to automatically display the signature overloads when typing a method signature

}

local signature_help_config = {
  offset_x = 300
}

vim.diagnostic.config(diagnostic_config)


for _, server_name in pairs(enabled_servers) do
  server_name = vim.split(server_name, "@")[1]
  vim.lsp.enable(server_name)
  -- local is_ok, custom_config = pcall(require, "config.lsp.opts." .. server_name)
  local custom_config = require("config.lsp.opts." .. server_name)

  -- if not is_ok then
  --   print("No custom config found for " .. server_name .. ", using default config.")
  --   custom_config = {}
  -- end

  local server_config = vim.tbl_deep_extend("force", general_client_opts, custom_config)
  vim.lsp.config(server_name, server_config)
end
