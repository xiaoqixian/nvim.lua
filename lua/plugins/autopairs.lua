local M = {}
local opts = require("utils").keymap_opts
local echoerr = require("utils").echoerr

local function add_space_between()
  local col = vim.fn.col(".")
  local line = vim.api.nvim_get_current_line()

  vim.api.nvim_put({" "}, "c", false, true)

  if col == 1 then
    return
  end

  local sub = line:sub(col-1, col)

  local brackets = { "{}", "()", "[]"}
  for _, b in ipairs(brackets) do
    if sub == b then
      vim.api.nvim_put({" "}, "c", false, false)
    end
  end

end

function M.init()
  local ap = require("nvim-autopairs")
  local Rule = require("nvim-autopairs.rule")
  local cond = require("nvim-autopairs.conds")
  local utils = require("nvim-autopairs.utils")

  ap.setup({
    enable_abbr = true
  })
  
  ap.get_rules("{")[1].not_filetypes = { "cpp", "c" }
  
  ap.add_rules({
    Rule("{", "}", "c")
      :replace_endpair(function(opts)
        local keywords = { "struct", "enum", "union" }
        for _, kw in ipairs(keywords) do
          if opts.line:match("^%s*" .. kw .. ".*") then
            return "};"
          end
        end
        return "}"
      end)
      :use_key("{")
      :with_del(cond.done())
      :with_move(cond.done()),

    Rule("{", "}", "cpp")
      :replace_endpair(function(opts)
        -- autopairing for cpp namespace comments
        local _, _, ns = opts.line:find("^%s*namespace (%S+)")
        if ns then
          return "} // namespace " .. ns
        end

        local keywords = { "class", "struct", "enum", "union", "concept" }
        for _, kw in ipairs(keywords) do
          if opts.line:match("^%s*" .. kw .. ".*") then
            return "};"
          end
        end
        return "}"
      end)
      :use_key("{")
      :with_del(cond.done())
      :with_move(cond.done())
    ,

    Rule("<", ">", "cpp")
      :replace_endpair(function(opts) 
        local col = vim.fn.col(".")
        local before = opts.line:sub(1, col-1)

        if before:match(".*template%s*") then
          return ">"
        elseif before:match(".*operator<*$") then
          return ""
        -- to avoid auto-pairing < and << symbols.
        elseif before:match("%s+<*$") then
          return ""
        else 
          return ">"
        end
      end)
      :use_key("<")
      :with_del(cond.done())
      :with_move(function(opts)
        local col = vim.fn.col(".")
        local next_char = opts.line:sub(col, col)
        if next_char == ">" then
          return true
        else return false
        end
      end)
      ,

    Rule("<", ">", "rust")
      :replace_endpair(function(opts)
        local col = vim.fn.col(".")
        local before = opts.line:sub(1, col)

        if before:match("%s+$") then
          return ""
        else 
          return ">"
        end
      end)
      :use_key("<")
      :with_del(cond.done())
      :with_move(function(opts)
        local col = vim.fn.col(".")
        local next_char = opts.line:sub(col, col)
        if next_char == ">" then
          return true
        else return false
        end
      end),

    Rule("$", "$", "typst")
      :use_key("$")
      :with_del(cond.done())
      :with_move(cond.done()),

    Rule("```", "```", "typst")
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
    Rule(">", "", "html")
      :use_key(">")
      :replace_endpair(function(opts)
        local before = opts.line:sub(1, vim.fn.col(".")-1)
        if before:match(".*<(.*)/%s*$") then
          return ""
        end

        local _, _, tag = before:find(".*<(%S+)[^<]*$")
        assert(tag)
        -- vim.cmd(string.format("echoerr '%s'", tag))
        return string.format("</%s>", tag)
      end)
      :with_del(cond.done())
      :with_move(cond.done())
  })

  -- vim.keymap.set("i", " ", add_space_between, opts("add space between brackets"))
end

return M
