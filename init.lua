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

vim.g.distro = require("utils").distro()

-- typst filetype support
vim.filetype.add({
  extension = {
    typ = "typst"
  }
})

require("config/keymaps")
require("config/autocmds")
require("config/cmds")
require("config/options")

require("plugins")
-- the following map is set by the builtin plugin matchit,
-- so I have to move the unmap command here, so the plugin 
-- is actually loaded.
vim.cmd(":unmap [%")
vim.cmd(":unmap ]%")

-- vim.cmd("colorscheme default")

require("config/highlights")
require("config/machine_specific")

