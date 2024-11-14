-- Date:   Wed Apr 03 22:04:11 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}
local utils = require("utils")
local opts = utils.keymap_opts

function M.init()
    require("symbols-outline").setup({
      position = "left",
      autofold_depth = 2,
      -- auto_close = true,
      auto_unfold_hover = false,
      wrap = true,
      keymaps = {
        toggle_preview = "M",
        fold_all = "D",
        unfold_all = "U",
        hover_symbol = "<S-space>"
      },
      symbols = {
        File = { icon = "", hl = "@text.uri" },
        Module = { icon = "", hl = "@namespace" },
        Namespace = { icon = "", hl = "@namespace" },
        Package = { icon = "", hl = "@namespace" },
        Class = { icon = "", hl = "@type" },
        Method = { icon = "ƒ", hl = "@method" },
        Property = { icon = "", hl = "@method" },
        Field = { icon = "", hl = "@field" },
        Constructor = { icon = "", hl = "@constructor" },
        Enum = { icon = "", hl = "@type" },
        Interface = { icon = "", hl = "@type" },
        Function = { icon = "", hl = "@function" },
        Variable = { icon = "", hl = "@constant" },
        Constant = { icon = "", hl = "@constant" },
        String = { icon = "", hl = "@string" },
        Number = { icon = "#", hl = "@number" },
        Boolean = { icon = "", hl = "@boolean" },
        Array = { icon = "", hl = "@constant" },
        Object = { icon = "", hl = "@type" },
        Key = { icon = "", hl = "@type" },
        Null = { icon = "", hl = "@type" },
        EnumMember = { icon = "", hl = "@field" },
        Struct = { icon = "", hl = "@type" },
        Event = { icon = "", hl = "@type" },
        Operator = { icon = "", hl = "@operator" },
        TypeParameter = { icon = "", hl = "@parameter" },
        Component = { icon = "", hl = "@function" },
        Fragment = { icon = "", hl = "@constant" },
      }
    })
    -- vim.keymap.set("n", "S", "<cmd>SymbolsOutline<CR>", opts("Toggle SymbolsOutline"))
    vim.keymap.set("n", "S",
      utils.toggle_sidebar("Outline", "SymbolsOutline", nil),
      opts("Toggle SymbolsOutline")
    )
end

return M
