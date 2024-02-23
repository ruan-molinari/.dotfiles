local config = function ()
  local telescope = require("telescope")
  telescope.setup({
    defaults = {
      file_ignore_patterns = {
        "/node_modules",
        "/target",
        "/build",
        "/zig-cache",
      },
      mappings = {
        i = {
          ['<C-n>'] = 'move_selection_next',
          ['<C-e>'] = 'move_selection_previous',
        }
      }
    }
  })
end

return {
  'nvim-telescope/telescope.nvim', tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = "Telescope",
  config = config,
  keys = function ()
    local builtin = require("telescope.builtin")
    return {
      {"<leader>tf", builtin.find_files, {}},
      {"<C-p>", builtin.git_files, {}},
      {"<leader>ts", function ()
        builtin.grep_string({ search = vim.fn.input("Grep > ") });
      end, {}},
    }
  end,
}
