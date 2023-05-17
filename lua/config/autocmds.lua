-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable autoformat for cpp files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "cpp" },
  callback = function()
    vim.b.autoformat = false
  end,
})

Headers = {
    cpp = {"/********************************************", 
            string.format(
            " > File Name       : %s", vim.fn.expand("%")),
            " > Author          : lunar",
            " > Email           : lunar_ubuntu@qq.com",
            string.format(
            " > Created Time    : %s", vim.fn.strftime("%c")),
            " > Copyright@ https://github.com/xiaoqixian",
            "********************************************/"
    }
}

function add_header()
	filetype = vim.fn.expand("%:e")
	if Headers[filetype] ~= nil then
		vim.fn.setline(".", Headers[filetype])
	end
end

local _group = vim.api.nvim_create_augroup("AutoHeader", { clear = true })
vim.api.nvim_create_autocmd(
	"BufNewFile",
	{ pattern = { "*.sh", "*.py", "*.cpp"}, callback = add_header, once = true, group = _group }
)
