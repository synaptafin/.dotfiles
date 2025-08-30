require('onedark').setup({
  style = 'darker',
  diagnostics = {
    darker = false,    -- darker colors for diagnostic
    undercurl = true,  -- use undercurl instead of underline for diagnostics
    background = true, -- use background color for virtual text
  }

})
require('onedark').load()
local palette = require('plugins.mini').palette
local Colors = {
  Visual          = { bg = palette.green, fg = palette.bg_edge2 },
  DiagnosticError = { fg = "#eb403a" },

  FloatBorder     = { fg = "#fda339", bg = palette.bg_edge },
  NormalFloat     = { bg = palette.bg_edge },


  DiffAdd    = { fg = nil, bg = palette.green_bg },
  DiffChange = { fg = nil, bg = palette.cyan_bg },
  DiffDelete = { fg = nil, bg = palette.red_bg },
  DiffText   = { fg = nil, bg = palette.yellow_bg },


  --- FzfLua
  FzfLuaNormal                = { fg = palette.fg_edge, bg = palette.bg_edge2 },
  FzfLuaBorder                = { fg = palette.fg_edge, bg = palette.bg_edge2 },
  FzfLuaTitle                 = { fg = palette.bg_edge2, bg = palette.red },

  FzfLuaPreviewNormal         = { fg = palette.fg_mid2, bg = palette.bg_edge2 },
  FzfLuaPreviewTitle          = { fg = palette.bg_edge2, bg = palette.cyan },
  FzfLuaPreviewBorder         = { fg = palette.bg_edge, bg = palette.bg_edge2 },
  FzfLuaCursor                = { fg = palette.bg_edge2, bg = palette.orange },
  FzfLuaCursorLine            = { fg = palette.bg_edge2, bg = palette.green },

  --- WhichKey
  WhichKeyFloat               = { fg = palette.bg_mid },

  --- hop
  HopNextKey                  = { fg = "#fa2f4e", bold = true, underline = true },

  --- gitsigns
  GitSignsAdd                 = { fg = "#00fd3f" },
  GitSignsChange              = { fg = "#fdea00" },
  GitSignsDelete              = { fg = "#eb403a" },
  GitSignsStagedAdd           = { fg = "#00fd3f" },
  GitSignsStagedChange        = { fg = "#fdea00" },
  GitSignsStagedDelete        = { fg = "#eb403a" },
  GitSignsStagedUntracked     = { fg = "#00fd3f" },
  GitSignsStagedChangeddelete = { fg = "#fdea00" },
  GitSignsStagedTopdelete     = { fg = "#eb403a" },

  --- indent line ---
  IblScope                    = { fg = "#f1611c" },
  IblNonIndent                = { fg = palette.bg },
  IblIndent                   = { fg = "#444c5e" }
}

-- vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = palette.bg_mid })

for hl, col in pairs(Colors) do
  vim.api.nvim_set_hl(0, hl, col)
end
