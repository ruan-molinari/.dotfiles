-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    requires = {'nvim-lua/plenary.nvim'}
  }

  -- harpoon allows you to select a few files in a projec to be accessed by a keybind
  -- useful when working with more than one file at the same time
  use {
    'theprimeagen/harpoon',
    requires = {'nvim-lua/plenary.nvim'}
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  }
  -- Lualine - Status line written in lua
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Support for beancount files
  use 'nathangrigg/vim-beancount'

  -- Gruvbox theme  ## check out ./theme.lua for theme configs ##
  use { 'sainnhe/gruvbox-material' }

  -- LSP (Language Service Provider) - provides support to various programming languages and file formats.
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      {'jose-elias-alvarez/null-ls.nvim'},
      {'MunifTanjim/eslint.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

  -- Rust tools - using it mostly for inlay hints of variables types
  -- has debugging utilities too, check https://github.com/simrat39/rust-tools.nvim for setup instructions
  use 'simrat39/rust-tools.nvim'
end)
