# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

### clangd single file configuration

To make clangd support single file while allowing to customize c++ version,
by putting a `.clangd` file in some place you like. The file contains the 
following:
```
CompileFlags:
  Add: [-std=c++20]
```

And you have to specify the file path in your neovim LSP config file, 
you can check this [file](lua/plugins/lsp_config.lua) for more information.

Now clangd supports c++20. 
