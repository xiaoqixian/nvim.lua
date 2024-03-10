-- Date:   Tue Feb 27 14:29:33 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

function M.init()
  local lspconfig = require('lspconfig')

  local border = {
    {"╭", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╮", "FloatBorder"},
    {"│", "FloatBorder"},
    {"╯", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╰", "FloatBorder"},
    {"│", "FloatBorder"},
  }

  local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- config vim.diagnostic
  vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = {
      active = signs
    },
    float = {
      header = false,
      border = "rounded",
      focusable = false
    }
  })

  -- LSP settings (for overriding per client)
  local handlers =  {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
  }

  local servers = { 'rust_analyzer', 'pyright', 'tsserver' }

  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      -- on_attach = my_custom_on_attach,
      capabilities = capabilities,
      handlers = handlers
    }
  end

  capabilities.semanticTokensProvider = nil

  lspconfig.clangd.setup {
    capabilities = capabilities,
    -- cmd = {
    --   "clangd",
    --   "compile-commands-dir=/Users/lunar/.config/nvim"
    -- },
    handlers = handlers
  }

end

return M