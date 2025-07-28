local fzf_lua = require('fzf-lua')
local diagnostic_goto_opts = require('utils').diagnostic_goto_opts
local operation_in_split = require('utils').operation_in_split
local toggle_diagnostic_virtual_text = require("utils").toggle_diagnostic_virtual_text

local opts_desc = function(desc)
  if desc then
    return { noremap = true, silent = true, desc = desc }
  end
  return { noremap = true, silent = true }
end


--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts_desc())
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i", visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts_desc())
-- keymap("n", "<C-j>", "<C-w>j", opts_desc())
-- keymap("n", "<C-k>", "<C-w>k", opts_desc())
vim.keymap.set("n", "<C-l>", "<C-w>l", opts_desc())
vim.keymap.set('n', '<C-j>', '10j', opts_desc())
vim.keymap.set('n', '<C-k>', '10k', opts_desc())

-- Window Resize
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", opts_desc())
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", opts_desc())
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts_desc())
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts_desc())
vim.keymap.set("n", "<c-w>z", ":vertical resize | windcmd =<CR>", opts_desc("Maximize window width"))
vim.keymap.set("n", "<c-w>v", function() vim.api.nvim_open_win(0, true, { split = "right", win = 0 }) end,
  opts_desc("Split window vertically"))

vim.keymap.set("n", "^", 'v%<C-v>', opts_desc()) -- vertical select by match bracket/parentheses/braces
vim.keymap.set("n", "ge", "gi", opts_desc())

-- Visual --
vim.keymap.set('v', '<C-j>', '10j', opts_desc())
vim.keymap.set('v', '<C-k>', '10k', opts_desc())

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts_desc())
vim.keymap.set("v", ">", ">gv", opts_desc())
vim.keymap.set("v", "<D-c>", '"+y', opts_desc())

-- Visual Block --
-- Move text up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts_desc())
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts_desc())
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts_desc())
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts_desc())

vim.keymap.set({ "n", "v", "i" }, "<Del>", "<Nop>", opts_desc()) -- disable <Del> key
-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


-- Lsp Keymaps
vim.keymap.set('n', 'gd', function() fzf_lua.lsp_definitions() end,
  opts_desc("Go To Definition"))
vim.keymap.set('n', 'gr', require('plugins.fzf-lua').fzf_lua_references_with_opts, opts_desc("Go To Reference"))

vim.keymap.set('n', 'gh', function() vim.lsp.buf.hover({ border = "rounded" }) end, opts_desc("Hover"))
vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts_desc("Declaration"))
vim.keymap.set('n', 'gi', require('plugins.fzf-lua').fzf_lua_implementations_with_opts, opts_desc("Go To Implementation"))

vim.keymap.set('n', 'gvd',
  function() operation_in_split(fzf_lua.lsp_definitions) end,
  opts_desc("Goto definition in split")
)
vim.keymap.set('n', 'gvr',
  function() operation_in_split(require('plugins.fzf-lua').fzf_lua_references_with_opts) end,
  opts_desc("Goto reference in split")
)
vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float() end, opts_desc())
vim.keymap.set('n', 'gs', function() require('fzf-lua').lsp_live_workspace_symbols() end,
  opts_desc("Workspace Symbols"))
vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format() end, opts_desc('Format'))
vim.keymap.set('n', '<leader>lj', function() vim.diagnostic.jump(diagnostic_goto_opts(1)) end, opts_desc("Next Diagnostic"))
vim.keymap.set('n', '<leader>lk', function() vim.diagnostic.jump(diagnostic_goto_opts(-1)) end, opts_desc("Prev Disgnostic"))
vim.keymap.set('n', '<leader>ld', function() require('fzf-lua').lsp_document_diagnostics() end,
  opts_desc("Document Diagnostics"))
vim.keymap.set('n', '<leader>la', function() require('fzf-lua').lsp_code_actions() end, opts_desc("Code Actions"))
vim.keymap.set('n', '<leader>lD', toggle_diagnostic_virtual_text, { noremap = true, silent = true, desc = "Toggle disgnostic virtual text" })
vim.keymap.set('n', '<leader>lw', function() require('fzf-lua').diagnostics_workspace() end,
  opts_desc("Workspace Diagnostics"))
vim.keymap.set('n', '<leader>q', function() vim.diagnostic.setloclist() end, opts_desc())

-- git
vim.keymap.set('n', '<leader>gb', fzf_lua.git_branches, opts_desc("Git Branchs"))
vim.keymap.set('n', '<leader>gc', fzf_lua.git_commits, opts_desc("Git Commits"))
vim.keymap.set('n', '<leader>gC', fzf_lua.git_bcommits, opts_desc("Git Buffer Commits"))
vim.keymap.set('n', '<leader>gh', fzf_lua.git_hunks, opts_desc("Git Hunks"))

vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'gO')
vim.keymap.del('n', 'grt')
