-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
--vim.opt.termguicolors = true

is_nvim_tree_open = false

local function toggle_tree() 
    local api = require "nvim-tree.api"
    if is_nvim_tree_open then
        api.tree.toggle()
    else 
        is_nvim_tree_open = true
        api.tree.open()
    end
end

vim.keymap.set('n', '<leader>e', toggle_tree, { desc = "nvim-tree: toggle", buffer = bufnr, noremap = true, silent = true, nowait = true })

local function my_on_attach()
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('up'))
  vim.keymap.set('n', '<tab>', api.node.open.preview,        opts('preview'))
  vim.keymap.set('n', 't', api.node.open.tab,        opts('open new tab'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('help'))
end

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  on_attach = my_on_attach,
})
