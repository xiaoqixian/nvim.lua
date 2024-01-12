highlights = {
--'hi PMenu ctermfg=225 ctermbg=60 guifg=black guibg=darkgrey',
'hi PMenu ctermfg=225 ctermbg=none guifg=white guibg=darkgrey',
--'hi PMenuSel ctermfg=242 ctermbg=225 guifg=darkgrey guibg=black',
'hi PMenuSel ctermfg=242 ctermbg=none guifg=blue guibg=black',
'hi Comment ctermfg=104 ctermbg=none',
'hi Search ctermfg=116 ctermbg=211',
'hi TabLineFill ctermfg=none ctermbg=none gui=none cterm=none',
'hi TabLineSel ctermfg=225 ctermbg=none',
'hi TabLine ctermfg=255 ctermbg=none cterm=none',
'hi! SignColumn ctermbg=none',
}

for i, hl in ipairs(highlights) do
    vim.cmd(hl)
end

local function cpp_enhanced()
  local extension = vim.fn.expand("%:e")
  if extension == "cpp" then
    vim.cmd("source /Users/lunar/.config/nvim/lua/after/syntax/cpp_stl.vim")
    vim.cmd("source /Users/lunar/.config/nvim/lua/after/syntax/cpp.vim")
  end
end

--cpp_enhanced()

--local M = {}

--function M.get()
	--return {
		--CmpItemAbbr = { fg = C.overlay2 },
		--CmpItemAbbrDeprecated = { fg = C.overlay0, style = { "strikethrough" } },
		--CmpItemKind = { fg = C.blue },
		--CmpItemMenu = { fg = C.text },
		--CmpItemAbbrMatch = { fg = C.text, style = { "bold" } },
		--CmpItemAbbrMatchFuzzy = { fg = C.text, style = { "bold" } },

		---- kind support
		--CmpItemKindSnippet = { fg = C.mauve },
		--CmpItemKindKeyword = { fg = C.red },
		--CmpItemKindText = { fg = C.teal },
		--CmpItemKindMethod = { fg = C.blue },
		--CmpItemKindConstructor = { fg = C.blue },
		--CmpItemKindFunction = { fg = C.blue },
		--CmpItemKindFolder = { fg = C.blue },
		--CmpItemKindModule = { fg = C.blue },
		--CmpItemKindConstant = { fg = C.peach },
		--CmpItemKindField = { fg = C.green },
		--CmpItemKindProperty = { fg = C.green },
		--CmpItemKindEnum = { fg = C.green },
		--CmpItemKindUnit = { fg = C.green },
		--CmpItemKindClass = { fg = C.yellow },
		--CmpItemKindVariable = { fg = C.flamingo },
		--CmpItemKindFile = { fg = C.blue },
		--CmpItemKindInterface = { fg = C.yellow },
		--CmpItemKindColor = { fg = C.red },
		--CmpItemKindReference = { fg = C.red },
		--CmpItemKindEnumMember = { fg = C.red },
		--CmpItemKindStruct = { fg = C.blue },
		--CmpItemKindValue = { fg = C.peach },
		--CmpItemKindEvent = { fg = C.blue },
		--CmpItemKindOperator = { fg = C.blue },
		--CmpItemKindTypeParameter = { fg = C.blue },
		--CmpItemKindCopilot = { fg = C.teal },
	--}
--end

--return M
