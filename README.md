# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

### clangd single file configuration

According to this [clangd documentation](https://clangd.llvm.org/config.html#files),
by putting a `config.yaml` file in my "~/Preferences/clangd" directory, with the 
following content.

```
CompileFlags:
  Add: [-std=c++20]
```

Now my clangd supports c++20. 
