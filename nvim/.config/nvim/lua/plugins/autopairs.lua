return {
  { 'windwp/nvim-ts-autotag' },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function ()
      -- Custom Rules
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      -- Before   Insert   After
      ----------------------------
      -- (|) 	    space    ( | )
      --
      -- ( | )    )        (  )|
      ----------------------------
      npairs.setup()
      npairs.add_rules({
        -- Add spaces between parenthesis
        Rule(' ', ' '):with_pair(function(opts)
          local pairs_single_char = { '()', '[]', '{}' }
          local pairs_double_char = { '/**/' }
          if vim.bo[opts.bufnr].ft == 'markdown' and opts.line:match('^- ') then
            pairs_single_char = { '()', '{}' }
          end
          return vim.tbl_contains(
            pairs_single_char,
            opts.line:sub(opts.col - 1, opts.col)
          ) or vim.tbl_contains(
              pairs_double_char,
              opts.line:sub(opts.col - 2, opts.col + 1)
            )
        end):with_del(function(opts)
            return vim.fn.match(
              opts.line:sub(1, opts.col):reverse(),
              [[\s\((\|[\|{\|\*\/\)]]
            ) == 0
          end),
      })
    end,
    opts = {
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
  },
}

