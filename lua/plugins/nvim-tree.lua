local M = {}

local function smart_toggle()
  if not vim.g.is_nvim_tree_exists then
    return
  end

  local api = require("nvim-tree.api")

  if not vim.g.is_nvim_tree_open then
    vim.g.is_nvim_tree_open = true
    api.tree.open()
  else
    api.tree.toggle()
  end
end

local function toggle_or_focus()
  local api = require("nvim-tree.api")
  local currentBuf = vim.api.nvim_get_current_buf()
  local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
  if currentBufFt == "NvimTree" then
    api.tree.toggle()
  else 
    api.tree.focus()
  end
end

-- called on nvim-tree loaded
local function on_attach(bufnr)

  local function opts(desc)
    return { 
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true
    }
  end

  local api = require("nvim-tree.api")

  -- overwrite the api.tree.open function here.
  vim.keymap.set("n", "<leader>e", api.tree.toggle, { desc = "nvim-tree: toggle", noremap = true, silent = true, nowait = true })
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("help"))
  vim.keymap.set('n', 't', api.node.open.tab, opts('open in new tab'))
  vim.keymap.set('n', '<leader>fe', toggle_or_focus, opts('toggle or focus'))

  vim.keymap.set("n", "<CR>", api.node.open.edit, { desc = "nvim-tree: open", buffer = bufnr, noremap = true, nowait = true })
  vim.keymap.set("n", "<S-CR>", api.tree.change_root_to_node, opts("change root to node"))
end

-- init is always executed on startup
function M.init() 
  require("nvim-tree").setup({
    on_attach = on_attach,
  })
  vim.g.is_nvim_tree_exists = true
  vim.g.is_nvim_tree_open = false
  vim.keymap.set("n", "<leader>e", require("nvim-tree.api").tree.open, { desc = "nvim-tree: toggle", noremap = true, silent = true, nowait = true })
end

return M

