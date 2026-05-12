-- Date:   Tue Feb 27 14:29:33 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

function M.init()
  -- local border = {
  --   {"╭", "FloatBorder"},
  --   {"─", "FloatBorder"},
  --   {"╮", "FloatBorder"},
  --   {"│", "FloatBorder"},
  --   {"╯", "FloatBorder"},
  --   {"─", "FloatBorder"},
  --   {"╰", "FloatBorder"},
  --   {"│", "FloatBorder"},
  -- }
  local border = "rounded"

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
      active = signs,
    },
    float = {
      header = false,
      border = border,
      focusable = false
    }
  })

  -- LSP settings (for overriding per client)
  local handlers =  {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
  }

  local servers = {
    "rust_analyzer",
    "ts_ls",
    "cmake",
    "tinymist",
    "hls",
    "jdtls"
  }

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  for _, server in ipairs(servers) do
    vim.lsp.config[server] = {
      capabilities = capabilities,
      handlers = handlers,
      single_file_support = true,
    }
    vim.lsp.enable(server)
  end

  vim.lsp.config.pyright = {
    capabilities = capabilities,
    handlers = handlers,
    single_file_support = true,
    settings = {
      python = {
        analysis = {
          diagnosticSeverityOverrides = {
            reportOptionalMemberAccess = "none",
            reportAttributeAccessIssue = "none",
          },
        }
      }
    }
  }
  vim.lsp.enable("pyright")

  vim.lsp.config.gopls = {
    cmd = {'gopls'},
    capabilities = capabilities,
    settings = {
      gopls = {
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
      },
    },
    init_options = {
      usePlaceholders = true,
    },
    handlers = handlers
  }
  vim.lsp.enable("gopls")

  local clangd_capabilities = vim.deepcopy(capabilities)
  clangd_capabilities.semanticTokensProvider = nil

  local cmd = nil
  if vim.fn.has("linux") == 1 then
    cmd = {
      "clangd",
      "-j=1",
      "--background-index",
      "--background-index-priority=low",
      "--pch-storage=disk",
      "--malloc-trim",
      "--log=error"
    }
  else
    cmd = {"clangd"}
  end

  vim.lsp.config.clangd = {
    capabilities = clangd_capabilities,
    cmd = cmd,
    handlers = handlers
  }
  vim.lsp.enable("clangd")

end

return M
