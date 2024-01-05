local lualine = require("lualine")

local show_in_width = function()
  return vim.fn.winwidth(0) > 150
end

local palette = require("plugins.mini").palette

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
  separator = { right = ""},
  sources = { "nvim_lsp", "vim_lsp" },
  symbols = { error = " ", warn = " ", info = " " },
  sections = { "error", "warn", "info" },
  update_in_insert = false,
  always_visible = true,
  cond = show_in_width,
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
  separator = { right = "" },
  fmt = function(str)
    return string.sub(str, 1, 3)
  end,
}

local filetype = {
  "filetype",
  cond = show_in_width,
  icons_enabled = true,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
  separator = { right = "" },
}

local location = {
  "location",
  cond = show_in_width,
}
local file_path = {
  function()
    local path = vim.fn.expand('%:p')
    -- local _, _, dir_file = string.find(path, "([^/]+/[^/]+)$")
    local workspace = vim.fn.getcwd()
    local function escape_pattern(pattern)
      return pattern:gsub('[%-%.%+%[%]%(%)%$%^%%%?%*]','%%%1')
    end

    local escaped_workspace = escape_pattern(workspace)
    local file_path = string.gsub(path, escaped_workspace .. "/", "")
    return file_path
  end,
  color = { gui = "bold" },
  fmt = function(str)
    return str .. " "
  end
}

local workspace = {
  function()
    local workspace = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    return workspace
  end,
  icon = '',
  color = { fg = palette.yellow },
  padding = 0,
}

-- local progress = function()
-- 	local current_line = vim.fn.line(".")
-- 	local total_lines = vim.fn.line("$")
-- 	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
-- 	local line_ratio = current_line / total_lines
-- 	local index = math.ceil(line_ratio * #chars)
-- 	return chars[index]
-- end

local progress = {
  "progress",
  padding = 0,
  fmt = function(str)
    return " " .. str
  end
}


local function rgb_escaper(hex)

  local dec = tonumber(hex:sub(2), 16)
  local b = math.fmod(dec, 256)
  local g = math.fmod((dec - b) / 256, 256)
  local r = math.floor(dec / (256 * 256))

  return string.format("\27[38;2;%d;%d;%dm", r, g, b)
end

local color_reset = "\27[0m"

local copilot_indicator = {
  function()
    local client = vim.lsp.get_active_clients({ name = "copilot" })[1]
    if client == nil then
      return ""
      -- return rgb_escaper(palette.red) .. "" .. color_reset
    end

    if vim.tbl_isempty(client.requests) then
      return "" -- default icon whilst copilot is idle
      -- return rgb_escaper(palette.cyan) .. "" .. color_reset
    end

    -- local spinners = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
    -- local ms = vim.loop.hrtime() / 1000000
    -- local frame = math.floor(ms / 120) % #spinners

    return ""
    -- return rgb_escaper(palette.green) .. "" .. color_reset
  end,

  cond = show_in_width,
}


local spaces = {
  function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end,
  cond = show_in_width,
}

local encoding = {
  "encoding",
  cond = show_in_width,
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
    lualine_c = { file_path, workspace },
    -- lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_x = { diff, spaces, encoding, filetype, copilot_indicator },
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
