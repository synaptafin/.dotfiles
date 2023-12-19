--- mini.nvim config
--- config information leverage mini.nvim
local M = {}

-- mini.align
require("mini.align").setup({
  -- No need to copy this inside `setup()`. Will be used automatically.
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    start = "ga",              -- abc
    start_with_preview = "gA", -- abc
  },

  -- Default options controlling alignment process
  options = {
    split_pattern = "",
    justify_side = "left",
    merge_delimiter = "",
  },

  -- Default steps performing alignment (if `nil`, default is used)
  steps = {
    pre_split = {},
    split = nil,
    pre_justify = {},
    justify = nil,
    pre_merge = {},
    merge = nil,
  },

  -- Whether to disable showing non-error feedback
  silent = false,
})

-- mini.comment
require("mini.comment").setup({
  options = {
    custom_commentstring = function()
      return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
    end
  }
})

-- mini.hues
local mini_hues_config = {
  background = "#242a2f",
  foreground = "#e3e8ea",
  n_hues     = 8,
  saturation = 'high',
  accent     = 'bg',
}

require("mini.hues").setup(mini_hues_config)

--- palette table keys
--   bg,     bg_edge2, bg_edge, bg_mid, bg_mid2
--   fg,     fg_edge2, fg_edge, fg_mid, fg_mid2
--   red,    red_bg
--   orange, orange_bg
--   yellow, yellow_bg
--   green,  green_bg
--   cyan,   cyan_bg
--   azure,  azure_bg
--   blue,   blue_bg
--   purple, purple_bg
M.palette = require("mini.hues").make_palette(mini_hues_config)

-- mini.hlpattern
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

return M
