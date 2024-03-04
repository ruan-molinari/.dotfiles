return {
  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },

      linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        reactjavascript = { "eslint_d" },
        reacttypescript = { "eslint_d" },
        svelte = { "eslint_d" },
        css = { "stylelint" },
        scss = { "stylelint" },
        sass = { "stylelint" },
        less = { "stylelint" },
        lua = { "luacheck" },
        go = { "golangcilint" },
      }

    },
    config = function (_, opts)
      local lint = require("lint")

      lint.linters_by_ft = opts.linters_by_ft
      vim.api.nvim_create_autocmd(opts.events, {
        pattern = { "*" },
        callback = function()
          lint.try_lint()
        end,
      })
    end,
    keys = {
      { "<leader>ll", function ()
        require("lint").try_lint()
      end,
        {
          desc = "Trigger linting for current file"
        }
      }
    }
  },
}
