local utils = require("config.utils")

local function opts(desc) 
  return {
    desc = desc,
    noremap = true,
    nowait = true,
    silent = true
  }
end

-- set mapleader to ,
vim.g.mapleader = ","

vim.keymap.set("i", "jj", "<ESC>", opts("escape insert"))

vim.keymap.set("n", "<space>", "<C-w>w", opts("jump between windows"))

-- map <leader>c to copying things into the clipboard.
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y', opts("copy to clipboard"))

-- map cursor moving between windows to 
-- the coresspoding uppercase letters.
vim.keymap.set("n", "H", "<C-w>h", opts("go to upper window"))
vim.keymap.set("n", "J", "<C-w>j", opts("go to under window"))
vim.keymap.set("n", "K", "<C-w>k", opts("go to right window"))
vim.keymap.set("n", "L", "<C-w>l", opts("to to left  window"))

vim.keymap.set("n", "<Leader>w", ":write<CR>", opts("write"))

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", opts("cancel highlights"))

vim.keymap.set("n", "<tab>", ":tabn<CR>", opts("go to the next tab"))
vim.keymap.set("n", "<S-tab>", ":tabp<CR>", opts("go to the prev tab"))
vim.keymap.set("n", "<leader>t<leader>", ":tabnew<CR>", opts("create a new tab"))
-- make tab to shift width in visual mode
vim.keymap.set("v", "<tab>", "<S-.>", opts("make shift width in visual mode"))

-- special mapping, replace all square brackets to curly brackets 
-- in the current line
vim.keymap.set("n", "<leader>zz", ":.s/\\[/{/g<CR>:.s/\\]/}/g<CR>:nohl<CR>", opts("replace all square brackets to curly brackets"))

-- set file header for empty files
vim.keymap.set("n", "<leader>sh", utils.set_file_header, opts("set file header"))
