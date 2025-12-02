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
      active = signs,
      -- text = {
      --   [vim.diagnostic.severity.ERROR] = "",
      --   [vim.diagnostic.severity.WARN] = "",
      --   [vim.diagnostic.severity.HINT] = "󰌵",
      --   [vim.diagnostic.severity.INFO] = "",
      -- },
      -- texthl = {
      --   [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      --   [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      --   [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      --   [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      -- },
      -- numhl = {
      --   [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      --   [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      --   [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      --   [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      -- },
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
    -- ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
  }

  local servers = {
    "rust_analyzer",
    "pyright",
    "ts_ls",
    "cmake",
    -- "clangd",
    "tinymist",
    "hls",
    "jdtls"
  }

  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  for _, server in ipairs(servers) do
    lspconfig[server].setup {
      -- on_attach = my_custom_on_attach,
      capabilities = capabilities,
      handlers = handlers,
      single_file_support = true
    }
  end

  --- set gopls
  lspconfig['gopls'].setup{
    cmd = {'gopls'},
    -- on_attach = on_attach,
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

  -- set clangd
  capabilities.semanticTokensProvider = nil

  -- local root_files = {
  --   '.clangd',
  --   '.clang-tidy',
  --   '.clang-format',
  --   'compile_commands.json',
  --   'compile_flags.txt',
  --   'configure.ac', -- AutoTools
  -- }
  -- local util = require("lspconfig.util")
  -- local fname = vim.api.nvim_buf_get_name(vim.fn.bufnr())
  -- local root_dir = util.root_pattern(unpack(root_files))(fname)
  -- local ext = fname:match(".*%.([^%.]+)$")

  local cmd = nil
  if vim.fn.has("linux") == 1 then
    cmd = {
      "clangd",
      "-j=4",
      "--background-index",
      "--background-index-priority=low",
      "--pch-storage=disk",
      "--malloc-trim",
      "--log=error"
    }
  else
    cmd = {"clangd"}
  end

  -- if root_dir == nil and ext ~= "c" then
  --   vim.notify(("root_dir = %s, ext = %s"):format(root_dir, ext))
  --   table.insert(cmd, ("--compile-commands-dir=%s/.config/nvim"):format(vim.fn.getenv("HOME")))
  -- end
  lspconfig.clangd.setup {
    capabilities = capabilities,
    cmd = cmd,
    handlers = handlers
  }

end

return M
