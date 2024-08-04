local utils = require("utils")

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*",
  callback = utils.set_file_header
})

-- Tabwidth by file
-- default by 4
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "json", "vim", "xml", "html", "css", "typst", "haskell", "vue" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
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

-- set iab for cmake files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cmake",
  callback = function()
    local function iab(from, to) 
      vim.cmd(string.format("iab <buffer> %s %s", from, to))
    end

    local keywords = {
      "on", "off", "not",
      "public", "private", "interface",
      "shared", "static",
      "source", "target", "build", "type",
      "required",
      "version", "languages",
      "build_shared_libs", "build_interface", "install_interface",
      "cmake_cxx_standard", "cmake_c_standard",
      "cmake_cxx_standard_required", "cmake_c_standard_required",
      "cmake_c_compiler", "cmake_c_compiler_id", "cmake_c_compiler_version",
      "cmake_cxx_compiler", "cmake_cxx_compiler_id", "cmake_cxx_compiler_version",
      "cmake_system_name",
      "project_name",
      "glob",
      "win32", 
      "git_repository", "git_tag",
      "configure_command", "install_command", "build_command",
    }

    for _, k in ipairs(keywords) do 
      iab(k, k:upper())
    end

  end
})

