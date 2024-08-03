-- The config file for fterm.nvim plugin
local M = {}
local opts = require("utils").keymap_opts
local is_fterm_open = false
local leave_in_insert_mode = true

local function fterm_toggle()
  local fterm = require("fterm")
  if is_fterm_open then
    leave_in_insert_mode = vim.fn.mode() ~= "n"
    fterm.close()
  else
    fterm.open()
    if leave_in_insert_mode then
      vim.cmd("startinsert")
    end
  end
  is_fterm_open = not is_fterm_open
end


local function fterm_open()
  if not vim.g.is_fterm_open then
    vim.g.is_fterm_open = true
    vim.keymap.set({ "n", "t" }, "Z", fterm_toggle, opts("toggle fterm"))
    fterm_toggle()
  else
    fterm_toggle()
  end
end

function M.init() 
  local fterm = require("fterm")
  vim.g.is_fterm_open = false
  vim.keymap.set("n", "Z", fterm_open, opts("open fterm"))
  vim.keymap.set("n", "<leader>tt", function()
    fterm.new_tab()
  end, opts("fterm: open a new tab"))
  vim.keymap.set("n", "<leader>nn", fterm.next_tab, opts("fterm: jump to next tab"))
end

return M
