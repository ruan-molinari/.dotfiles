local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)


require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'eslint',
    -- 'rust_analyzer', -- rust-tools is setting it already
    'beancount',
    'angularls',
    'lua_ls',
    'clangd',
    'jsonls',
    'cssls',
    'cssmodules_ls',
    'html',
    'pylsp',
    'svelte',
  },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function ()
      local opts = {
        settings = {
          Lua = {
            diagnostics = {
              globals = {'vim'}
            }
          }
        }
      }
      require('lspconfig').lua_ls.setup(opts)
    end,
    rust_analyzer = function()
      local rust_tools = require('rust-tools')

      local opts = {
        tools = { -- rust-tools options
          inlay_hints = {
            only_current_line = true
          }
        },

        -- all the opts to send to nvim-lspconfig
        -- these override the defaults set by rust-tools.nvim
        -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
        server = {
          cmd = { '/Users/ruan/.rustup/toolchains/stable-aarch64-apple-darwin/bin/rust-analyzer' },
          -- standalone file support
          -- setting it to false may improve startup time
          standalone = true,
        }, -- rust-analyzer options

        -- debugging stuff
        dap = {
          adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
          },
        },
      }
      rust_tools.setup(opts)

      -- require('lspconfig').rust_analyzer.setup(opts) -- uncomment if rust-tools is not being used
    end
  }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
  },
  -- formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
  }),
})

-- lsp_zero.setup()
--
-- vim.diagnostic.config({
--   virtual_text = true
-- })
