return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = 'moon'
    },
    config = function (_, opts)
      require'rose-pine'.setup(opts)

      vim.cmd.colorscheme 'rose-pine'
      -- uncomment next line for tranrparency
      -- vim.cmd.highlight 'Normal guibg=none'
    end
  },

}
