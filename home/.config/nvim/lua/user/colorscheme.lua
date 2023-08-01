local colorscheme = "tokyonight"

require("tokyonight").setup{
  style = "night",
  transparent = true,
}

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
end

