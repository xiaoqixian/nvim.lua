-- Date:   Sat Feb 10 17:04:11 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

local config = {
  cn = {
    enabled = true,
    translator = false,
    translate_problems = false
  }
}

function M.init()
  require("leetcode").setup(config)
end

return M
