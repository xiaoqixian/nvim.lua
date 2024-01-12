-- This file can be loaded by calling `lua require('plugins')` from your init.vim

require("lazy").setup({
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = true,
    init = require("plugins/nvim-tree").init
  },
})

--[[return require('packer').startup(function(use)]]
  --[[-- Packer can manage itself]]
  --[[use 'wbthomason/packer.nvim']]

  --[[--use {]]
    --[[--'nvim-telescope/telescope.nvim', tag = '0.1.5',]]
    --[[---- or                            , branch = '0.1.x',]]
    --[[--requires = { {'nvim-lua/plenary.nvim'} }]]
  --[[--}]]

  --[[use {]]
    --[['nvim-tree/nvim-tree.lua',]]
    --[[requires = {]]
      --[['nvim-tree/nvim-web-devicons', -- optional]]
    --[[},]]
  --[[}]]

  --[[use {]]
    --[["williamboman/mason.nvim",]]
    --[["williamboman/mason-lspconfig.nvim",  -- 这个相当于mason.nvim和lspconfig的桥梁]]
    --[["neovim/nvim-lspconfig"]]
  --[[}]]

  --[[use 'hrsh7th/nvim-cmp' -- Autocompletion plugin]]
  --[[use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp]]
  --[[use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp]]
  --[[use 'L3MON4D3/LuaSnip' -- Snippets plugin]]
  --[[use "rafamadriz/friendly-snippets"]]
  --[[use 'hrsh7th/cmp-path']]
  --[[use 'hrsh7th/cmp-cmdline']]
  --[[use 'hrsh7th/cmp-buffer']]
  --[[use 'onsails/lspkind.nvim' -- lspkind symbols]]

  --[[use {]]
    --[['nvim-treesitter/nvim-treesitter',]]
    --[[run = function()]]
        --[[local ts_update = require('nvim-treesitter.install').update({ with_sync = true })]]
        --[[ts_update()]]
    --[[end,]]
  --[[}]]

--[[end)]]
