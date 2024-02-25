-- Date: Fri Jan 19 12:13:16 2024
-- Mail: lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

function M.init()
  local be = require("buffer_explorer")
  local utils = require("buffer_explorer.utils")

  local menu = {
    config = {
      menu_keymaps = {
        ["<CR>"] = {
          op = utils.edit_buffer,
          desc = "edit buffer on the cursorline"
        },
        ["q"] = {
          op = function() 
            be:close()
          end,
          desc = "close buffer explorer"
        },
        ["<ESC>"] = {
          op = function() 
            be:close()
          end,
          desc = "close buffer explorer"
        },
        ["t"] = {
          op = utils.tabnew_buffer,
          desc = "open buffer in a new tab"
        },
        ["d"] = {
          op = utils.delete_buffer,
          desc = "delete a buffer"
        },
        ["D"] = {
          op = utils.force_delete_buffer,
          desc = "force delete a buffer"
        },
        ["e"] = {
          op = utils.toggle_buf_name,
          desc = "toggle buffer name"
        },
        ["i"] = {
          op = utils.sp_buffer,
          desc = "open buffer in a horizontal window"
        },
        ["s"] = {
          op = utils.vs_buffer,
          desc = "open buffer in a vertical window"
        }
      },

      -- set menu buffer local highlights
      highlights = {
        -- the key is also the name of 
        -- the highlighting group.
        ModifiedBuffer = {
          ctermfg = 3,
          bold = true
        },
      },
    }
  }

  be:setup({
    menu = menu
  })
  
  vim.keymap.set("n", "<leader>x", 
    function()
      be:toggle()
    end, 
    {
      noremap = true,
      nowait = true,
      desc = "toggle buffer explorer",
      silent = true
    })
end

return M
