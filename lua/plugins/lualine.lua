-- config for lualine plugin
local M = {}
local utils = require("utils")

local function get_theme() 
  local theme_by_profile = {
    solid = "material",
    gruvbox = "gruvbox_dark",
    ["catppuccin-mocha"] = "catppuccin",
    latte = "ayu_light"
  }
  local customizations = {
    solid = {
      insert = {
        a = { bg = "#fed58f" }
      }
    },
    gruvbox = {
      insert = {
        a = { bg = "#f9bc2f" }
      },
      normal = {
        a = { bg = "#8ebf7b" }
      },
      command = {
        a = { bg = "#d2859a" }
      }
    },
    latte = {
      normal = {
        a = { bg = "#87afff" }
      }
    }
  }

  local profile = os.getenv("ITERM_PROFILE")
  local theme = profile and theme_by_profile[profile] or "material"
  local lualine_theme = require("lualine.themes." .. theme)
  utils.deep_merge(lualine_theme, customizations[profile])

  return lualine_theme
end

function M.init()
  local customed_material = require("lualine.themes.material")
  customed_material.insert.a.bg = "#fed58f"

  local theme = get_theme()

  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = theme,
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }
end

return M
