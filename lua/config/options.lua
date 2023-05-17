-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","
vim.opt.guicursor = ""
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = true
vim.opt.pumblend = 0

vim.g.transparency = true


require("mini.comment").setup({
    mappings = {
        comment_line = "<leader>cc",
        comment = "<leader>cc"
    }
})
