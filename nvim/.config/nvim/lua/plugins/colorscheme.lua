return {
  {
    'morhetz/gruvbox',
    --'talha-akram/noctis.nvim',
    lazy = false,
    priority = 1000,
    config = function ()
      vim.cmd.colorscheme 'gruvbox'
    end
  }
}
