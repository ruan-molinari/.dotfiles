return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  init = function ()
    vim.filetype.add({
      extension = {
        templ = "templ"
      }
    })
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*.templ",
      callback = function()
        vim.cmd("TSBufEnable highlight")
      end
    })
  end,
  config = function ()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
        -- A list of parser names, or "all"
        ensure_installed = {
          "javascript",
          "typescript",
          "c",
          "lua",
          "rust",
          "json",
          "python",
          "html",
          "go",
          "nu",
          "templ",
          "norg",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        --auto_install = false,

        -- If TS highlights are not enabled at all, or disabled via `disable` prop,
        -- highlighting will fallback to default Vim syntax highlighting
        highlight = {
          enable = true,
          -- Required for spellcheck, some LaTex highlights and
          -- code block highlights that do not have ts grammar
        },

        autopairs = {
          enable = true
        },
        autotag = {
          enable = true,
        },

        indent = { enable = true, disable = { "yaml" } },
    })
  end,
}
