-- mini.align
require("mini.align").setup({
	-- No need to copy this inside `setup()`. Will be used automatically.
	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		start = "ga", -- abc
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
require("mini.comment").setup({})

-- mini.pairs
require("mini.pairs").setup({})

-- mini.hues
require("mini.hues").setup({ background = "#272a2c", foreground = "#d0d0e4", n_hues = 8, saturation = 'high' })

-- mini.hlpattern
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})
