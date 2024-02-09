return {
  'nvim-telescope/telescope.nvim', tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = function ()
    local builtin = require("telescope.builtin")
    return {
      {"<leader>tf", builtin.find_files, {}},
      {"<C-p>", builtin.git_files, {}},
      {"<leader>ts", function ()
        builtin.grep_string({ search = vim.fn.input("Grep > ") });
      end, {}}
    }
  end,
--  opts = function (_, opts)
--    local builtin = require("telescope.builtin")
--
--    opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
--      mappings = {
--        n = {
--
--        }
--      }
--    })
--  end,
}
     -- 

