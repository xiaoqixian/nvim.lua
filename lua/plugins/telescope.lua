-- Date: Mon Jan 29 20:42:34 2024
-- Mail: lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

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

  map("n", "<leader>rg", builtin.live_grep, opts("telescope live_grep"))
  map("n", "<leader>tb", builtin.buffers, opts("telescope buffers"))
  map("n", "<leader>ss", builtin.lsp_document_symbols, opts("telescope lsp_document_symbols"))
  map("n", "<leader>td", builtin.diagnostics, opts("telescope diagnostics"))
end

function M.init() 
  local actions = require("telescope.actions")

  require("telescope").setup({
    defaults = {
      initial_mode = "normal",

      mappings = {
        n = {
          ["q"] = actions.close
        }
      }
    },
  })
  set_keymaps()
end

return M
