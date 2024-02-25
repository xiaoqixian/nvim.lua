-- Date: Tue Jan 16 00:24:53 2024
-- Mail: lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

local function cfamily_indent()
  local line_num = vim.fn.line(".")
  local cline = vim.fn.getline(line_num)
  local cindent = vim.fn.cindent(".")

  if cline == 1 then
    return cindent
  end
  local pline_num = vim.fn.prevnonblank(line_num - 1)
  local pline = vim.fn.getline(pline_num)
  
  local pindent = vim.fn.indent(pline_num)
  local shiftwidth = vim.bo.shiftwidth

  if pline:match(".*[<(]%s*$") then
    if cline:match("[>)][,;]%s*$") then
      return pindent
    else 
      return pindent + shiftwidth
    end
  elseif pline:match(">[,;]*%s*$") then
    return pindent
  else 
    return cindet
  end
end

function M.init()
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
    callback = function()
      vim.cmd("setlocal indentexpr = " .. tostring(cfamily_indent()))
    end
  })
end

vim.cmd("source ~/.config/nvim/lua/config/indent.vim")

return M
