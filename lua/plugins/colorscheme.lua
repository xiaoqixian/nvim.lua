return {
  -- add gruvbox
  { "Mofiqul/dracula.nvim" },
  { "octol/vim-cpp-enhanced-highlight" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  }
}
