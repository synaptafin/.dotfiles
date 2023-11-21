local lualine = require("lualine")

local hide_in_width = function()
	return vim.fn.winwidth(0) > 120
end

local palette = require("mini.hues").make_palette({
	background = "#272a2c",
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

local theme = {
	normal = {
		a = { fg = palette.blue_bg, bg = palette.blue },
		b = { fg = palette.fg_edge2, bg = palette.bg_mid },
		c = { fg = palette.fg_edge2, bg = palette.bg_edge },
		x = { fg = palette.fg_edge2, bg = palette.bg_edge },
		y = { fg = palette.fg_edge2, bg = palette.bg_edge },
		z = { fg = palette.fg_edge2, bg = palette.bg_edge },
	},
	insert = {
		a = { fg = palette.green_bg, bg = palette.green },
	},
	visual = {
		a = { fg = palette.purple_bg, bg = palette.purple },
	},
	command = {
		a = { fg = palette.red_bg, bg = palette.red },
	},
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_lsp", "vim_lsp"  },
	symbols = { error = " ", warn = " ", info = " " },
	sections = { "error", "warn", "info" },
	update_in_insert = false,
	always_visible = true,
	-- color = { fg = palette.fg_mid, bg = palette.bg_mid },
	diagnostics_color = {
		error = { fg = palette.red },
		warn = { fg = palette.yellow },
		info = { fg = palette.cyan },
	},
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  paddind = 0,
}

-- section
local mode = {
	"mode",
	fmt = function(str)
		return string.sub(str, 1, 3)
	end,
}

local filetype = {
	"filetype",
  cond = hide_in_width,
	icons_enabled = true,
	icon = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
  cond = hide_in_width,
}
local filename = {
  function()
    local path = vim.fn.expand('%:p')
    local _, _, dir_file = string.find(path, "([^/]+/[^/]+)$")
    return dir_file
  end,
	color = { gui = "bold" },
}

local workspace = {
	function()
		local workspace = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
		return workspace
	end,
  icon = '',
	color = { fg = palette.yellow },
}

local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local spaces = {
	function()
		return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
	end,
	cond = hide_in_width,
}

local encoding = {
  "encoding",
  cond = hide_in_width,
}

-- configuration
lualine.setup({
	options = {
		icons_enabled = true,
		-- theme = 'auto',
		theme = theme,
		component_separators = { left = "", right = "" },
		-- component = '|',
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { branch, diagnostics },
		lualine_c = { filename, workspace },
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { diff, spaces, encoding, filetype },
		lualine_y = { location },
		lualine_z = { progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
