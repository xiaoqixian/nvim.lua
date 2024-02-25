-- Date:   Sun Feb 25 16:17:32 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local profile = os.getenv("ITERM_PROFILE")

local cursor_line_color = {
  gruvbox = {
    ctermfg = "0",
    ctermbg = "222"
  }
}

local color = cursor_line_color[profile] or {
  ctermfg = "111",
  ctermbg = "0"
}

local color_str = string.format("ctermbg=%s ctermfg=%s", color.ctermbg, color.ctermfg)

vim.cmd("hi CursorLine " .. color_str)
vim.cmd("hi CursorLineNr " .. color_str)
