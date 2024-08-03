local profile = os.getenv("ITERM_PROFILE")
local default = "solid"

local highlights_by_profile = {
  solid = {
    --'hi PMenu ctermfg=225 ctermbg=60 guifg=black guibg=darkgrey',
    'hi PMenu ctermfg=225 ctermbg=none',
    --'hi PMenuSel ctermfg=242 ctermbg=225 guifg=darkgrey guibg=black',
    'hi PMenuSel ctermfg=111 ctermbg=none',
    'hi Comment ctermfg=104 ctermbg=none',
    'hi Search ctermfg=0 ctermbg=111',
    'hi TabLineFill ctermfg=none ctermbg=none cterm=none',
    'hi TabLineSel ctermfg=225 ctermbg=none',
    'hi TabLine ctermfg=255 ctermbg=none cterm=none',
    'hi! SignColumn ctermbg=none',
    'hi ErrorMsg ctermfg=224 ctermbg=204'
  },
  gruvbox = {
    'hi PMenu ctermfg=7 ctermbg=none',
    'hi PMenuSel ctermfg=1 ctermbg=6',
    'hi TabLineFill ctermfg=none ctermbg=none cterm=none',
    'hi TabLineSel ctermfg=1 ctermbg=none',
    'hi TabLine ctermfg=7 ctermbg=none cterm=none',
    'hi! SignColumn ctermbg=none',
    'hi Comment ctermfg=101',
    'hi FloatBorder ctermbg=none'
  }
}

local highlights = highlights_by_profile[profile] or {}
for i, hl in ipairs(highlights) do
    vim.cmd(hl)
end

if vim.g.nvim_cmp_exists then
  vim.cmd('hi CmpItemAbbrMatch ctermfg=3 ctermbg=none')
  vim.cmd('hi CmpItemKindFunction ctermfg=5 ctermbg=none')
  vim.cmd('hi CmpItemKindKeyword ctermfg=6 ctermbg=none')

  vim.cmd('hi CmpItemKindClass ctermfg=2 ctermbg=none')
  vim.cmd('hi CmpItemKindTest ctermfg=3 ctermbg=none')
end


-- local function python_hl()
--   -- Self is a new hl group
-- end
-- -- filetype wise highlighting
-- local ft = string.lower(vim.bo.filetype)
-- if ft == "python" then
--   fuck()
--   python_hl()
-- end
