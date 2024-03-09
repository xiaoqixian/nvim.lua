local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- require("lazy").setup({
--   install = {
--     missing = true,
--   }
-- })

require("config/keymaps")
require("config/options")
require("config/autocmds")
require("config/indent")

require("plugins")

-- vim.cmd("colorscheme default")

require("config/highlights")
require("config/machine_specific")
