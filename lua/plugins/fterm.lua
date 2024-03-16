-- The config file for FTerm.nvim plugin
local M = {}
local opts = require("utils").keymap_opts
local fterm_open = false
local leave_in_insert_mode = true

local function fterm_toggle()
  local fterm = require("FTerm")
  if fterm_open then
    leave_in_insert_mode = vim.fn.mode() ~= "n"
    fterm.close()
  else 
    fterm.open()
    if leave_in_insert_mode then
      vim.cmd("startinsert")
    end
  end
  fterm_open = not fterm_open
end


local function fterm_open()
  local fterm = require("FTerm")
  if not vim.g.is_fterm_open then
    vim.g.is_fterm_open = true
    vim.keymap.set({ "n", "t" }, "Z", fterm_toggle, opts("toggle fterm"))
    fterm_toggle()
  else 
    fterm_toggle()
  end
end

function M.init() 
  vim.g.is_fterm_open = false
  vim.keymap.set("n", "Z", fterm_open, opts("open fterm"))
end

return M
