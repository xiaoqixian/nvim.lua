-- Date:   Tue Aug 27 22:49:06 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

function M.init()
  require("catppuccin").setup({
    custom_highlights = function(colors)
      return {
        TabLineFill = { bg = "none" },
        TabLineSel = {
          fg = colors.flamingo,
          bg = "none",
          bold = true
        }
        -- Comment = { fg = colors.flamingo },
        -- TabLineSel = { bg = colors.pink },
        -- CmpBorder = { fg = colors.surface2 },
        -- Pmenu = { bg = colors.none },
      }
    end
  })

  vim.cmd("colorscheme catppuccin-mocha")
end

return M

