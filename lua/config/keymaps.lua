local utils = require("utils")
local opts = utils.keymap_opts

-- set mapleader to ,
vim.g.mapleader = ","

vim.keymap.set("i", "jj", "<ESC>", opts("escape insert"))

vim.keymap.set("n", "<space>", "<C-w>w", opts("jump between windows"))

vim.keymap.set("n", "U", "<C-r>", opts("map U to undo undo"))

-- map <leader>c to copying things into the clipboard.
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', opts("copy to clipboard"))

vim.keymap.set("", "<ScrollWheelUp>", "2k", opts("move cursor up with mouse scroll"))
vim.keymap.set("", "<ScrollWheelDown>", "2j", opts("move cursor down with mouse scroll"))
vim.keymap.set("i", "<LeftMouse>", "<Nop>", opts("disable mouse left click in insert mode"))

-- disable default goto diagnostics keymap
vim.cmd(":unmap [d")
vim.cmd(":unmap ]d")

-- temporary
vim.keymap.set("n", "I", ":Inspect<CR>", opts("check hl group under cursor"))

-- Code Action
vim.keymap.set("n", "CA", ":lua vim.lsp.buf.code_action()<CR>", opts("invoke a code action"))

-- map cursor moving between windows to 
-- the coresspoding uppercase letters.
vim.keymap.set("n", "H", "<C-w>h", opts("go to upper window"))
vim.keymap.set("n", "J", "<C-w>j", opts("go to under window"))
vim.keymap.set("n", "K", "<C-w>k", opts("go to right window"))
vim.keymap.set("n", "L", "<C-w>l", opts("go to left  window"))

-- swap v and V
vim.keymap.set("n", "v", "V", opts("visual line"))
vim.keymap.set("n", "V", "v", opts("visual"))

vim.keymap.set("n", "<leader>w", ":write<CR>", opts("write"))

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

vim.keymap.set("t", "jj", "<C-\\><C-n>", opts("escape terminal mode"))

vim.keymap.set("n", "[", vim.diagnostic.goto_prev, opts("goto prev error"))
vim.keymap.set("n", "]", vim.diagnostic.goto_next, opts("goto next error"))

vim.keymap.set("t", "<S-Space>", "<Space>", opts("tmap S-space to space"))
vim.keymap.set("t", "<S-Backspace>", "<Backspace>", opts("tmap S-Backspace to Backspace"))

-- vim.keymap.set("n", "<Enter>", "0v$%$", opts("v-select a code block"))

vim.keymap.set("n", "<leader>aa", function()
  local config_path = vim.fn.stdpath("config") .. "/lua"
  vim.cmd("tabnew " .. config_path)
end, opts("fast way to open nvim config"))
