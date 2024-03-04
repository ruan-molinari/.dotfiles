return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  event = { "LazyFile", "VeryLazy" },
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
  opts = {
    -- A list of parser names, or "all"
    ensure_installed = {
      "javascript",
      "typescript",
      "angular",
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
    auto_install = true,

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
  },

  -- Autotags
  {
    'windwp/nvim-ts-autotag',
    opts = {}
  },
}
