-- Date:   Tue Aug 27 22:47:23 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

function M.init()
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

return M
