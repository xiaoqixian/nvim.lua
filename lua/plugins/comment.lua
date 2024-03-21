-- The setup file for 'numToStr/Comment.nvim' plugin.
local M = {}

function M.init()
  require("Comment").setup({
    toggler = {
      line = "<leader>cc",
      block = nil
    },
    opleader = {
      line = "<leader>c",
      block = nil
    },
    mappings = {
      basic = true,
      extra = false
    },
  })

end

return M
