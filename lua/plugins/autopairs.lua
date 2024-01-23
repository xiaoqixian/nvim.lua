local M = {}

function M.init()
  local ap = require("nvim-autopairs")
  local Rule = require("nvim-autopairs.rule")
  local cond = require("nvim-autopairs.conds")
  local utils = require("nvim-autopairs.utils")

  ap.setup()
  
  ap.get_rules("{")[1].not_filetypes = { "cpp", "c" }
  
  ap.add_rules({
    Rule("{", "}", "c")
      :replace_endpair(function(opts)
        local keywords = { "struct", "enum" }
        for _, kw in ipairs(keywords) do
          if opts.line:match("^%s*" .. kw .. ".*") then
            return "};"
          end
        end
        return "}"
      end)
      :with_del(cond.done())
      :with_move(cond.done()),

    Rule("{", "}", "cpp")
      :replace_endpair(function(opts)
        local keywords = { "class", "struct", "enum" }
        for _, kw in ipairs(keywords) do
          if opts.line:match("^%s*" .. kw .. ".*") then
            return "};"
          end
        end
        return "}"
      end)
      :with_del(cond.done())
      :with_move(cond.done()),

    Rule("<", ">", "cpp")
      :replace_endpair(function(opts) 
        if opts.line:match(".*template%s*") then
          return ">"
        elseif opts.line:match(".*%s+") then
          return ""
        else 
          return ">"
        end
      end)
      :with_del(cond.done())
      :with_move(cond.done()),

    Rule("<", ">", "rust")
      :replace_endpair(function(opts)
        if opts.line:match(".*%s+") then
          return ""
        else 
          return ">"
        end
      end)
      :with_del(cond.done())
      :with_move(cond.done()),
  })

  -- add rules for add space between brackets.
  local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
  ap.add_rules {
    -- Rule for a pair with left-side ' ' and right side ' '
    Rule(' ', ' ')
      -- Pair will only occur if the conditional function returns true
      :with_pair(function(opts)
        -- We are checking if we are inserting a space in (), [], or {}
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({
          brackets[1][1] .. brackets[1][2],
          brackets[2][1] .. brackets[2][2],
          brackets[3][1] .. brackets[3][2]
        }, pair)
      end)
      :with_move(cond.none())
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
end

return M
