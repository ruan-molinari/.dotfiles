return {
  {
    'norcalli/nvim-colorizer.lua',
    event = { "BufEnter" },
    opts = { '*' },
    init = function ()
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          vim.cmd("ColorizerAttachToBuffer")
        end
      })
    end,
  }
}
