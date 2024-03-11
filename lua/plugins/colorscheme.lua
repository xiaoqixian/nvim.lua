-- Date:   Sun Feb 25 17:35:09 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}
local profile = os.getenv("ITERM_RPOFILE")

function M.init(colorscheme) 
  if profile == colorscheme then
    vim.cmd("colorscheme " .. colorscheme)
  end
end

function M.enable(colorscheme)
  return profile == colorscheme
end

return M
