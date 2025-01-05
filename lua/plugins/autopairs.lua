local M = {}

local function content_before_cursor(line)
  local col = vim.fn.col(".")
  return line:sub(1, col-1)
end

local function cpp_curly_pairing(line)
  local keywords = { "class", "struct", "enum", "union", "concept" }
  for _, kw in ipairs(keywords) do
    if line:match("^%s*" .. kw .. ".*") then
      return "};"
    end
  end

  local col = vim.fn.col(".")
  local before = line:sub(1, col - 1)
  local after = line:sub(col)
  if before:match("%[.*%]%(.*%)[^%{]*") and after:match("^%s*$") then
    return "};"
  end

  return "}"
end

local function cpp_angle_pairing(line)
  local before = content_before_cursor(line)
  if before:match("template%s*$") then
    return ">"
  elseif before:match("operator<*$") then
    return ""
  elseif before:match("%w$") then
    return ">"
  else
    return ""
  end
end

local function rust_angle_pairing(line)
  local before = content_before_cursor(line)
  if before:match("%w$") or before:match("::$") then
    return ">"
  else
    return ""
  end
end

local function regular_angle_pairing(line)
  local before = content_before_cursor(line)
  if before:match("%w$") then
    return ">"
  else
    return ""
  end
end

local function rust_curly_pairing(line)
  local pats = {
    "^%s*use%s+([^{]+)[^;]$",
    "^%s*let%s+([_a-z][_a-z0-9]*)%s*=[^{]*[^;]$"
  }

  for _, pat in ipairs(pats) do
    if line:match(pat) then
      return "};"
    end
  end
  return "}"
end

function M.init()
  local ap = require("nvim-autopairs")
  local Rule = require("nvim-autopairs.rule")
  local cond = require("nvim-autopairs.conds")

  ap.setup({
    enable_abbr = true
  })

  ap.get_rules("{")[1].not_filetypes = { "cpp", "c" }

  ap.add_rules({
    Rule("{", "}", {"c", "cpp"})
      :with_pair(function(opts)
        return cpp_curly_pairing(opts.line) == "}"
      end)
      :replace_endpair(function(opts)
        -- autopairing for cpp namespace comments
        local _, _, ns = opts.line:find("^%s*namespace (%S+)")
        if ns then
          return "} // namespace " .. ns
        end
        return "}"
      end)
      :use_key("{")
      :with_del(cond.done())
      :with_move(cond.done())
    ,

    Rule("{", "};", {"c", "cpp"})
      :with_pair(function(opts)
        return cpp_curly_pairing(opts.line) == "};"
      end)
      :use_key("{")
      :with_del(cond.done())
      :with_move(cond.done())
    ,

    Rule("<", ">", "cpp")
      :with_pair(function(opts)
        return cpp_angle_pairing(opts.line) == ">"
      end)
      :use_key("<")
      :with_del(cond.done())
      :with_move(cond.done())
    ,

    Rule("<", ">", "rust")
      :with_pair(function(opts)
        return rust_angle_pairing(opts.line) == ">"
      end)
      :use_key("<")
      :with_del(cond.done())
      :with_move(cond.done())
    ,

    Rule("<", ">", "typescript")
      :with_pair(function(opts)
        return regular_angle_pairing(opts.line) == ">"
      end)
      :use_key("<")
      :with_del(cond.done())
      :with_move(cond.done())
    ,

    Rule("{", "}", "rust")
      :with_pair(function(opts)
        return rust_curly_pairing(opts.line) == "}"
      end)
      :use_key("{")
      :with_del(cond.done())
      :with_move(cond.done())
    ,

    Rule("{", "};", "rust")
      :with_pair(function(opts)
        return rust_curly_pairing(opts.line) == "};"
      end)
      :use_key("{")
      :with_del(cond.done())
      :with_move(cond.done())
    ,

    Rule("'", "", "rust")
      :use_key("'")
      :with_del(cond.none())
      :with_move(cond.none())
    ,

    Rule("|", "|", "rust")
      :use_key("|")
      :with_del(cond.done())
      :with_move(cond.done())
    ,

    Rule("$", "$", {"typst", "markdown"})
      :use_key("$")
      :with_del(cond.done())
      :with_move(cond.done()),

    Rule("```", "```", "typst")
      :use_key("`")
      :with_del(cond.done())
      :with_move(cond.done())
    ,
    Rule("`", "`", "markdown")
      :use_key("`")
      :with_del(cond.done())
      :with_move(cond.done())
  })

  -- add rules for add space between brackets.
  local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
  ap.add_rules {
    -- Rule for a pair with left-side ' ' and right side ' '
    Rule(' ', ' ')
      :with_pair(cond.done())
      :replace_endpair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          if vim.tbl_contains({ "()", "{}", "[]" }, pair) then
              return " " -- it return space here
          end
          return ""-- return empty
      end)
      -- Pair will only occur if the conditional function returns true
      -- :with_pair(function(opts)
      --   -- We are checking if we are inserting a space in (), [], or {}
      --   local pair = opts.line:sub(opts.col - 1, opts.col)
      --   return vim.tbl_contains({
      --     brackets[1][1] .. brackets[1][2],
      --     brackets[2][1] .. brackets[2][2],
      --     brackets[3][1] .. brackets[3][2]
      --   }, pair)
      -- end)
      :with_move(cond.done())
      :with_cr(cond.none())
      -- We only want to delete the pair of spaces when the cursor is as such: ( | )
      :with_del(function(opts)
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local context = opts.line:sub(col - 1, col + 2)
        return vim.tbl_contains({
          brackets[1][1] .. '  ' .. brackets[1][2],
          brackets[2][1] .. '  ' .. brackets[2][2],
          brackets[3][1] .. '  ' .. brackets[3][2]
        }, context)
      end)
  }
  -- For each pair of brackets we will add another rule
  for _, bracket in pairs(brackets) do
    ap.add_rules {
      -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
      Rule(bracket[1] .. ' ', ' ' .. bracket[2])
        :with_pair(cond.none())
        :with_move(function(opts) return opts.char == bracket[2] end)
        :with_del(cond.none())
        :use_key(bracket[2])
        -- Removes the trailing whitespace that can occur without this
        :replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
    }
  end
  --
  -- add rule for html files
  ap.add_rules({
    Rule(">", "", {"html", "vue"})
      :use_key(">")
      :replace_endpair(function(opts)
        local before = opts.line:sub(1, vim.fn.col(".")-1)
        if before:match(".*<(.*)/%s*$") then
          return ""
        end

        local _, _, tag = before:find(".*<(%S+)[^<]*$")
        if tag ~= nil then
          return string.format("</%s>", tag)
        else
          return ""
        end
      end)
      :with_del(cond.done())
      :with_move(cond.done())
  })

  -- vim.keymap.set("i", " ", add_space_between, opts("add space between brackets"))
end

return M
