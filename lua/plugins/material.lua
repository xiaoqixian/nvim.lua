-- Date:   Tue Aug 27 14:32:17 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

function M.init()
    local profile = os.getenv("ITERM_PROFILE")
    if profile ~= "latte" then
      return
    end

    local material = require("material")

    local term = {
      bg = "#f7f8f2",
      red = "#c94952",
      -- green = "#87b46a",
      green = "#759f50",
      yellow = "#d3913a",
      blue = "#3364ec",
      magenta = "#db7cc6",
      cyan = "#507eb5",
      white = "#bcbfca",
      cursor = "#4c4b4b"
    }

    material.setup({
      custom_highlights = {
        Normal = {bg = term.bg},
        -- ["@keyword"] = {fg = term.yellow},
        -- ["@type"] = {fg = term.green},
        -- ["@type.builtin"] = {fg = term.green},
        -- String = {fg = term.red},
        -- Operator = {fg = term.yellow},
        -- Comment = {fg = "#b2b2b2"},
        -- Macro = {fg = term.yellow},
        -- Identifier = {fg = term.cyan},
        -- ["@punctuation.bracket"] = {fg = term.magenta},
        -- ["@punctuation.delimiter"] = {fg = term.magenta},
        -- CursorLing = {bg = term.cursor},
        -- FloatBorder = {bg = "none", fg = term.cursor},
        -- PMenuSel = {fg = "#ffffff", bg = "#8787af"},
        -- TabLine = {fg = "#000000", bg = "none"},
        -- TabLineSel = {fg = term.red, bg = "none", bold = true},
        -- Visual = {fg = "none", bg = "#dadada"},
        -- Search = {fg = "#ffffff", bg = "#8787af"},
        -- ["@module"] = {fg = term.yellow},
        -- Question = {fg = term.blue}
      },
      plugins = {
        "nvim-tree"
      }
    })

    vim.g.material_style = "lighter"
    vim.cmd("colorscheme material")
end

return M
