return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
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
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = false,

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

      indent = { enable = true, disable = { "yaml" } },
    }

  }
}

