-- Date:   Tue Feb 27 14:29:33 2024
-- Mail:   lunar_ubuntu@qq.com
-- Author: https://github.com/xiaoqixian

local M = {}

-- Extract diagnostic configuration into a dedicated function for cleaner initialization
local function setup_diagnostics()
  local border = "rounded"
  local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = {
      active = signs,
    },
    float = {
      header = false,
      border = border,
      focusable = false,
    },
  })

  return border
end

function M.init()
  local border = setup_diagnostics()

  -- Define global LSP capabilities and handlers
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
  }

  -- Pre-configure OS-specific commands and custom capabilities
  local clangd_cmd = { "clangd" }
  if vim.fn.has("linux") == 1 then
    clangd_cmd = {
      "clangd",
      "-j=1",
      "--background-index",
      "--background-index-priority=low",
      "--pch-storage=disk",
      "--malloc-trim",
      "--log=error",
    }
  end

  local clangd_capabilities = vim.deepcopy(capabilities)
  clangd_capabilities.semanticTokensProvider = nil

  -- Centralized server configuration table
  local servers = {
    -- Servers relying entirely on default configurations
    ts_ls = {},
    cmake = {},
    tinymist = {},
    hls = {},
    jdtls = {},

    -- Custom server configurations
    pyright = {
      settings = {
        python = {
          analysis = {
            diagnosticSeverityOverrides = {
              reportOptionalMemberAccess = "none",
              reportAttributeAccessIssue = "none",
            },
          },
        },
      },
    },

    gopls = {
      cmd = { "gopls" },
      init_options = {
        usePlaceholders = true,
      },
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
    },

    rust_analyzer = {
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
        },
      },
    },

    clangd = {
      cmd = clangd_cmd,
      capabilities = clangd_capabilities,
    },
  }

  -- Base configuration applied to all language servers
  local default_config = {
    capabilities = capabilities,
    handlers = handlers,
    single_file_support = true,
  }

  -- Iterate through the table, merge configurations, and enable servers
  for server, custom_config in pairs(servers) do
    -- vim.tbl_deep_extend safely merges the base config with specific overrides (like clangd's capabilities)
    vim.lsp.config[server] = vim.tbl_deep_extend("force", default_config, custom_config)
    vim.lsp.enable(server)
  end
end

return M
