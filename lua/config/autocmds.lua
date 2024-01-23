local function set_most_file_header(extension) 
    local comment_symbol = "//"

    if extension == "py" or extension == "sh" then
        comment_symbol = "#"
    elseif extension == "lua" then
        comment_symbol = "--"
    end

    local header_info = {
        " Date: " .. vim.fn.strftime("%a %b %d %X %Y"),
        " Mail: lunar_ubuntu@qq.com",
        " Author: https://github.com/xiaoqixian",
    }

    for i, info in ipairs(header_info) do
        vim.fn.setline(i, comment_symbol .. info)
    end

    vim.cmd.normal("G")
    vim.fn.append(vim.fn.line("."), "")
    vim.cmd.normal("j")

    -- add header for C/C++ header files
    if extension == "h" or extension == "hpp" then
        local basename = "_".. string.upper(vim.fn.expand("%:t:r")) .. "_" .. string.upper(extension)
        local header_define = {
            "#ifndef " .. basename,
            "#define " .. basename,
            "",
            "",
            "",
            "#endif // " .. basename
        }
        for i, line in ipairs(header_define) do
            vim.fn.append(vim.fn.line("."), line)
            vim.cmd.normal("j")
        end
        vim.cmd.normal("kk")
    end
end

local function set_typst_header() 
    local lines = {
'// Date: ' .. vim.fn.strftime("%a %b %d %X %Y"),
'// Author: https://github.com/xiaoqixian',
'// Mail: lunar_ubuntu@qq.com',
'',
'#let title(content) = {',
'  return align(center)[',
'    #block(inset: (bottom: 20pt))[',
'      #set text(20pt)',
'      #content',
'    ]',
'  ]',
'}',
'',
'#set heading(numbering: "1.")',
'#show heading.where(level: 1): it => [',
'  #block(inset: (bottom: 5pt))[',
'    #set text(16pt)',
'    #it',
'  ]',
']',
'#show heading.where(level: 2): it => [',
'  #block(inset: (bottom: 4pt))[',
'    #set text(14pt)',
'    #it',
'  ]',
']',
'#show heading.where(level: 3): it => [',
'  #block(inset: (bottom: 3pt))[',
'    #set text(13pt)',
'    #it',
'  ]',
']',
'',
'#let mypar(content) = {',
'  if not content.has("children") {',
'    return content',
'  }',
'  let elems = ()',
'',
'  elems.push(h(1em))',
'  for i in content.children {',
'    elems.push(i)',
'    if i.func() == parbreak {',
'      elems.push(h(1em))',
'    }',
'  }',
'  return elems.join()',
'}',
'',
'#set page(numbering: "1/1")',
'#set text(12pt, font: ("Times New Roman", "STSong"))',
'#set list(indent: 20pt)',
'#set enum(indent: 20pt)',
'#set math.equation(numbering: "(1)")',
    }
    for i, line in ipairs(lines) do
        vim.fn.setline(i, line)
    end
end

local function set_file_header()
    local extension = vim.fn.expand("%:e")
    if extension == "" then return end
    local escape_extensions = { "md", "json", "css", "html", "txt" }
    for _, esc_ext in ipairs(escape_extensions) do
        if esc_ext == extension then
            return
        end
    end

    if extension == "typ" then
        set_typst_header()
    else 
        set_most_file_header(extension)
    end

    vim.cmd.normal("G")
end

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*",
    callback = set_file_header
})

-- Tabwidth by file
-- default by 4
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.lua", "*.json", "*.vim", "*.xml", "*.css", "*.typ" },
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
});
