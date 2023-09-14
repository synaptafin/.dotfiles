
vim.opt.shiftwidth = 2
-- vim.opt.softtabstop = 4
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.numberwidth = 4
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.showmode = false
vim.opt.backup = false
vim.opt.showtabline = 2
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.pumheight = 10
vim.opt.autowriteall = true
vim.opt.termguicolors = true
vim.opt.shell = 'fish'
vim.opt.relativenumber = false
vim.opt.mouse = "a"
vim.opt.splitbelow = true
-- vim.opt.splitright = true
vim.opt.showtabline = 0
vim.opt.timeoutlen = 800

-- vim.cmd('hi Normal guibg=NONE ctermbg=NONE') -- for transparent background
-- vim.cmd('hi WinSeparator guifg=#85877C guibg=#85877C')

-- floating window color scheme
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#85877C', bg = '#85877C' })
vim.api.nvim_set_hl(0, 'FloatBorder', {bg='#3B4252', fg='#5E81AC'})
vim.api.nvim_set_hl(0, 'NormalFloat', {bg='#3B4252'})
vim.api.nvim_set_hl(0, 'TelescopeNormal', {bg='#3B4252'})
vim.api.nvim_set_hl(0, 'TelescopeBorder', {bg='#3B4252'})

vim.opt.diffopt = vim.opt.diffopt + "vertical"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.foldmethod = "syntax"
vim.opt.foldlevel = 99

