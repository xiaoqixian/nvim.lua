-- This file can be loaded by calling `lua require("plugins")` from your init.vim

local utils = require("utils")
local opts = utils.keymap_opts

local lazy_colorscheme = utils.colorscheme_by_profile()

local plugins = {
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
         disable = { "vue", "json", "css", "html", "cmake", "typst" }
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

  -- {
  --   "hrsh7th/vim-vsnip",
  --   "hrsh7th/vim-vsnip-integ"
  -- },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
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
      "L3MON4D3/LuaSnip",
      -- "saadparwaiz1/cmp_luasnip"
      "hrsh7th/cmp-vsnip",
      -- "hrsh7th/vim-vsnip",
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
    pin = true
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
    ft = "typst",
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    pin = true
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
    "folke/neodev.nvim",
    init = require("plugins/neodev").init,
    -- enabled = false
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
  },

  {
    "marko-cerovac/material.nvim",
    init = require("plugins/material").init,
    enabled = false
  },

  {
    "hoblovski/perwindow-search.vim"
  },

  {
    "mfussenegger/nvim-dap",
    config = require("plugins/nvim-dap").config
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      vim.g.dapui_opened = false

      local function dapui_toggle()
        vim.g.dapui_opened = not vim.g.dapui_opened
        if vim.g.dapui_opened then
          vim.keymap.set("n", "+", dap.continue, opts("nvim-dap: continue"))
          vim.keymap.set("n", ">>", dap.step_into, opts("nvim-dap: step into"))
          vim.keymap.set("n", "<Enter>", dap.step_over, opts("nvim-dap: step over"))
          vim.keymap.set("n", "<<", dap.step_out, opts("nvim-dap: step out"))
        else
          vim.keymap.del("n", "+")
          vim.keymap.del("n", ">>")
          vim.keymap.del("n", "<Enter>")
          vim.keymap.del("n", "<<")
        end
        dapui.toggle()
      end

      vim.keymap.set("n", "Q", dapui_toggle, opts("dap-ui: toggle"))
      -- dap.listeners.before.attach.dapui_config = function()
      --   dapui.open()
      -- end
      -- dap.listeners.before.launch.dapui_config = function()
      --   dapui.open()
      -- end
      -- dap.listeners.before.event_terminated.dapui_config = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited.dapui_config = function()
      --   dapui.close()
      -- end
    end
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui"
    },
    config = function()
      require("dap-python").setup("python3")
    end,
  }
}

local theme_plugins = require("colorschemes")
for _, theme in ipairs(theme_plugins) do
  table.insert(plugins, theme)
end

require("lazy").setup(plugins, {
  install = {
    missing = true,
    colorscheme = { lazy_colorscheme }
  },
  ui = {
    border = "rounded"
  }
})
