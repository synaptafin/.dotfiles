local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- useful module packer
  { 'echasnovski/mini.nvim',               branch = 'stable' },

  -- ai completion
  "github/copilot.vim",

  -- extension api
  "nvim-lua/popup.nvim",  -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins

  -- appearance
  { "lukas-reineke/indent-blankline.nvim", main = "ibl",     opts = {} },

  -- theme

  -- which key
  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 200
    end,
  },

  -- cmp
  {
    "hrsh7th/nvim-cmp",
    event = "VimEnter",
  },
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  {
    "L3MON4D3/LuaSnip",
    event = "VimEnter",
    build = "make install_jsregexp",
  },
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use
  { "folke/neodev.nvim",                opts = {} },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
  },
  "nvim-telescope/telescope-media-files.nvim",
  "benfowler/telescope-luasnip.nvim",
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end
  },

  -- lsp
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason.nvim", -- simple to use language server installer
    event = { "BufReadPre", "VimEnter" },
    build = ":MasonUpdate",
  },
  "williamboman/mason-lspconfig.nvim", -- simple to use language server installer
  "jose-elias-alvarez/null-ls.nvim",  -- LSP diagnostics and code actions
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
  },
  { 'Issafalcon/lsp-overloads.nvim' },
  { 'Hoffs/omnisharp-extended-lsp.nvim' },


  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
  "p00f/nvim-ts-rainbow",
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/nvim-treesitter-textobjects",

  -- git
  "lewis6991/gitsigns.nvim",

  -- file explorer
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  -- {
  --   "stevearc/oil.nvim",
  --   opts = {},
  -- },


  -- bufferline
  { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

  -- toggleterminal
  -- {"akinsho/toggleterm.nvim", event="VeryLazy"},

  -- file info
  "nvim-lualine/lualine.nvim",
  "simrat39/symbols-outline.nvim",

  -- edit
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("hop").setup({})
    end,
  },
  { 'numToStr/Comment.nvim',   lazy = false },
  'windwp/nvim-autopairs',
  "windwp/nvim-ts-autotag",

  -- Debugger
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
      },
      { "theHamsta/nvim-dap-virtual-text" },
      {
        "nvim-telescope/telescope-dap.nvim",
      },
      { "jbyuki/one-small-step-for-vimkind" },
    },
  },

  -- my functions
  {
    "enigmaiiiiiiii/mini-functions.nvim",
    branch = "dev",
    event = "VeryLazy"
  },
})
