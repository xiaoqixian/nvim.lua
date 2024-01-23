-- The setup file for 'numToStr/Comment.nvim' plugin.
local M = {}

function M.init()
  require("Comment").setup({
    mappings = {
      basic = false,
      extra = false
    },
  })
  local api = require('Comment.api')
  vim.keymap.set("n", "<leader>cc", api.call("comment.linewise", "g@$"), { desc = "toggle comment current line", expr = true })
  vim.keymap.set("n", "<leader>cu", api.call("uncomment.linewise", "g@$"), { desc = "uncomment line", expr = true })
end

return M
