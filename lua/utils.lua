local M = {}

function M.echoerr(msg)
  vim.cmd(string.format("echoerr '%s'", msg))
end

function M.deep_merge(t1, t2)
  function deep_merge_impl(t1, t2)
    for k, v in pairs(t2) do 
      if type(v) == "table" and t1[k] ~= nil then 
        deep_merge_impl(t1[k], v)
      else 
        t1[k] = v
      end
    end
  end

  if type(t2) ~= "table" then 
    return
  end

  assert(type(t1) == "table")
  deep_merge_impl(t1, t2)
end

local function index(list, target) 
  for i, elem in ipairs(list) do
    if elem == target then
      return i
    end
  end
  return 0
end

local function contains(list, target) 
  return index(list, target) > 0
end

local function set_most_file_header(extension) 
  local ft = vim.bo.filetype
  local cmt_syb_table = {
    py = "#",
    sh = "#",
    lua = "--",
    vim = '"',
    cmake = "#",
    haskell = "--"
  }

  local cmt_syb = cmt_syb_table[extension] or cmt_syb_table[ft] or "//"

  local header_lines = {
    cmt_syb .. " Date:   " .. vim.fn.strftime("%a %b %d %X %Y"),
    cmt_syb .. " Mail:   lunar_ubuntu@qq.com",
    cmt_syb .. " Author: https://github.com/xiaoqixian",
    ""
  }

  local cur_line = vim.fn.line(".") - 1

  vim.api.nvim_buf_set_lines(0, cur_line, cur_line + #header_lines, false, header_lines)

  vim.cmd.normal("G")

end

-- set C-family header file header
local function set_cheader_header(extension)
  local macro_name = string.format("_%s_%s", 
    string.upper(vim.fn.expand("%:t:r")),
    string.upper(extension))

  local header_define = {
    "#ifndef " .. macro_name,
    "#define " .. macro_name,
    "",
    "",
    "",
    "#endif // " .. macro_name
  }

  local btm_line = vim.fn.line("$")
  vim.api.nvim_buf_set_lines(0, btm_line, btm_line + #header_define, false, header_define)
  vim.cmd.normal("Gkk")
end

local function set_typst_header() 
  local lines = {
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
    '  elems.push(h(2em))',
    '  for i in content.children {',
    '    elems.push(i)',
    '    if i.func() == parbreak {',
    '      elems.push(h(2em))',
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
    '#show par: set block(spacing: 1.5em)',
    '#set par(leading: 1em)',
    '',
    '#show terms.item: it => [',
      '#text(font: "Kai", weight: "bold")[#it.term]',
      '#h(1em)',
      '#it.description',
    ']',
    '',
    '#let abstract(content) = {',
    '  return align(center)[',
    '    #block(outset: 20pt, width: 80%)[',
    '      #text(16pt, weight: "bold")[Abstract]',
    '',
    '      #set text(10pt)',
    '      #set align(left)',
    '      #h(2em)',
    '      #content',
    '    ]',
    '    #v(2em)',
    '  ]',
    '}',
    '',
    '#let term(content) = text(font: ("Kefa", "Kai"), style: "italic")[#content]'
  }

  local btm_line = vim.fn.line("$")
  vim.api.nvim_buf_set_lines(0, btm_line, btm_line + #lines, false, lines)
end

function M.set_file_header()
  local extension = vim.fn.expand("%:e")
  local escape_extensions = { 
    "", "md", "json", "css", "html", "txt", "toml", "yml", "xml" 
  }

  if contains(escape_extensions, extension) then
    return
  end

  set_most_file_header(extension)

  local extra_feedings = {
    typ = set_typst_header,
    h = set_cheader_header,
    hpp = set_cheader_header
  }

  if type(extra_feedings[extension]) == "function" then
    extra_feedings[extension](extension)
  end

end

function M.stop_cpp_access_indent()
  local line_num = vim.fn.line(".")
  local curr_line = vim.fn.getline(".") .. ":"
  local access_specifier_list = {
    "public", "private", "protected"
  }

  local flag = false
  for _, sp in ipairs(access_specifier_list) do
    if curr_line:match("^%s*" .. sp) then
      flag = true
    end
  end

  if not flag then
    vim.api.nvim_put({ ":" }, "c", false, true)
  else 
    local new_line, _ = curr_line:gsub(" ", "", vim.bo.shiftwidth)
    vim.api.nvim_set_current_line(new_line)
  end

end

function M.keymap_opts(desc, extra_opts) 
  local opts = {
    desc = desc,
    noremap = true,
    nowait = true,
    silent = true
  }

  if type(extra_opts) == "table" then
    for k, v in pairs(extra_opts) do 
      opts[k] = v
    end
  end

  return opts
end

return M
