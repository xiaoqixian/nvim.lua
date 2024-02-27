-- This file can be loaded by calling `lua require("plugins")` from your init.vim

require("lazy").setup({
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    init = require("plugins/nvim-tree").init,
    -- enabled = false
  },

  {
    "numToStr/Comment.nvim",
    lazy = false,
    init = require("plugins/comment").init,
    -- enabled = false
  },

  {
    "numToStr/FTerm.nvim",
    lazy = true,
    init = require("plugins/fterm").init,
    -- enabled = false
  },

  {
    "neovim/nvim-lspconfig",
    init = require("plugins/lsp_config").init
  }

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip"
      --"hrsh7th/cmp-vsnip",
      --"hrsh7th/vim-vsnip",
    },
    lazy = false,
    init = require("plugins/nvim_cmp").init,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    init = require("plugins/lualine").init
  },
  
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    lazy = false,
    init = require("plugins/autopairs").init
  },

  {
    "xiaoqixian/buffer-explorer.nvim",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons"
    },
    lazy = false,
    init = require("plugins/buffer_explorer").init
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    lazy = false,
    init = require("plugins/telescope").init
  },

  {
    "kaarmu/typst.vim",
    ft = "typst"
  },

  {
    "rust-lang/rust.vim",
    ft = "rust"
  },

  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- configuration goes here
    },
    init = require("plugins/leetcode").init,
    cmd = "Leet",
    enabled = false
  },

  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    init = require("plugins/gruvbox").init
  },

  {
    "folke/neodev.nvim",
    init = require("plugins/neodev").init
  }
}, {
  install = {
    missing = true,
    colorscheme = {}
  },
  ui = {
    border = "rounded"
  }
})

