-- Date: Tue Jan 16 15:35:43 2024
-- Mail: lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

function M.init() 
  local opts = {noremap = true}
  local map = vim.keymap.set
  -- Setup
  require("buffer_manager").setup({
    select_menu_item_commands = {
      v = {
        key = "v",
        command = "vsplit"
      },
      h = {
        key = "s",
        command = "split"
      },
      t = {
        key = "t",
        command = "tabnew"
      },
      d = {
        key = "d",
        command = "bdelete"
      }
    },
    focus_alternate_buffer = false,
    short_file_names = true,
    short_term_names = true,
    loop_nav = false,
    win_extra_options = {
      cursorline = true,
    }
  })
  -- Navigate buffers bypassing the menu
  local bmui = require("buffer_manager.ui")
  local keys = '1234567890'
  for i = 1, #keys do
    local key = keys:sub(i,i)
    map(
    'n',
    string.format('<leader>%s', key),
    function () bmui.nav_file(i) end,
    opts
    )
  end
  -- Just the menu
  map({ 't', 'n' }, '<leader>x', bmui.toggle_quick_menu, { desc = "toggle buffer_manager", noremap = true, nowait = true })
  -- Open menu and search
  map({ 't', 'n' }, '<M-m>', function ()
    bmui.toggle_quick_menu()
    -- wait for the menu to open
    vim.defer_fn(function ()
      vim.fn.feedkeys('/')
    end, 50)
  end, opts)
  -- Next/Prev
  -- if bmui.Buffer_manager_bufh then
  --     map('n', 'j', bmui.nav_next, { desc = "buffer next entry", noremap = true, nowait = true, buffer = bmui.Buffer_manager_bufh })
  --     map('n', 'k', bmui.nav_prev, { desc = "buffer prev entry", noremap = true, nowait = true, buffer = bmui.Buffer_manager_bufh })
  -- end
end

return M
