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
  background = "#1d1a1f",
  foreground = "#efe9dc",
  -- foreground = "#1d242f",
  -- background = "#efe9dc",
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

--- mini.files
local mini_files = require("mini.files")

local mini_files_opts = {
  -- Customization of shown content
  content = {
    -- Predicate for which file system entries to show
    filter = nil,
    -- What prefix to show to the left of file system entry
    prefix = nil,
    -- In which order to show file system entries
    sort = nil,
  },

  -- Module mappings created only inside explorer.
  -- Use `''` (empty string) to not create one.
  mappings = {
    close       = '<ESC>',
    go_in       = 'l',
    go_in_plus  = 'L',
    go_out      = 'h',
    go_out_plus = 'H',
    mark_goto   = "'",
    mark_set    = 'm',
    reset       = '<BS>',
    -- reveal_cwd  = '<leader>e',
    show_help   = 'g?',
    synchronize = '=',
    trim_left   = '<',
    trim_right  = '>',
  },

  -- General options
  options = {
    -- Whether to delete permanently or move into module-specific trash
    permanent_delete = false,
    -- Whether to use for editing directories
    use_as_default_explorer = true,
  },

  -- Customization of explorer windows
  windows = {
    -- Maximum number of windows to show side by side
    max_number = math.huge,
    -- Whether to show preview of file/directory under cursor
    preview = true,
    -- Width of focused window
    width_focus = 50,
    -- Width of non-focused window
    width_nofocus = 15,
    -- Width of preview window
    width_preview = 25,
  },
}

local toggle_mini_files = function()
  if mini_files.close() then
    return;
  end
  if vim.bo.buftype ~= '' then return end
  mini_files.open(vim.api.nvim_buf_get_name(0), false)
  mini_files.reveal_cwd()
end

mini_files.setup(mini_files_opts)

vim.keymap.set("n", "<leader>e", toggle_mini_files, {  noremap = true, silent = true, desc = "Toggle mini.files" })

return M
