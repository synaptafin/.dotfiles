local lspconfig = require("lspconfig")
local servers = require("plugins.lsp.servers")

local hover_opts = {
  border = "rounded",
}

local function keymap_opts(desc)
  if desc then
    return { noremap = true, silent = true, desc = desc }
  end
  return { noremap = true, silent = true }
end

local function goto_opts(count)
  return {
    count = count,
    float = true,
    border = "rounded",
    severity = {
      min = vim.diagnostic.severity.WARN,
    }
  }
end

vim.g.diagnostic_virtual_text_enabled = true
function _G.toggle_diagnostic_virtual_text()
  vim.g.diagnostic_virtual_text_enabled = not vim.g.diagnostic_virtual_text_enabled
  vim.diagnostic.config({
    virtual_text = vim.g.diagnostic_virtual_text_enabled,
  })
end

local operation_in_split = require("plugins.lsp.utilities").operation_in_split
local function default_keymaps()
  vim.keymap.set('n', 'gd', function() require('fzf-lua').lsp_definitions() end,
    keymap_opts("Go To Definition"))
  -- vim.keymap.set('n', 'gr', function() require('telescope.builtin').lsp_references({ include_declaration = false }) end, keymap_opts("Go To Reference"))
  vim.keymap.set('n', 'gr', require('plugins.fzf-lua').fzf_lua_references_with_opts, keymap_opts("Go To Reference"))

  vim.keymap.set('n', 'gh', function() vim.lsp.buf.hover(hover_opts) end, keymap_opts("Hover"))
  vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, keymap_opts("Declaration"))
  -- vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, keymap_opts("Implementation"))
  vim.keymap.set('n', 'gi', require('plugins.fzf-lua').fzf_lua_implementations_with_opts,
    keymap_opts("Go To Implementation"))

  vim.keymap.set('n', 'gvd',
    function() operation_in_split(vim.lsp.buf.definition) end,
    keymap_opts("Goto definition in split")
  )
  vim.keymap.set('n', 'gvr',
    function() operation_in_split(require('plugins.fzf-lua').fzf_lua_references_with_opts) end,
    keymap_opts("Goto reference in split")
  )
  vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float() end, keymap_opts())
  vim.keymap.set('n', 'gs', function() require('fzf-lua').lsp_live_workspace_symbols() end,
    keymap_opts("Workspace Symbols"))
  vim.keymap.set('n', '<leader>lj', function() vim.diagnostic.jump(goto_opts(1)) end, keymap_opts("Next Diagnostic"))
  vim.keymap.set('n', '<leader>lk', function() vim.diagnostic.jump(goto_opts(-1)) end, keymap_opts("Prev Disgnostic"))
  vim.keymap.set('n', '<leader>ld', function() require('fzf-lua').lsp_document_diagnostics() end,
    keymap_opts("Document Diagnostics"))
  vim.keymap.set('n', '<leader>la', function() require('fzf-lua').lsp_code_actions() end, keymap_opts("Code Actions"))
  vim.keymap.set('n', '<leader>lD', function() toggle_diagnostic_virtual_text() end,
    { noremap = true, silent = true, desc = "Toggle disgnostic virtual text" })
  vim.keymap.set('n', '<leader>q', function() vim.diagnostic.setloclist() end, keymap_opts())
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlight then
    local group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = group,
      buffer = 0,
      callback = function()
        vim.lsp.buf.document_hightlight()
      end
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = group,
      buffer = 0,
      callback = function()
        vim.lsp.buf.clear_references()
      end
    })
  end
end

local lsp_overloads_opts = {
  ui = {
    border = "single", -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
    height = nil,      -- Height of the signature popup window (nil allows dynamic sizing based on content of the help)
    width = nil,       -- Width of the signature popup window (nil allows dynamic sizing based on content of the help)
    wrap = true,       -- Wrap long lines
    wrap_at = nil,     -- Character to wrap at for computing height when wrap enabled
    max_width = nil,   -- Maximum signature popup width
    max_height = nil,  -- Maximum signature popup height
    -- Events that will close the signature popup window: use {"CursorMoved", "CursorMovedI", "InsertCharPre"} to hide the window when typing
    close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
    focusable = true,                       -- Make the popup float focusable
    focus = false,                          -- If focusable is also true, and this is set to true, navigating through overloads will focus into the popup window (probably not what you want)
    offset_x = 0,                           -- Horizontal offset of the floating window relative to the cursor position
    offset_y = 0,                           -- Vertical offset of the floating window relative to the cursor position
    floating_window_above_cur_line = false, -- Attempt to float the popup above the cursor position
    -- (note, if the height of the float would be greater than the space left above the cursor, it will default
    -- to placing the float below the cursor. The max_height option allows for finer tuning of this)
    silent = true, -- Prevents noisy notifications (make false to help debug why signature isn't working)
    -- Highlight options is null by default, but this just shows an example of how it can be used to modify the LspSignatureActiveParameter highlight property
    highlight = {
      italic = true,
      bold = true,
      fg = "#ffffff",
      ... -- Other options accepted by the `val` parameter of vim.api.nvim_set_hl()
    }
  },
  keymaps = {
    next_signature = "<C-n>",
    previous_signature = "<C-p>",
    next_parameter = "<C-l>",
    previous_parameter = "<C-h>",
    close_signature = "<A-s>"
  },
  display_automatically = true -- Uses trigger characters to automatically display the signature overloads when typing a method signature

}

local function base_on_attach(client)
  default_keymaps()
  lsp_highlight_document(client)

  if (client.server_capabilities.signatureHelpProvider) then
    require("lsp-overloads").setup(client, lsp_overloads_opts)
  end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.workspace = {
  didChangeWatchedFiles = {
    dynamicRegistration = true,
  }
}

for _, server_name in pairs(servers) do
  server_name = vim.split(server_name, "@")[1]
  -- for adapting neovim v0.11
  -- vim.lsp.enable(server_name);
  local lsp_opts = {
    on_attach = base_on_attach,
    capabilities = capabilities,
  }

  local has_custom_setting, server_opts = pcall(require, "plugins.lsp.settings." .. server_name)

  if (has_custom_setting) then
    if server_opts.setup_condition then
      local extra_on_attach = server_opts.setup_options.on_attach
      if (extra_on_attach) then
        server_opts.setup_options.on_attach = function(client)
          base_on_attach(client)
          extra_on_attach(client)
        end
      end
      lsp_opts = vim.tbl_deep_extend("force", lsp_opts, server_opts.setup_options)
      lspconfig[server_name].setup(lsp_opts)
      -- vim.lsp.config(server_name, lsp_opts);
    end
  else
    lspconfig[server_name].setup(lsp_opts)
    -- vim.lsp.config(server_name, lsp_opts);
  end
end
