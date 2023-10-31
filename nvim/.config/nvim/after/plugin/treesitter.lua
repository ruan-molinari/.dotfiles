-- Custom parsers
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'http://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  filetype = { 'org', 'beancount' }
}

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = { "help", "javascript", "typescript", "c", "lua", "rust", "json", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
  -- highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    disable = { "beancount" },
  },

  autopairs = {
    enable = true
  },

  indent = { enable = true, disable = { "yaml" } },
}

