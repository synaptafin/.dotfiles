local hop = require("hop")

local opts = {
  keys = 'etovxqpdygfblzhckisuran'
}

hop.setup(opts)

---@diagnostic disable: missing-parameter
vim.keymap.set("n", "s", function() hop.hint_char2() end, { remap = true })

