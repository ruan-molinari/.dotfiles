local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local ensure_installed = {
	"ts_ls",
	"eslint",
	-- 'rust_analyzer', -- rust-tools is setting it already
	"angularls",
	"lua_ls",
	"jsonls",
	"cssls",
	"cssmodules_ls",
	"html",
	"pylsp",
	"svelte",
	"zls",
	"ols",
	"gopls",
	--'htmx',
	"templ",
}

return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				window = {
					completion = cmp.config.window.bordered(),
				},

				formatting = lsp_zero.cmp_format(),
				mapping = cmp.mapping.preset.insert({
					["<C-S-j>"] = cmp.mapping.scroll_docs(-4),
					["<C-S-k>"] = cmp.mapping.scroll_docs(4),
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),

					-- ['Tab'] = nil,
					-- ['S-Tab'] = nil,
					["<Tab>"] = cmp.mapping(function(fallback)
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-k>"] = nil,
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),

				-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
				cmp.setup.cmdline({ "/", "?" }, {
					mapping = cmp.mapping.preset.cmdline(),
					sources = {
						{ name = "buffer" },
					},
				}),

				-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
				cmp.setup.cmdline(":", {
					-- mapping = cmp.mapping.preset.cmdline(),
					mapping = {
						["<Tab>"] = {
							c = function()
								local char = vim.fn.nr2char(vim.opt.wildchar:get())
								local key = vim.api.nvim_replace_termcodes(char, true, false, true)
								vim.api.nvim_feedkeys(key, "nt", true)
							end,
						},
					},
					sources = cmp.config.sources({
						{ name = "path" },
					}, {
						{ name = "cmdline" },
					}),
				}),
			})
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{
				"williamboman/mason.nvim",
				lazy = false,
				config = true,
			},
			{ "williamboman/mason-lspconfig.nvim" },
			{ "MunifTanjim/eslint.nvim" },
			{ "LhKipp/nvim-nu", cmd = { "TSInstall nu" } },
			{
				"mrcjkb/rustaceanvim",
				version = "^4",
				ft = { "rust" },
			},
			{
				"NTBBloodbath/zig-tools.nvim",
				ft = { "zig", "zon" },
				config = function()
					require("zig-tools").setup()
				end,
				dependencies = {
					"akinsho/toggleterm.nvim",
					config = function()
						require("toggleterm").setup()
					end,
				},
			},
		},
		keys = function()
			local buf = vim.lsp.buf

			return {
				{ "K", buf.hover, desc = "Displays a floating window with info about symbol under cursor" },
			}
		end,
		config = function()
			-- This is where all the LSP shenanigans will live
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			--- if you want to know more about lsp-zero and mason.nvim
			--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
			lsp_zero.on_attach(function(_, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
				handlers = {
					lsp_zero.default_setup,

					ols = function()
						local lspconfig = require("lspconfig")

						lspconfig.ols.setup({
							cmd = { "ols" },
							filetypes = { "odin" },
							single_file_support = true,
							enable_inlay_hints = true,
						})
					end,

					-- lua_ls
					lua_ls = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup({
							settings = {
								Lua = {
									runtime = {
										version = "LuaJIT",
									},
									diagnostics = {
										globals = {
											"vim",
											"require",
										},
									},
									workspace = {
										library = vim.api.nvim_get_runtime_file("", true),
									},
									telemetry = {},
									--globals = { "vim" },
								},
							},
						})
					end,

					html = function()
						local lspconfig = require("lspconfig")
						local html_opts = {
							filetypes = { "html", "templ" },
						}
						lspconfig.html.setup(html_opts)
					end,

					-- eslint
					eslint = function()
						local opts = {
							bin = "eslint", -- or `eslint_d`
							code_actions = {
								enable = true,
								apply_on_save = {
									enable = true,
									types = { "directive", "problem", "suggestion", "layout" },
								},
								disable_rule_comment = {
									enable = true,
									location = "separate_line", -- or `same_line`
								},
							},
							diagnostics = {
								enable = true,
								report_unused_disable_directives = false,
								run_on = "type", -- or `save`
							},
						}
						require("eslint").setup(opts)
					end,

					-- Rust Analyzer configuration
					rust_analyzer = function()
						vim.g.rustaceanvim = {
							tools = { -- rust-tools options
								inlay_hints = {
									only_current_line = true,
								},
							},

							-- all the opts to send to nvim-lspconfig
							-- these override the defaults set by rust-tools.nvim
							-- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
							server = {
								--cmd = { '/Users/ruan/.rustup/toolchains/stable-aarch64-apple-darwin/bin/rust-analyzer' },
								-- standalone file support
								-- setting it to false may improve startup time
								standalone = true,

								-- disabling unresolved proc-macro not expanded warnings
								diagnostics = {
									disabled = {
										"unresolved-proc-macro",
									},
								},
							}, -- rust-analyzer options
						}
					end,
				},
			})
		end,
	},

	-- Formatting
	--[[ {
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")

			-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			-- 	pattern = { "*" },
			-- 	callback = function(args)
			-- 		conform.format({ bufnr = args.buf })
			-- 	end,
			-- })

			conform.setup({
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "conform" },
					typescript = { "conform" },
					go = { "gofumpt", "gofmt" },
				},
			})
		end,
	}, ]]
}
