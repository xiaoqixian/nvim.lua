-- Date:   Mon Oct 14 10:53:14 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}
local opts = require("utils").keymap_opts

function M.config()
  local dap = require("dap")
  vim.keymap.set("n", "tb", dap.toggle_breakpoint, opts("nvim-dap: toggle_breakpoint"))
  vim.keymap.set("n", "ct", dap.continue, opts("nvim-dap: continue"))

  dap.adapters.python = function(cb, config)
    if config.request == 'attach' then
      ---@diagnostic disable-next-line: undefined-field
      local port = (config.connect or config).port
      ---@diagnostic disable-next-line: undefined-field
      local host = (config.connect or config).host or '127.0.0.1'
      cb({
        type = 'server',
        port = assert(port, '`connect.port` is required for a python `attach` configuration'),
        host = host,
        options = {
          source_filetype = 'python',
        },
      })
    else
      cb({
        type = 'executable',
        command = 'python3',
        args = { '-m', 'debugpy.adapter' },
        options = {
          source_filetype = 'python',
        },
      })
    end
  end

end

return M
