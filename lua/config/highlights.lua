local profile = os.getenv("ITERM_PROFILE")
local utils = require("utils")

local highlights_by_profile = {
  solid = {
    --'hi PMenu ctermfg=225 ctermbg=60 guifg=black guibg=darkgrey',
    'hi PMenu ctermfg=225 ctermbg=none',
    --'hi PMenuSel ctermfg=242 ctermbg=225 guifg=darkgrey guibg=black',
    'hi PMenuSel ctermfg=111 ctermbg=none',
    'hi Comment ctermfg=104 ctermbg=none',
    'hi Search ctermfg=0 ctermbg=111',
    'hi TabLineSel ctermfg=225',
    'hi TabLine ctermfg=255',
    'hi! SignColumn ctermbg=none',
    'hi CursorLine ctermfg=0 ctermbg=111'
  },
  gruvbox = {
    'hi PMenu ctermfg=7 ctermbg=none',
    'hi PMenuSel ctermfg=1 ctermbg=6',
    'hi TabLineSel ctermfg=1',
    'hi TabLine ctermfg=7',
    'hi! SignColumn ctermbg=none',
    'hi Comment ctermfg=101',
    'hi CursorLine ctermfg=0 ctermbg=222',
  },

  latte = {
  }
}

-- universal ErrorMsg highlight
vim.cmd("hi ErrorMsg ctermfg=231 ctermbg=204")
vim.cmd("hi FloatBorder ctermbg=none")
vim.cmd("hi TabLine guibg=none")
vim.cmd("hi TabLineFill guibg=none")
vim.cmd("hi TabLineSel guibg=none")
vim.cmd("hi SignColumn guibg=none")

local highlights = highlights_by_profile[profile] or {}
for _, hl in ipairs(highlights) do
    vim.cmd(hl)
end

if vim.g.nvim_cmp_exists then
  local cmp_hl_by_profile = {
    latte = {
      CmpItemAbbrMatch = "ctermfg=104 ctermbg=none",
    }
  }

  local cmp_hl = {
    CmpItemAbbrMatch = "ctermfg=3 ctermbg=none",
    CmpItemKindFunction = "ctermfg=5 ctermbg=none",
    CmpItemKindKeyword = "ctermfg=6 ctermbg=none",
    CmpItemKindClass = "ctermfg=2 ctermbg=none",
    CmpItemKindTest = "ctermfg=3 ctermbg=none"
  }

  if profile and cmp_hl_by_profile[profile] ~= nil then
    utils.deep_merge(cmp_hl, cmp_hl_by_profile[profile])
  end

  for entry, hl in pairs(cmp_hl) do
    vim.cmd(("hi %s %s"):format(entry, hl))
  end

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
