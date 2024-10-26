-- Date:   Sun Oct 06 15:12:44 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local utils = require("utils")

local function rose_pine_init()
    require("rose-pine").setup({
      variant = "dawn", -- auto, main, moon, or dawn
      dark_variant = "dawn", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      enable = {
          terminal = true,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
      },

      styles = {
          bold = true,
          italic = false,
          transparency = false,
      },

      groups = {
          border = "muted",
          link = "iris",
          panel = "surface",

          error = "love",
          hint = "iris",
          info = "foam",
          note = "pine",
          todo = "rose",
          warn = "gold",

          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_text = "rose",
          git_untracked = "subtle",

          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
      },

      palette = {
          -- Override the builtin palette per variant
          -- moon = {
          --     base = '#18191a',
          --     overlay = '#363738',
          -- },
          dawn = {
            base = "#f7f8f2", -- cream white
            love = "#c94952", -- red
            pine = "#3364ec", -- blue
            foam = "#759f50", -- green
          }
      },

      highlight_groups = {
          -- Comment = { fg = "foam" },
          -- VertSplit = { fg = "muted", bg = "muted" },
          String = { fg = "love" },
          Keyword = { fg = "rose" },

          ["@function"] = { fg = "pine" },
          ["@function.method"] = { fg = "pine" },
          ["@function.method.call"] = { fg = "pine" },
          ["@function.macro"] = { fg = "pine" },

          ["@type"] = { fg = "gold" },
          ["@type.builtin"] = { fg = "gold", bold = false },
          ["@module"] = { fg = "#db7cc6" }, -- magenta
          ["@variable.builtin"] = { bold = false },
          TabLineSel = {
            fg = "rose",
            bg = "none",
            bold = true
          },
          Folded = { bg = "#e4e4e4" },
          Comment = { fg = "#b2b2b2" }
      },
  })

  vim.cmd("colorscheme rose-pine")
end

local M = {
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        overrides = {
          TabLine = { bg = "none" },
          TabLineFill = { bg = "none" },
          TabLineSel = {
            fg = "#f0bf4f",
            bg = "none",
            bold = true
          }
        }
      })

      vim.cmd("colorscheme gruvbox")
    end
  },

  {
    "catppuccin/nvim",
    name = "catppuccin-mocha",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        custom_highlights = function(colors)
          return {
            TabLine = { bg = "none" },
            TabLineFill = { bg = "none" },
            TabLineSel = {
              fg = colors.flamingo,
              bg = "none",
              bold = true
            }
          }
        end
      })
      vim.cmd("colorscheme catppuccin-mocha")
      vim.cmd("hi PMenuSel guifg=#1e1d2c guibg=#fc98a0")
    end
  },

  {
    "Shatur/neovim-ayu",
    name = "ayu-mirage",
    config = function()
      local success, lualine = pcall(require, "lualine")
      if success then
        lualine.setup({
          options = {
            theme = "ayu"
          }
        })
      end

      vim.cmd("colorscheme ayu-mirage")
    end
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = rose_pine_init
  }
}

for _, theme in ipairs(M) do
  theme.cond = utils.enable_colorscheme(theme.name)
end

return M
