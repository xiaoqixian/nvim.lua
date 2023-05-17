-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<space>", "<C-w>w", { desc = "move window with space key" })
map("n", "<leader>nh", ":nohl<CR>", { desc = "no highlight" })
map("n", "<leader>w", ":w<CR>", { desc = "save" })

map("i", "jj", "<ESC>", { desc = "jj to exit insert mode" })

map("n", "<tab>", ":tabnext<CR>", { desc = "tab next", silent = true })
map("n", "<S-tab>", ":tabp<CR>", { desc = "tab prev", silent = true })
map("n", "<leader>t<leader>", ":tabnew<CR>", {desc = "tab new"})
map("n", "<leader>tc", ":tabclose<CR>", {desc = "tab close"})
