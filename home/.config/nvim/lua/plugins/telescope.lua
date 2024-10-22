local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.load_extension("media_files")
local lst = telescope.load_extension("luasnip")
local luasnip = require("luasnip")

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "truncate" },

    file_ignore_patterns = {
      ".git/",
      "cache/",
      "%.cache",
      ".venv/",
      "node_modules/",
      "%.o",
      "%.a",
      "%.out",
      "%.class",
      "%.pdf",
      "%.mkv",
      "%.mp4",
      "%.zip",
      ".next/",
      "__pycache__/",

      -- unity
      "Temp/",
      "Library/",
      "%.meta",
      "%.unity",
      "%.prefab",
      "%.asset",
      "%.fbx",
      "%.controller",
    },
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true,
      path_display = { "truncate", truncate = 1 },
    },
    live_grep = {
      additional_args = { "--hidden" },
      path_display = { "absolute" },
    },
    lsp_definitions = {
      path_display = function(_, path)
        local workspace = vim.fn.getcwd()
        return string.gsub(path, workspace, ".")
      end,
      show_line = false,
    },
    lsp_references = {
      -- path_display = function(_, path)
      --   local workspace = vim.fn.getcwd()
      --   return string.gsub(path, workspace, ".")
      -- end,
      path_display = { "truncate", truncate = 1 },
      show_line = false,
    },
    buffers = {
      sort_mru = true,
    },
    jumplist = {
      path_display = { "truncate", truncate = 1 },
      fname_width = 100,
    }
  },

  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
    luasnip = {
      search = function(entry)
        return lst.filter_null(entry.context.trigger)
            .. " "
            .. lst.filter_null(entry.context.name)
            .. " "
            .. entry.ft
            .. " "
            .. lst.filter_description(entry.context.name, entry.context.description)
            .. lst.get_docstring(luasnip, entry.ft, entry.context)[1]
      end,
    },
  },
})

-- telescope doesn't integrate with color config
-- so set it manually with mini.hues module
local palette = require('plugins.mini').palette

-- vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = palette.bg_mid })
-- vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = palette.bg_mid, fg = palette.fg_mid2 })

local TelescoperColor = {
  TelescopeBorder        = { fg = nil, bg = palette.bg_mid },
  TelescopeMatching      = { fg = palette.bg_edge2, bg = palette.green },
  -- TelescopeSelection     = { fg = palette.fg,   bg = palette.bg_mid2 },
  TelescopeNormal        = { fg = palette.fg_mid2, bg = palette.bg_mid },
  TelescopePromptTitle   = { fg = palette.bg_edge2, bg = palette.red },
  TelescopePromptNormal  = { fg = palette.fg, bg = palette.bg_edge },
  TelescopePromptBorder  = { fg = palette.bg_edge, bg = palette.bg_edge },
  -- TelescopePromptPrefix  = { fg = palette.blue  },
  TelescopeResultsNormal = { fg = palette.fg, bg = palette.bg_edge },
  TelescopeResultsTitle  = { fg = palette.bg_edge, bg = palette.bg_edge },
  TelescopeResultsBorder = { fg = palette.bg_edge, bg = palette.bg_edge },
  TelescopePreviewNormal = { fg = palette.fg_mid2, bg = palette.bg_edge },
  TelescopePreviewBorder = { fg = palette.bg_edge, bg = palette.bg_edge },
  TelescopePreviewTitle  = { fg = palette.bg_edge2, bg = palette.cyan },
  TelescopePreviewLine   = { fg = palette.bg_edge2, bg = palette.green },
}

for hl, col in pairs(TelescoperColor) do
  vim.api.nvim_set_hl(0, hl, col)
end
