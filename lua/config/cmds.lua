-- Date:   Tue Mar 18 09:51:46 AM 2025
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

vim.api.nvim_create_user_command(
  "CppFreeHeader",
  function()
    local header_lines = {
      "// -*- C++ -*-",
      "// Date:   " .. vim.fn.strftime("%a %b %d %X %Y"),
      "// Mail:   lunar_ubuntu@qq.com",
      "// Author: https://github.com/xiaoqixian",
      "",
      "#pragma once",
      ""
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, header_lines)
  end,
  {}
)
