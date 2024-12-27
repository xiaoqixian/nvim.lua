-- Date:   Mon Oct 14 10:53:14 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}
local utils = require("utils")
local opts = utils.keymap_opts

-- a table of conditional breakpoints
local cond_bps = {}

function M.config()
  local dap = require("dap")
  local dap_keymaps = {
    tb = "toggle_breakpoint",
    tcb = {
      cb = function()
        local input_args = {
          prompt = "Breakpoint condition: "
        }
        local key = ("%s:%d"):format(vim.fn.expand("%:p"), vim.fn.line("."))
        local bp_before = cond_bps[key]
        if bp_before ~= nil then
          input_args.default = bp_before
        end
        vim.ui.input(input_args, function(cond)
          cond_bps[key] = cond
          dap.set_breakpoint(cond)
        end)
      end,
      desc = "set conditional breakpoint"
    },
    ["<leader>ct"] = "continue",
    [")"] = "step_into",
    ["("] = "step_out",
    ["`"] = "step_over",
    ["<leader>dc"] = "run_to_cursor",
    -- ["<leader>ds"] = {
    --   cb = function()
    --     widgets.centered_float(widgets.scopes)
    --   end,
    --   desc = "centered float scopes"
    -- },
    -- ["<leader>df"] = {
    --   cb = function()
    --     widgets.centered_float(widgets.frames)
    --   end,
    --   desc = "centered float frames"
    -- }
  }

  for key, rhs in pairs(dap_keymaps) do
    if type(rhs) == "string" then
      if dap[rhs] then
        vim.keymap.set("n", key, dap[rhs], opts("nvim-dap: " .. rhs))
      else
        vim.cmd(("echoerr 'dap.%s not exist'"):format(rhs))
      end
    elseif type(rhs) == "table" then
      vim.keymap.set("n", key, rhs.cb, opts("nvim-dap: " .. rhs.desc))
    end
  end
end

function M.ui_config()
  local dapui = require("dapui")
  dapui.setup({
    layouts = {
      {
        elements = {
          { id = "repl", size = 0.2 },
          { id = "watches", size = 0.2 },
          { id = "breakpoints", size = 0.2 },
          { id = "stacks", size = 0.4 }
        },
        size = 40,
        position = "left"
      },
      {
        elements = {
          "console", "scopes"
        },
        size = 10,
        position = "bottom"
      }
    },
    controls = {
      element = "console"
    }
  })

  vim.keymap.set("n", "Q", dapui.toggle, opts("dap-ui: toggle"))
  vim.keymap.set("n", "W", function()
    local ft = vim.bo.filetype
    local elem = ft:match("dapui_(%w+)")
    if elem == nil and ft == "dap-repl" then
      elem = "repl"
    end
    if elem ~= nil then
      dapui.float_element(elem, {
        width = 120,
        height = 40,
        enter = true,
        position = "center"
      })
    end
  end, opts("dap-ui: float element"))
end

function M.python_config()
  local py_path = ("%s/.local/share/venv/bin/python"):format(os.getenv("HOME"))
  -- require("dap-python").setup(py_path, {
  --   console = "integratedTerminal",
  -- })
  local dap = require("dap")

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
        command = py_path,
        args = { '-m', 'debugpy.adapter' },
        options = {
          source_filetype = 'python',
        },
      })
    end
  end
  dap.configurations.python = {
    {
      type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = 'launch',
      name = "Launch file",
      justMyCode = false,
      console = "integratedTerminal",
      program = "${file}", -- This configuration will launch the current file if used.
      pythonPath = function()
        local venv = os.getenv("VIRTUAL_ENV")
        if venv ~= "" then
          return venv .. "/bin/python"
        else
          return "/usr/bin/python3"
        end
      end,
    },
    {
      type = "python",
      request = "attach",
      name = "Attach to remote IDA debugger",
      justMyCode = false,
      port = 5678,
    }
  }
end

return M
