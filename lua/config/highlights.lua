highlights = {
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
  'hi CursorLine ctermfg=0 ctermbg=111',
  'hi CursorLineNr ctermfg=0 ctermbg=111',
  --[[ 'hi CursorLine ctermfg=236 ctermbg=105 underline=none' ]]
}

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

-- filetype wise highlighting
local ft = string.lower(vim.bo.filetype)
if ft == "python" then
  python_hl()
end

local function python_hl()
  -- Self is a new hl group
  vim.cmd("syn keyword Self self")
  vim.cmd("syn keyword Number None")
  vim.cmd("syn keyword Number True")
  vim.cmd("syn keyword Number False")
  vim.api.nvim_set_hl(0, "Self", { ctermfg = 3, italic = true })
end
