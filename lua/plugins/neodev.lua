-- Date:   Sun Feb 25 19:29:32 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

function M.config()
  -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
  require("neodev").setup({})

  -- example to setup lua_ls and enable call snippets
  vim.lsp.config.lua_ls.setup({
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace"
        },
        diagnostics = {
          globals = { "vim" }
        }
      }
    }
  })
end

return M
