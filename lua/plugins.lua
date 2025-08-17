-- This file can be loaded by calling `lua require("plugins")` from your init.vim

local utils = require("utils")
local opts = utils.keymap_opts

local lazy_colorscheme = utils.colorscheme_by_profile()

local plugins = {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    keys = {
      -- { "E", "<cmd>NvimTree<CR>", desc = "nvim-tree toggle" }
      { "E", utils.toggle_sidebar("NvimTree", "NvimTreeOpen", nil), desc = "nvim-tree toggle" }
    },
    config = require("plugins/nvim-tree").init,
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
    -- "hrsh7th/nvim-cmp",
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp",
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
    "xiaoqixian/rust.vim",
    ft = "rust",
    pin = true
  },

  {
    "xiaoqixian/leetcode.nvim",
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
      cn = {
        enabled = true,
        translator = false,
        translate_problems = false
      },
      storage = {
        home = os.getenv("HOME") .. "/won/leetcode",
        cache = vim.fn.stdpath("cache") .. "/leetcode",
      },
      injector = {
        cpp = {
          before = utils.leetcode_cpp_injector_before
        }
      }
    },
    cmd = "Leet",
  },

  {
    "folke/neodev.nvim",
    config = require("plugins/neodev").config,
  },

  {
    'brenoprata10/nvim-highlight-colors',
    init = function()
      require('nvim-highlight-colors').setup({})
    end,
    enabled = true
  },

  {
    "xiaoqixian/outline.nvim",
    config = require("plugins/outline").init,
    keys = {
      { "S", utils.toggle_sidebar("Outline", "Outline", nil), desc = "symbols outline toggle" }
    }
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
    "hoblovski/perwindow-search.vim",
    enabled = false
  },

  {
    "mfussenegger/nvim-dap",
    config = require("plugins/nvim-dap").config
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = require("plugins/nvim-dap").ui_config
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui"
    },
    config = require("plugins/nvim-dap").python_config
  },

  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      -- "rcarriga/nvim-dap-ui"
    },
  },

  {
    "xiaoqixian/winlocal-search.nvim",
    config = function()
      require("wl-search").setup()
    end,
    enabled = false
  },

  {
    "ojroques/nvim-osc52",
    -- enabled = function()
    --   return vim.g.distro ~= "Ubuntu"
    -- end,
    config = function()
      vim.keymap.set('n', '<leader>y', require('osc52').copy_operator,
        opts("osc52: norm copy to clipboard", {expr = true}))
      vim.keymap.set('v', '<leader>y', require('osc52').copy_visual,
        opts("osc52: visiual copy to clipboard"))
    end
  },

  {
    "echasnovski/mini.align",
    version = false,
    config = function ()
      require("mini.align").setup()
    end
  },

  {
    "Shatur/neovim-session-manager",
    config = function()
      local config = require("session_manager.config")
      require("session_manager").setup({
        autoload_mode = {
          config.AutoloadMode.GitSession,
          config.AutoloadMode.CurrentDir,
          config.AutoloadMode.Disabled
        }
      })
      vim.api.nvim_create_autocmd({ "VimLeave" }, {
        callback = function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            -- Don't save while there's any 'nofile' buffer open.
            if vim.api.nvim_get_option_value("buftype", { buf = buf }) == 'nofile' then
              return
            end
          end
          require("session_manager").save_current_session()
        end
      })
    end
  },

  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local config = {
        cmd = {"/usr/bin/jdtls"},
        root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
      }
      require('jdtls').start_or_attach(config)
    end
  },

  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
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
