-- Date:   Wed Apr 03 22:04:11 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}
local opts = require("utils").keymap_opts

function M.init()
    require("symbols-outline").setup()
    vim.keymap.set("n", "<leader>ol", ":SymbolsOutline<CR>", opts("Toggle SymbolsOutline"))
end

return M
