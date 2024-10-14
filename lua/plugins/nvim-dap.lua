-- Date:   Mon Oct 14 10:53:14 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}
local opts = require("utils").keymap_opts

function M.config()
  local dap = require("dap")
  vim.keymap.set("n", "tb", dap.toggle_breakpoint, opts("nvim-dap: toggle_breakpoint"))

dap.configurations.python = {
  {
      -- The first three options are required by nvim-dap
      type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = 'launch';
      name = "Launch file";

      program = "${file}"; -- This configuration will launch the current file if used.
      pythonPath = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
          return cwd .. '/venv/bin/python'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
          return cwd .. '/.venv/bin/python'
        else
          return '/usr/bin/python3'
        end
      end;
    },
  }

end

return M
