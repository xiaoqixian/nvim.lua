-- Date:   Wed Apr 03 22:04:11 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}
local utils = require("utils")

function M.init()
  local opts = {
    outline_window = {
      position = "left",
      hide_cursor = true
    },
    symbol_folding = {
      autofold_depth = 2
    },
    keymaps = {
      toggle_preview = "M",
      fold_all = "D",
      unfold_all = "U",
      hover_symbol = "<S-space>",
      fold_toggle = {},
      fold_toggle_all = {}
    },
    symbols = {
      icons = {
        File = { icon = "", hl = "Identifier" },
        Module = { icon = "", hl = "Include" },
        Namespace = { icon = "", hl = "Include" },
        Package = { icon = "", hl = "Include" },
        Class = { icon = "", hl = "Type" },
        Method = { icon = "ƒ", hl = "Function" },
        Property = { icon = "", hl = "Identifier" },
        Field = { icon = "", hl = "Identifier" },
        Constructor = { icon = "", hl = "Special" },
        Enum = { icon = "", hl = "Type" },
        Interface = { icon = "", hl = "Type" },
        Function = { icon = "", hl = "Function" },
        Variable = { icon = "", hl = "Constant" },
        Constant = { icon = "", hl = "Constant" },
        String = { icon = "", hl = "String" },
        Number = { icon = "#", hl = "Number" },
        Boolean = { icon = "", hl = "Boolean" },
        Array = { icon = "", hl = "Constant" },
        Object = { icon = "", hl = "Type" },
        Key = { icon = "", hl = "Type" },
        Null = { icon = "", hl = "Type" },
        EnumMember = { icon = "", hl = "Identifier" },
        Struct = { icon = "", hl = "Type" },
        Event = { icon = "", hl = "Type" },
        Operator = { icon = "", hl = "Identifier" },
        TypeParameter = { icon = "", hl = "Identifier" },
        Component = { icon = "", hl = "Function" },
        Fragment = { icon = "", hl = "Constant" },
        TypeAlias = { icon = ' ', hl = 'Type' },
        Parameter = { icon = ' ', hl = 'Identifier' },
        StaticMethod = { icon = ' ', hl = 'Function' },
        Macro = { icon = ' ', hl = 'Function' },
      }
    }
  }

  require("outline").setup(opts)
  vim.keymap.set("n", "S",
    utils.toggle_sidebar("Outline", "Outline", nil),
    utils.keymap_opts("Toggle SymbolsOutline")
  )
end

return M
