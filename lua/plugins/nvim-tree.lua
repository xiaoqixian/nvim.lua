local M = {}

local toggle_key = "E"

-- close nvim-tree after action if nvim-tree is in 
-- float view.
local function float_wrap(f)
  return function()
    local node = require("nvim-tree.lib").get_node_at_cursor()
    local isdir = node and vim.fn.isdirectory(node.absolute_path) or true
    f()
    if vim.g.is_nvim_tree_float and not isdir then
      require("nvim-tree.api").tree.close()
    end
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
  vim.keymap.set("n", toggle_key, api.tree.toggle, { desc = "nvim-tree: toggle", noremap = true, silent = true, nowait = true })
  vim.keymap.set("n", "q", api.tree.toggle, opts("close"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("help"))
  vim.keymap.set('n', 't', api.node.open.tab, opts("open in new tab"))
  vim.keymap.set('n', '<leader>fe', toggle_or_focus, opts("toggle or focus"))

  vim.keymap.set("n", "<CR>", float_wrap(api.node.open.no_window_picker), opts("edit"))
  vim.keymap.set("n", "<S-CR>", float_wrap(api.node.open.edit), opts("edit with window picker"))

  vim.keymap.set("n", "s", float_wrap(api.node.open.vertical), opts("vertical split view"))
  vim.keymap.set("n", "i", float_wrap(api.node.open.horizontal), opts("horizontal split view"))

  vim.keymap.set("n", ">", function()
    api.tree.change_root_to_node()
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
  end, opts("change root to node"))

  vim.keymap.set("n", "<", api.tree.change_root_to_parent, opts("change root to node"))

  vim.keymap.set("n", "a", api.fs.create, opts("fs.create"))
  vim.keymap.set("n", "y", api.fs.copy.node, opts("copy node"))
  vim.keymap.set("n", "p", api.fs.paste, opts("paste node"))
  vim.keymap.set("n", "d", api.fs.trash, opts("move file to trash"))
  vim.keymap.set("n", "D", api.fs.remove, opts("rm file"))
  vim.keymap.set("n", "x", api.fs.cut, opts("cut file"))
  vim.keymap.set("n", "r", api.fs.rename, opts("rename node"))

  -- macOS only
  if vim.loop.os_uname().sysname == "Darwin" then
    vim.keymap.set("n", "o", function(node)
      local lib = require("nvim-tree.lib")
      node = node or lib.get_node_at_cursor()
      vim.fn.jobstart({"open", node.absolute_path}, {detach = true})
    end, opts("open a node using macOS built-in open cmd"))
  end
end

local function get_float_view_config()
  local FLOAT_HEIGHT_RATIO = 0.8
  local FLOAT_WIDTH_RATIO = 0.75
  -- enable float view when the window 
  -- width <= 100.
  return {
    open_win_config = function()
      local screen_w = vim.opt.columns:get()
      local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
      local window_w = screen_w * FLOAT_WIDTH_RATIO
      local window_h = screen_h * FLOAT_HEIGHT_RATIO
      local window_w_int = math.floor(window_w)
      local window_h_int = math.floor(window_h)
      local center_x = (screen_w - window_w) / 2
      local center_y = ((vim.opt.lines:get() - window_h) / 2)
                       - vim.opt.cmdheight:get()
      return {
        border = 'rounded',
        relative = 'editor',
        row = center_y,
        col = center_x,
        width = window_w_int,
        height = window_h_int,
      }
    end
  }
end

-- init is always executed on startup
function M.init()
  local float_view = get_float_view_config()
  local screen_width = vim.opt.columns:get()
  float_view.enable = screen_width <= 100

  require("nvim-tree").setup({
    ui = {
      confirm = {
        remove = true,
        trash = false
      }
    },
    on_attach = on_attach,
    view = {
      float = float_view
    },
    git = {
      enable = true,
      ignore = false
    },
    update_focused_file = {
      enable = true,
      update_root = true
    }
  })

  vim.g.is_nvim_tree_exists = true
  vim.g.is_nvim_tree_open = false
  vim.g.is_nvim_tree_float = float_view.enable

  vim.keymap.set("n", toggle_key, require("nvim-tree.api").tree.open, { desc = "nvim-tree: toggle", noremap = true, silent = true, nowait = true })

  -- auto adjust window width to select 
  -- open aside or open float.
  vim.api.nvim_create_autocmd("VimResized", {
    callback = function()
      local view = require("nvim-tree.view")
      local new_screen_width = vim.opt.columns:get()
      view.View.float.enable = new_screen_width <= 100
      vim.g.is_nvim_tree_float = view.View.float.enable
    end
  })

  vim.cmd("hi NvimTreeNormalFloat ctermbg=none")
end

return M
