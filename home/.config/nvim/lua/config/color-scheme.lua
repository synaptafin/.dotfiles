local palette = require('plugins.mini').palette
local Colors = {
  DiagnosticError        = { fg = "#eb403a" },

  FloatBorder            = { fg = palette.fg_mid2, bg = palette.bg_edge },
  NormalFloat            = { bg = palette.bg_edge },

  --- FzfLua
  FzfLuaNormal           = { fg = palette.fg_edge, bg = palette.bg_edge2 },
  FzfLuaBorder           = { fg = palette.fg_edge, bg = palette.bg_edge2 },
  FzfLuaTitle            = { fg = palette.bg_edge2, bg = palette.red },

  FzfLuaPreviewNormal    = { fg = palette.fg_mid2, bg = palette.bg_edge2 },
  FzfLuaPreviewTitle     = { fg = palette.bg_edge2, bg = palette.cyan },
  FzfLuaPreviewBorder    = { fg = palette.bg_edge, bg = palette.bg_edge2 },
  FzfLuaCursor           = { fg = palette.bg_edge2, bg = palette.orange },
  FzfLuaCursorLine       = { fg = palette.bg_edge2, bg = palette.green },

  --- Telescope
  TelescopeBorder        = { fg = nil, bg = palette.bg_mid },
  TelescopeMatching      = { fg = palette.bg_edge2, bg = palette.green },
  -- TelescopeSelection     = { fg = palette.fg,   bg = palette.bg_mid2 },
  TelescopeNormal        = { fg = palette.fg_mid2, bg = palette.bg_mid },
  TelescopePromptTitle   = { fg = palette.bg_edge2, bg = palette.red },
  TelescopePromptNormal  = { fg = palette.fg, bg = palette.bg_edge },
  TelescopePromptBorder  = { fg = palette.bg_edge, bg = palette.bg_edge },
  -- TelescopePromptPrefix  = { fg = palette.blue  },
  TelescopeResultsNormal = { fg = palette.fg, bg = palette.bg_edge },
  TelescopeResultsTitle  = { fg = palette.bg_edge, bg = palette.bg_edge },
  TelescopeResultsBorder = { fg = palette.bg_edge, bg = palette.bg_edge },
  TelescopePreviewNormal = { fg = palette.fg_mid2, bg = palette.bg_edge },
  TelescopePreviewBorder = { fg = palette.bg_edge, bg = palette.bg_edge },
  TelescopePreviewTitle  = { fg = palette.bg_edge2, bg = palette.cyan },
  TelescopePreviewLine   = { fg = palette.bg_edge2, bg = palette.green },

  --- WhichKey
  WhichKeyFloat          = { fg = palette.bg_mid },

  --- eyeliner
  EyelinerPrimary        = { fg = "#fa2f4e", underline = true },
  EyelinerSecondary      = { fg = "#000000", bg="#ff6fff", underline = true },

  --- hop
  HopNextKey             = { fg = "#fa2f4e", bold = true, underline = true },
}

-- vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = palette.bg_mid })

for hl, col in pairs(Colors) do
  vim.api.nvim_set_hl(0, hl, col)
end

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
  end,
})
