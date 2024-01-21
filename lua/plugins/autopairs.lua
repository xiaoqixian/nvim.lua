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
end

return M
