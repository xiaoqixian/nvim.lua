-- Date:   Sun Feb 25 16:17:32 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local utils = require("utils")
local opts = utils.keymap_opts
local os_type = utils.os()

if os_type == "Linux" then
  vim.keymap.set("v", "<leader>y", ":'<,'>w! /tmp/clip<CR>", opts("linux copy to clipboard"))
end
