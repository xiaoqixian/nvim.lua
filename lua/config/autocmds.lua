local utils = require("config.utils")

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*",
  callback = utils.set_file_header
})

-- Tabwidth by file
-- default by 4
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "json", "vim", "xml", "css", "typst" },
  callback = function()
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
  end
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- cancel semantic highlighting for c/cpp
    -- cause I've got better solution.
    if client.name == "clangd" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  pattern = { "*.cpp", "*.c", "*.cc", "*.h", "*.hpp", "*.rs" },
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end
})

-- set filetype for typst files
vim.api.nvim_create_autocmd("BufAdd", {
  pattern = "*.typ",
  callback = function()
    vim.opt.filetype = "typst"
  end
})

-- to stop indent access specifier in C++
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp" },
  callback = function()
    vim.keymap.set("i", ":", utils.stop_cpp_access_indent, utils.keymap_opts("stop c++ access specifier indent", { buffer = 0 }))
  end
})
