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
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        auto_install = true,
        ensure_installed = {
          "rust", "markdown", "markdown_inline", "vimdoc",
          "go", "cpp", "c", "lua", "python", "java",
          "javascript", "typescript", "typst", "zig"
        },
        highlight = {
         enable = true,
         disable = { "vue", "json", "css", "html" }
        },
      })
    end
  },

  {
    "numToStr/Comment.nvim",
    lazy = false,
    init = require("plugins/comment").init,
    -- enabled = false
  },

  {
    "xiaoqixian/fterm.nvim",
    lazy = true,
    init = require("plugins/fterm").init,
    -- enabled = false
  },

  {
    "neovim/nvim-lspconfig",
    init = require("plugins/lsp_config").init,
    -- enabled = false
  },

  {
    "hrsh7th/vim-vsnip",
    "hrsh7th/vim-vsnip-integ"
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
      -- "L3MON4D3/LuaSnip",
      -- "saadparwaiz1/cmp_luasnip"
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    },
    lazy = false,
    init = require("plugins/nvim_cmp").init,
    -- enabled = false
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    init = require("plugins/lualine").init,
    -- enabled = false
  },
  
  {
    -- This is my own fork of nvim-autopairs.
    "xiaoqixian/nvim-autopairs",
    event = "InsertEnter",
    lazy = false,
    init = require("plugins/autopairs").init,
    -- enabled = false
  },

  {
    "xiaoqixian/buffer-explorer.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons"
    },
    lazy = false,
    init = require("plugins/buffer_explorer").init,
    -- enabled = false
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    lazy = false,
    init = require("plugins/telescope").init,
    -- enabled = false
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
    enabled = function()
      return os.getenv("ITERM_PROFILE") == "gruvbox"
    end,
    init = function()
      vim.cmd("colorscheme gruvbox")
    end
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    enabled = function()
      local profile = os.getenv("ITERM_PROFILE")
      if profile == nil then
        return false
      end
      local i = profile:find("catppuccin")
      return i ~= nil
    end,
    lazy = false,
    init = function()
      vim.cmd(("colorscheme %s"):format(os.getenv("ITERM_PROFILE")))
    end
  },

  {
    "folke/neodev.nvim",
    init = require("plugins/neodev").init,
    -- enabled = false
  },

  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    config = true,
    init = function()
      require("plugins/colorscheme").init("dracula")
    end
  },

  {
    'brenoprata10/nvim-highlight-colors',
    init = function()
      require('nvim-highlight-colors').setup({})
    end,
    enabled = false
  },

  {
    "simrat39/symbols-outline.nvim",
    init = require("plugins/symbols_outline").init,
    lazy = true
  },

  {
    "krivahtoo/silicon.nvim",
    build = "./install.sh",
    init = require("plugins/silicon").init,
    enabled = false
  },

  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  {
    "charlespascoe/vim-go-syntax"
  },

  {
    'mrcjkb/haskell-tools.nvim',
    version = '^3', -- Recommended
    lazy = false, -- This plugin is already lazy
  },

  {
    'numirias/semshi',
    ft = { "python" },
    config = function()
      vim.cmd("UpdateRemotePlugins")
    end,
    enabled = false
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = "markdown",
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    init = require("plugins/render-markdown").init
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

