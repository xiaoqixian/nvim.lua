-- Date:   Tue Aug 27 14:32:17 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

function M.init()
    local profile = os.getenv("ITERM_PROFILE")
    if profile ~= "latte" then
      return
    end

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

    -- 'hi PMenuSel ctermfg=255 ctermbg=103',
    -- 'hi TabLine ctermfg=0 ctermbg=none cterm=none',
    -- 'hi TabLineSel ctermfg=1',
    -- 'hi TabLineFill ctermfg=none ctermbg=none cterm=none',
    -- 'hi Search ctermfg=255 ctermbg=104',
    -- 'hi CursorLine ctermfg=255 ctermbg=240',
    -- 'hi CursorLineNr ctermfg=none ctermbg=188',
    -- 'hi Comment ctermfg=249 ctermbg=none',
    -- 'hi MatchParen ctermfg=255 ctermbg=103',
    -- 'hi Visual ctermfg=none ctermbg=253',
    -- 'hi Folded ctermfg=255 ctermbg=243',
    -- 'hi NormalFloat ctermbg=none'

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

      -- before_highlight = function(group, highlight, palette)
          -- Disable all undercurls
          -- if highlight.undercurl then
          --     highlight.undercurl = false
          -- end
          --
          -- Change palette colour
          -- if highlight.fg == palette.pine then
          --     highlight.fg = palette.foam
          -- end
      -- end,
  })

  vim.cmd("colorscheme rose-pine")
  -- vim.cmd("colorscheme rose-pine-main")
  -- vim.cmd("colorscheme rose-pine-moon")
  -- vim.cmd("colorscheme rose-pine-dawn")
end

return M
