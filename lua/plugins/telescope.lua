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
  map("n", "<leader>td", builtin.diagnostics, opts("telescope diagnostics"))

  map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts("telescope goto definitions"))
  map("n", "gr", "<cmd>Telescope lsp_references<CR>", opts("telescope goto references"))

  map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts("telescope find files"))

  map("n", "F", "<cmd>Telescope live_grep<CR>", opts("telescope live grep"))

  map("n", "f", builtin.resume, opts("resume telescope window"))

  map("n", "S", function()
    builtin.lsp_document_symbols({ignore_symbols = {"field"}})
  end, opts("telescope show document symbols"))

  map("n", "sf", function()
   builtin.lsp_document_symbols({symbols={"method", "function", "constructor"}})
  end, opts("telescope show document functions and methods"))

  map("n", "ss", function()
   builtin.lsp_document_symbols({symbols={"struct", "class", "enum"}})
  end, opts("telescope show document struct, class and enum..."))
end

function M.init()
  local actions = require("telescope.actions")

  local screen_width = vim.opt.columns:get()

  require("telescope").setup({
    defaults = {
      initial_mode = "normal",

      mappings = {
        n = {
          ["q"] = actions.close
        }
      },

      layout_strategy = screen_width < 120 and "vertical" or "horizontal",
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
      }
    },
  })
  set_keymaps()
end

return M
