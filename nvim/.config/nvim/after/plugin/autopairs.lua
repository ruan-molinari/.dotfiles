-- Setup nvim-cmp
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

npairs.setup {
  check_ts = true,
  ts_config = {
    lua = { "string", "template_string" },
    javascript = { "string", "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([=[[%'%"%>%]%)%}%,]]=], "$s+", ""),
    offset = 0,
    end_key = "$",
    keys = "qwertyuiopzxcvbbnmasdfghjkl",
    check_comma = "PmenuSel",
    highlight_grey = "LineNr",
  },
}

-- Custom Rules
local Rule = require "nvim-autopairs.rule"

-- Before   Insert   After
----------------------------
-- (|) 	    space    ( | )
--
-- ( | )    )        (  )|
----------------------------
local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({
        brackets[1][1]..brackets[1][2],
        brackets[2][1]..brackets[2][2],
        brackets[3][1]..brackets[3][2],
      }, pair)
    end)
}
for _,bracket in pairs(brackets) do
  npairs.add_rules {
    Rule(bracket[1]..' ', ' '..bracket[2])
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%'..bracket[2]) ~= nil
      end)
      :use_key(bracket[2])
  }
end


-- Before        Input         After
--------------------------------------
-- {|}           <CR>          {
--                                |
--                             }
--------------------------------------
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end
cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
