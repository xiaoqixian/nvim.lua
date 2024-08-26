-- Date:   Mon Aug 26 20:29:40 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

function M.init()
  require("render-markdown").setup({
    heading = {
      enabled = false
    },
    code = {
      style = "language"
    }
  })
end

return M
