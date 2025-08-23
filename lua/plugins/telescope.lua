-- Date: Mon Jan 29 20:42:34 2024
-- Mail: lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

local default_file_ignore_patterns = {
  "node_modules",
  ".git",
  "%.cache",
  "build"
}

M.dynamic_file_ignore_patterns = {}

local function get_root()
  local path = vim.fn.expand("%:p")
  -- if match a python lib path, set the lib path as root
  if path:match("(.*/site%-packages/[^/]+)") then
    return path:match("(.*/site%-packages/[^/]+)")
  else
    return vim.g.tlsc_ff_root
  end
end

local function set_keymaps()
  local function opts(desc)
    return {
      desc = desc,
      noremap = true,
      nowait = true,
      silent = true
    }
  end

  local map = vim.keymap.set
  local builtin = require("telescope.builtin")

  map("n", "<leader>tb", builtin.buffers, opts("telescope buffers"))
  map("n", "<leader>td", builtin.diagnostics, opts("telescope diagnostics"))

  map("n", "gd", builtin.lsp_definitions, opts("telescope goto definitions"))
  map("n", "gt", function()
    vim.cmd("vs")
    builtin.lsp_definitions()
  end, opts("telescope goto definitions in new vsplit window"))
  map("n", "gs", function()
    vim.cmd("sp")
    builtin.lsp_definitions()
  end, opts("telescope goto definitions in new hsplit window"))
  map("n", "gr", builtin.lsp_references, opts("telescope goto references"))

  map("n", "<leader>ff", function()
    builtin.find_files({
      path_display = { "truncate" },
      cwd = get_root(),
      file_ignore_patterns = vim.list_extend(default_file_ignore_patterns, M.dynamic_file_ignore_patterns)
    })
  end, opts("telescope find files"))

  map("n", "F", function()
    builtin.live_grep({
      cwd = get_root()
    })
  end, opts("telescope live grep"))

  map("n", "f", builtin.resume, opts("resume telescope window"))

  -- map("n", "S", function()
  --   builtin.lsp_document_symbols({ignore_symbols = {"field"}})
  -- end, opts("telescope show document symbols"))

  map("n", "sf", function()
   builtin.lsp_document_symbols({symbols={"method", "function", "constructor"}})
  end, opts("telescope show document functions and methods"))

  map("n", "ss", function()
   builtin.lsp_document_symbols({symbols={"struct", "class", "enum"}})
  end, opts("telescope show document struct, class and enum..."))
end

function M.init()
  local actions = require("telescope.actions")

  require("telescope").setup({
    defaults = {
      mappings = {
        n = {
          q = actions.close,
          s = actions.select_vertical,
          I = actions.select_horizontal,
          t = actions.select_tab
        }
      },

      -- layout_strategy = vim.opt.columns:get() < 120 and "vertical" or "horizontal",
      layout_strategy = "vertical",
      layout_config = {
        vertical = {
          height = 0.9,
          preview_cutoff = 0.5,
          prompt_position = "bottom",
          width = 0.8
        },
        horizontal = {
          height = 0.9,
          preview_width = 0.6,
          prompt_position = "bottom",
          width = 0.8
        }
      },
      file_ignore_patterns = default_file_ignore_patterns
    },
  })
  set_keymaps()

  vim.api.nvim_create_user_command("AddFileIgnorePattern", function(opts)
    table.insert(M.dynamic_file_ignore_patterns, opts.args)
    print("Added ignore pattern: " .. opts.args)
  end, { nargs = 1 })

  vim.api.nvim_create_user_command("RemoveFileIgnorePattern", function(opts)
    for i, pattern in ipairs(M.dynamic_file_ignore_patterns) do
      if pattern == opts.args then
        table.remove(M.dynamic_file_ignore_patterns, i)
        print("Removed ignore pattern: " .. opts.args)
        return
      end
    end
    print("Pattern not found: " .. opts.args)
  end, { nargs = 1 })
end

return M
