local M = {}

function M.echoerr(msg)
  vim.cmd(string.format("echoerr '%s'", msg))
end

function M.deep_merge(t1, t2)
  local function deep_merge_impl(ot1, ot2)
    for k, v in pairs(ot2) do
      if type(v) == "table" and ot1[k] ~= nil then
        deep_merge_impl(ot1[k], v)
      else
        ot1[k] = v
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
  local cmt_syb_table = {
    py = "#",
    sh = "#",
    lua = "--",
    vim = '"',
    cmake = "#",
    hs = "--", -- haskell
  }

  local cmt_syb = cmt_syb_table[extension] or "//"

  local header_lines = {
    cmt_syb .. " Date:   " .. vim.fn.strftime("%a %b %d %X %Y"),
    cmt_syb .. " Mail:   lunar_ubuntu@qq.com",
    cmt_syb .. " Author: https://github.com/xiaoqixian",
    ""
  }

  vim.api.nvim_buf_set_lines(0, 0, 0, false, header_lines)
end

-- set C-family header file header
local function set_cheader_header()
  local header_define = {
    "#pragma once"
  }

  local btm_line = vim.fn.line("$")
  vim.api.nvim_buf_set_lines(0, btm_line, btm_line + #header_define, false, header_define)
  vim.cmd.normal("G")
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
  local valid_extensions = {
    "c", "h", "hpp", "cpp", "cc",
    "java", "py", "rs", "js", "ts",
    "lua", "hs", "typ", "go"
  }

  local extra_check = function()
    local filename = vim.fn.expand("%:t")
    if filename == "CMakeLists.txt" then
      return "cmake"
    end
    return nil
  end

  local kind = nil
  if contains(valid_extensions, extension) then
    kind = extension
  else
    kind = extra_check()
  end

  if kind == nil then
    return
  end

  set_most_file_header(kind)

  local extra_feedings = {
    typ = set_typst_header,
  }

  if type(extra_feedings[kind]) == "function" then
    extra_feedings[kind]()
  end

end

function M.stop_cpp_access_indent()
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

---@return string
function M.colorscheme_by_profile()
  local profile = os.getenv("ITERM_PROFILE")
  if profile == nil then
    return "default"
  end

  local profile_theme = {
    gruvbox = "gruvbox",
    ["catppuccin-mocha"] = "catppuccin-mocha",
    latte = "rose-pine"
  }

  return profile_theme[profile] or "default"
end

---@param colorscheme string
---@return boolean
function M.enable_colorscheme(colorscheme)
  local profile = os.getenv("ITERM_PROFILE")
  return M.colorscheme_by_profile() == colorscheme or profile == colorscheme
end

function M.os()
  if package.config:sub(1,1) == '\\' then
    return "Windows"
  else
    local handle = io.popen("uname -s")
    assert(handle, "execute 'uname -s' failed")
    local result = handle:read("*l")
    handle:close()

    if result == "Darwin" then
      return "macOS"
    elseif result == "Linux" then
      return "Linux"
    else
      return nil
    end
  end
end

function M.distro()
  local os = M.os()
  if os ~= "Linux" then
    return os
  end

  local handle = io.popen("uname -a")
  assert(handle, "execute 'uname -a' failed")
  local result = handle:read("*l")
  handle:close()

  local candidates = {"Arch", "Ubuntu", "Debian"}
  for _, distro in ipairs(candidates) do
    if result:match(distro) then
      return distro
    end
  end
  return "Unknown"
end

-- map { to find the closest function(method) or class(struct)
function M.find_parent()
  local function cmp_indent(cln, ln)
    local curr_indent = vim.fn.indent(cln)
    local line_indent = vim.fn.indent(ln)
    return curr_indent <= line_indent
  end

  local resolve = {
    python = {
      "def.*:%s*$",
      "class.*:%s*$"
    },
    rust = {
      "fn ",
      "^%s*impl ",
      "^(%s*pub%s+)?struct ",
      "^(%s*pub%s+)?enum ",
    }
  }

  ---@return boolean
  local function find()
    local ft = vim.bo.filetype
    if not resolve[ft] then
      return false
    end
    local patterns = resolve[ft]
    local linenr = vim.api.nvim_win_get_cursor(0)[1]

    local lines_above_cursor = vim.api.nvim_buf_get_lines(0, 0, linenr, true)
    for ln = linenr-1, 1, -1 do
      if cmp_indent(linenr, ln) then
        goto continue
      end

      local line = lines_above_cursor[ln]
      for _, pat in ipairs(patterns) do
        if line:match(pat) then
          local col = vim.fn.col({ln, "$"}) - 1
          vim.api.nvim_win_set_cursor(0, {ln, col})
          return true
        end
      end
        ::continue::
    end
    return false
  end

  -- fallback
  if not find() then
    vim.cmd("normal! {")
  end
end

function M.format_rs(fallback)

  local function split_string(input, delimiter)
    local result = {}
    for match in (input .. delimiter):gmatch("%s*(.-)%s*" .. delimiter) do
        table.insert(result, match)
    end
    return result
  end

  local line = vim.api.nvim_get_current_line()
  local ln = vim.fn.line(".")
  if line:match("^fn ") or line:match(" fn ") then
    local indent = vim.fn.indent(".")
    local pad = (" "):rep(indent)
    local more_pad = (" "):rep(indent + vim.bo.shiftwidth)

    local left, inside, right = line:match("(.-%()(.-)(%).*)")
    assert(left and inside and right)

    local lines = {}
    table.insert(lines, left)

    local args = split_string(inside, ",")
    for _, arg in ipairs(args) do
      table.insert(lines, more_pad .. arg .. ",")
    end
    table.insert(lines, pad .. right)

    vim.api.nvim_buf_set_lines(0, ln-1, ln, false, lines)
  else
    fallback()
  end
end

function M.format_cpp(fallback)
  local function split_string(input, delimiter)
    local result = {}
    for match in (input .. delimiter):gmatch("%s*(.-)%s*" .. delimiter) do
      table.insert(result, match)
    end
    return result
  end

  local line = vim.api.nvim_get_current_line()
  local ln = vim.fn.line(".")

  local identifier, parameters, ret, brackets = line:match("([^%)]+)%(([^%)]*)%)([^%{]-)%s*({?}?)%s*$")
  if identifier and parameters and ret then
    local indent = vim.fn.indent(".")
    local pad = (" "):rep(indent)
    local more_pad = (" "):rep(indent + vim.bo.shiftwidth)

    local lines = {}
    table.insert(lines, identifier .. "(")

    if #parameters > 0 then
      local args = split_string(parameters, ",")
      for i, arg in ipairs(args) do
        if i == #args then
          table.insert(lines, more_pad .. arg)
        else
          table.insert(lines, more_pad .. arg .. ",")
        end
      end
    end

    table.insert(lines, pad .. ")" .. ret)

    if brackets ~= "" then
      table.insert(lines, brackets)
    end

    vim.api.nvim_buf_set_lines(0, ln-1, ln, false, lines)
  else
    fallback()
  end
end

M.sidebar_plugins = {}
--- toggle sidebar plugins, I wish there's only one sidebar plugin 
--- at a time, and I don't want to always close one before opening 
--- another one. So I write this function to automatically close 
--- the before sidebar plugin.
--- If the close_cmd is nil, it means the close command is the same 
--- as the open command.
--- @param name string assume the plugin name is the same as the plugin buffer filetype
--- @param action string | function
--- @param close string | function | nil
--- @return function
function M.toggle_sidebar(name, action, close)
  local function invoke(h)
    if type(h) == "string" then
      vim.cmd(h)
    elseif type(h) == "function" then
      h()
    else
      error("invalid type: " .. type(h))
    end
  end

  -- iterate all windows in the current tabpage, check if any filetype 
  -- of the buffer in that window matches any of the registered sidebar plugins.
  -- If does, returns the plugin's name.
  -- Else returns nil.
  function M.any_opened()
    local tabnr = vim.api.nvim_get_current_tabpage()
    local windows = vim.api.nvim_tabpage_list_wins(tabnr)

    for _, winnr in ipairs(windows) do
      local bufnr = vim.api.nvim_win_get_buf(winnr)
      local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
      if M.sidebar_plugins[ft] ~= nil then
        return ft
      end
    end
    return nil
  end

  M.sidebar_plugins[name] = {
    action = action,
    close = close or action
  }

  return function()
    local opend = M.any_opened()
    if opend ~= nil then
      local plugin = M.sidebar_plugins[opend]
      invoke(plugin.close)
    end

    if opend ~= name then
      invoke(action)
    end
  end
end

--@param code string
function M.leetcode_cpp_injector_before(code)
  local find_string = false
  local find_vector = false
  for word in code:gmatch("%a+") do
    if not find_string and word == "string" then
      find_string = true
    elseif not find_vector and word == "vector" then
      find_vector = true
    end
  end

  local res = {}
  if find_string then
    table.insert(res, "#include <string>")
  end
  if find_vector then
    table.insert(res, "#include <vector>")
  end
  if find_string then
    table.insert(res, "using std::string;")
  end
  if find_vector then
    table.insert(res, "using std::vector;")
  end

  return res
end

return M
