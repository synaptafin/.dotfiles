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
require("mini.comment").setup({
  options = {
    custom_commentstring = function()
      return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
    end
  }
})

-- mini.hues
require("mini.hues").setup({ background = "#272a2c", foreground = "#d0d0e4", n_hues = 8, saturation = 'high' })

-- mini.hlpattern
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

-- telescope doesn't integrate with color config
-- so set it manually with mini.hues module
local palette = require("mini.hues").make_palette({
	background = "#3b4252",
	foreground = "#d0d0e4",
	n_hues = 8,
	saturation = "high",
})

--- palette table keys
---   bg, bg_edge2,bg_edge, bg_mid, bg_mid2
---   fg, fg_edge2, fg_edge, fg_mid, fg_mid2
---   red, red_bg
---   orange, orange_bg
---   yellow, yellow_bg
---   green, green_bg
---   cyan, cyan_bg
---   azure, azure_bg
---   blue, blue_bg
---   purple, purple_bg

local TelescoperColor = {
	TelescopeMatching      = { fg = palette.yellow },
	-- TelescopeSelection     = { fg = palette.fg,   bg = palette.bg_mid2 },
	-- TelescopePromptPrefix  = { fg = palette.blue  },
	-- TelescopePromptNormal  = { fg = palette.fg    },
	-- TelescopeResultsNormal = { fg = palette.fg,   bg = palette.bg      },
	-- TelescopePreviewnormal = { fg = nil,          bg = nil             },
	-- TelescopePromptBorder  = { fg = nil,          bg = nil             },
	-- TelescopePreviewBorder = { fg = nil,          bg = nil             },
	-- TelescopePromptTitle   = { fg = nil,          bg = nil             },
	-- TelescopeResultsTitle  = { fg = nil,          bg = nil             },
	-- TelescopePreviewTitle  = { fg = nil,          bg = nil             },
}

for hl, col in pairs(TelescoperColor) do
	vim.api.nvim_set_hl(0, hl, col)
end
