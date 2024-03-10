-- nvim-cmp config file
local M = {}

local function lsp_config()
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

  -- show diagnostic after cursor 
  -- holding for 500ms.
  vim.opt.updatetime = 500

  -- LSP settings (for overriding per client)
  local handlers =  {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
  }

  local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }

  for _, lsp in ipairs(servers) do
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    if lsp == "clangd" then
      capabilities.semanticTokensProvider = nil
    end
    lspconfig[lsp].setup {
      -- on_attach = my_custom_on_attach,
      capabilities = capabilities,
      handlers = handlers
    }
  end
end

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

function M.init() 
  vim.g.nvim_cmp_exists = true

  local cmp = require("cmp")
  local lspkind = require("lspkind")
  -- local luasnip = require("luasnip")
  --local vsnip = require("vsnip")

  lsp_config()

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
         -- luasnip.lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),

      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        --[[ elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump() ]]
        --elseif vim.fn["vsnip#jumpable"](1) then
          --vim.fn["vsnip#vsnip-jump-next"]()
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        -- elseif luasnip.jumpable(-1) then
        --   luasnip.jump(-1)
        --elseif vim.fn["vsnip#jumpable"](-1) then
          --vim.fn["vsnip#vsnip-jump-prev"]()
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    }),

    window = {
      completion = cmp.config.window.bordered({
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None"
      }),
      documentation = cmp.config.window.bordered(),
    },

    formatting = {
      format = lspkind.cmp_format({
        with_text = true,
        mode = "symbol",
        maxwidth = 50,
        ellipsis_char = "...",
        show_labelDetails = true
      })
    }
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  if cmp_autopairs then 
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end

  vim.keymap.set("n", "M", vim.lsp.buf.hover)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition)
  
end

return M
