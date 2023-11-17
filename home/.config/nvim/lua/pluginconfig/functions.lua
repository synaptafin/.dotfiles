local mini_functions = require("mini-functions")

vim.keymap.set('n', 'cp', mini_functions.replace_with_clipboard, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>mt', mini_functions.insert_markdown_TOC, { noremap = true, silent = true })
-- vim.keymap.set('n', '<S-l>', mini_functions.no_circle_buffer_nav_next, { noremap = true, silent = true })
-- vim.keymap.set('n', '<S-h>', mini_functions.no_circle_buffer_nav_prev, { noremap = true, silent = true })

print(vim.fn.getcwd())

