local lualine = require("lualine")

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	sections = { "error", "warn", "info" },
	update_in_insert = false,
	always_visible = true,
	-- diagnostics_color = {
	-- 	error = { fg = colors.red },
	-- 	warn = { fg = colors.yellow },
	-- 	info = { fg = colors.cyan },
	-- },
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
}

-- section
local mode = {
	"mode",
	fmt = function(str)
		return str
	end,
}

local filetype = {
	"filetype",
	icons_enabled = false,
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
}
local filename = {
	"filename",
	color = { gui = "bold" },
}

local workspace = {
	function()
		local workspace = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
		return workspace
	end,
	-- color = { bg =colors.cyan, gui = "bold" },
}

local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

-- configuration
lualine.setup({
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = "", right = "" },
		-- component = '|',
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { branch, diagnostics },
		lualine_b = { workspace, filename },
		lualine_c = { mode },
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { diff, spaces, "encoding", filetype },
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
