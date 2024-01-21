-- The config file for FTerm.nvim plugin
local M = {}

local function opts(desc)
  return {
    desc = desc,
    silent = true,
    nowait = true,
    noremap = true
  }
end

local function fterm_open()
  local fterm = require("FTerm")
  if not vim.g.is_fterm_open then
    vim.g.is_fterm_open = true
    vim.keymap.set({ "n", "t" }, "<leader>ft", fterm.toggle, opts("toggle fterm"))
    fterm.open()
  else 
    fterm.toggle()
  end
end

function M.init() 
  vim.g.is_fterm_open = false
  vim.keymap.set("n", "<leader>ft", fterm_open, opts("open fterm"))
end

return M
