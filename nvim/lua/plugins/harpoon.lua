return {
	"ThePrimeagen/harpoon",
	keys = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		return {
			{
				"<leader>a",
				function()
					mark.add_file()
				end,
				silent = true,
				desc = "Harpoons a file",
			},
			{
				"<C-e>",
				function()
					ui.toggle_quick_menu()
				end,
				silent = true,
				desc = "Toggle harpoon mark list",
			},
			{
				"<C-h>",
				function()
					ui.nav_file(1)
				end,
			},
			{
				"<C-l>",
				function()
					ui.nav_file(2)
				end,
			},
			{
				"<C-j>",
				function()
					ui.nav_file(3)
				end,
			},
			{
				"<C-k>",
				function()
					ui.nav_file(4)
				end,
			},
		}
	end,
}
