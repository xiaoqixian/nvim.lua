-- set mapleader to ,
vim.g.mapleader = ","

vim.keymap.set("i", "jj", "<ESC>")

vim.keymap.set("n", "<space>", "<C-w>w")

-- map <leader>c to copying things into the clipboard.
vim.keymap.set({ "n", "v" }, "<Leader>c", '"+y', { noremap = true, silent = true })

-- map cursor moving between windows to 
-- the coresspoding uppercase letters.
vim.keymap.set("n", "H", "<C-w>h")
vim.keymap.set("n", "J", "<C-w>j")
vim.keymap.set("n", "K", "<C-w>k")
vim.keymap.set("n", "L", "<C-w>l")

vim.keymap.set("n", "<Leader>w", ":write<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { silent = true })

vim.keymap.set("n", "<tab>", ":tabn<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-tab>", ":tabp<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>t<leader>", ":tabnew<CR>", { noremap = true, silent = true })
-- make tab to shift width in visual mode
vim.keymap.set("v", "<tab>", "<S-.>", { noremap = true, silent = true })

-- special mapping, replace all square brackets to curly brackets 
-- in the current line
vim.keymap.set("n", "<leader>zz", ":.s/\\[/{/g<CR>:.s/\\]/}/g<CR>:nohl<CR>", { noremap = true, silent = true })
