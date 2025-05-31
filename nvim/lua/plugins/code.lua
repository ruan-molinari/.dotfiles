return {
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufEnter" },
		opts = { "*" },
		init = function()
			vim.api.nvim_create_autocmd("BufEnter", {
				callback = function()
					vim.cmd("ColorizerAttachToBuffer")
				end,
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			padding = true,

			opleader = {
				line = "<leader>;l",
				block = "<leader>;b",
			},
		},
	},
	{
		"elkowar/yuck.vim",
	},
}
