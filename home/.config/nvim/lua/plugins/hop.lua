local hop = require("hop")

local opts = {
  keys = 'etovxqpdygfblzhckisuran'
}

hop.setup(opts)

local hint_char2_opts = {
  keys = 'etovxqpdygfblzhckisuran',
}

---@diagnostic disable: missing-parameter
vim.keymap.set("n", "s", function() hop.hint_char2() end, { remap = true })

local hint_char1_opts = {

  current_line_only = true,
  dim_unmatched = false,
}
vim.keymap.set("n", "f", function() hop.hint_char1(hint_char1_opts) end, { remap = true })

