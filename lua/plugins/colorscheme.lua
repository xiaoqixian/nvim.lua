-- Date:   Sun Feb 25 17:35:09 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

function M.init(colorscheme) 
  local profile = os.getenv("ITERM_RPOFILE")
  if profile == colorscheme then
    vim.cmd("colorscheme " .. colorscheme)
  end
end

return M
