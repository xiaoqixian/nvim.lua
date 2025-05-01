local utils = require("utils")

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*",
  callback = function()
    utils.set_file_header()
    vim.cmd.normal("G")
  end
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    assert(client ~= nil, "unable to get client")
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

-- -- set filetype for typst files
-- vim.api.nvim_create_autocmd("BufAdd", {
--   pattern = "*.typ",
--   callback = function()
--     vim.opt.filetype = "typst"
--   end
-- })

vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "?*",
  callback = function()
    if vim.fn.expand("%") ~= "" then
      vim.cmd("mkview")
    end
  end
})
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "?*",
  callback = function()
    vim.cmd("silent! loadview")
  end
})
