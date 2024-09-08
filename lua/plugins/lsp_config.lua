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
    -- ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
  }

  local servers = { 'rust_analyzer', 'pyright', 'tsserver', "cmake" }

  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  for _, lang in ipairs(servers) do
    lspconfig[lang].setup {
      -- on_attach = my_custom_on_attach,
      capabilities = capabilities,
      handlers = handlers
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

  -- capabilities.semanticTokensProvider = nil
  -- lspconfig.clangd.setup({
  --   capabilities = capabilities,
  --   handlers = handlers,
  --   single_file_support = true
  -- })

  local root_files = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac', -- AutoTools
  }
  local util = require("lspconfig.util")
  local fname = vim.api.nvim_buf_get_name(vim.fn.bufnr())
  local root_dir = util.root_pattern(unpack(root_files))(fname)
  local is_single_file = root_dir == nil
  -- vim.cmd(("echoerr '%s'"):format(root_dir))

  if is_single_file then
    -- vim.cmd(("echo '%s'"):format("you are in single file mode"))
    lspconfig.clangd.setup {
      capabilities = capabilities,
      cmd = {
        "clangd",
        "--compile-commands-dir=/Users/lunar/.config/nvim"
      },
      handlers = handlers,
      single_file_support = true
    }
  else
    -- vim.cmd(("echo '%s'"):format(("you are in work space mode, root_dir = %s"):format(root_dir)))
    lspconfig.clangd.setup {
      capabilities = capabilities,
      handlers = handlers,
      single_file_support = true
    }
  end

end

return M
