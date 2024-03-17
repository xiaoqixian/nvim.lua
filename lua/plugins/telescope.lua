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

  map("n", "<leader>tb", builtin.buffers, opts("telescope buffers"))
  map("n", "<leader>ss", builtin.lsp_document_symbols, opts("telescope lsp_document_symbols"))
  map("n", "<leader>td", builtin.diagnostics, opts("telescope diagnostics"))

  map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts("telescope goto definitions"))

  map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts("telescope find files"))

  map("n", "<leader>lg", "<cmd>Telescope live_grep", opts("telescope live grep"))
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
      },

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
          preview_cutoff = 0.6,
          prompt_position = "bottom",
          width = 0.8
        }
      }
    },
  })
  set_keymaps()
end

return M
