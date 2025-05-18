require("eyeliner").setup({
  highlight_on_key = true, -- Highlight the closest identifier on keypress.
  dim = false,             -- Dim all other identifiers if set to true.

  -- set the maximum number of characters eyeliner.nvim will check from
  -- your current cursor position; this is useful if you are dealing with
  -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
  max_length = 9999,

  -- filetypes for which eyeliner should be disabled;
  -- e.g., to disable on help files:
  -- disabled_filetypes = {"help"}
  disabled_filetypes = {},

  -- buftypes for which eyeliner should be disabled
  -- e.g., disabled_buftypes = {"nofile"}
  disabled_buftypes = {},

  -- add eyeliner to f/F/t/T keymaps;
  -- see section on advanced configuration for more information
  default_keymaps = true,
})
