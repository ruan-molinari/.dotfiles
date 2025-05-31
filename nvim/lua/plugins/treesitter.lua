return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    init = function ()
      vim.filetype.add({
        extension = {
          templ = "templ",
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
      ensure_installed = {
        "javascript",
        "typescript",
        "angular",
        "c",
        "cpp",
        "lua",
        "rust",
        "json",
        "python",
        "html",
        "go",
        "nu",
        "templ",
        "norg",
        "vim",
        "vimdoc",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Autotags
  {
    'windwp/nvim-ts-autotag',
    opts = {}
  },
}
