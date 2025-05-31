local function input_sync(opts)
	local co = coroutine.running()
	vim.ui.input(opts, function(result)
		vim.schedule(function()
			coroutine.resume(co, result)
		end)
	end)
	return coroutine.yield()
end

local function select_sync(list, opts)
	local co = coroutine.running()
	vim.ui.select(list, opts, function(result)
		vim.schedule(function()
			coroutine.resume(co, result)
		end)
	end)
	return coroutine.yield()
end

local function pick_program()
	local dap = require("dap")

	local result = input_sync({
		prompt = "Path to executable (compiled with -debug!): ",
		default = vim.fn.getcwd() .. "/",
		completion = "file",
	})

	if result == nil or result == "" or result:sub(-1) == "/" then
		return dap.ABORT
	end

	return result
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui", -- Adds a UI to the debugger.
			"theHamsta/nvim-dap-virtual-text", -- Shows information from the debugging session next to code as virtual text.
			"nvim-neotest/nvim-nio",

			"mxsdev/nvim-dap-vscode-js", -- JS debugging capabilities
			"microsoft/vscode-js-debug",
		},
		keys = {
			{
				"<leader>bo",
				function()
					require("dapui").toggle()
				end,
			},
			{ "<leader>bc", ":DapContinue<cr>" },
			{ "<leader>bb", ":DapToggleBreakpoint<cr>" },
			{
				"<leader>bB",
				function()
					require("dap").toggle_breapoint(vim.fn.input("[DAP] Condition > "))
				end,
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local daputil = require("dap.utils")

			require("nvim-dap-virtual-text").setup({})

			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				vim.keymap.set("n", "<Right>", dap.step_over)
				vim.keymap.set("n", "<Up>", dap.step_out)
				vim.keymap.set("n", "<Down>", dap.step_into)

				dapui.open({})
			end

			dap.listeners.before.event_terminated["dapui_config"] = function()
				pcall(vim.keymap.del, "n", "<Right>")
				pcall(vim.keymap.del, "n", "<Up>")
				pcall(vim.keymap.del, "n", "<Down>")

				dapui.close({})
			end

			dap.listeners.before.event_exited["dapui_config"] = function()
				pcall(vim.keymap.del, "n", "<Right>")
				pcall(vim.keymap.del, "n", "<Up>")
				pcall(vim.keymap.del, "n", "<Down>")

				dapui.close({})
			end

			dap.adapters.lldb = {
				type = "executable",
				command = "/opt/homebrew/opt/llvm/bin/lldb-dap",
				name = "lldb",
			}

			local lldb_default_config = {
				-- Launch a process and debug it.
				{
					name = "Launch & Debug",
					type = "lldb",
					request = "launch",
					program = pick_program,
					stopOnEntry = false,
					cwd = vim.fn.getcwd(),
					args = {},
					args = function()
						local result = input_sync({
							prompt = "program arguments: ",
						})

						if result == nil then
							return dap.ABORT
						end

						return vim.split(result, " ")
					end,
				},
			}

			dap.configurations.odin = lldb_default_config
			dap.configurations.zig = lldb_default_config
			dap.configurations.cpp = lldb_default_config
			dap.configurations.c = lldb_default_config

			-- Javascript
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = {
					"chrome",
					"pwa-node",
					"pwa-chrome",
					"pwa-msedge",
					"node-terminal",
					"pwa-extensionHost",
					"node",
					"chrome",
				},
			})

			local js_based_languages = { "typescript", "javascript", "typescriptreact" }

			for _, language in ipairs(js_based_languages) do
				dap.configurations[language] = {
					{
						type = "node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "node-terminal",
						request = "attach",
						name = "Attach",
						processId = daputil.pick_process,
						-- processId = function()
						-- 	local result = input_sync({
						-- 		prompt = "Node PID: ",
						-- 	})
						--
						-- 	if result == nil then
						-- 		return dap.ABORT
						-- 	end
						--
						-- 	return vim.split(result, " ")
						-- end,
						cwd = "${workspaceFolder}",
					},
					{
						type = "chrome",
						request = "launch",
						name = 'Start Chrome with "localhost"',
						url = "http://localhost:3000",
						webRoot = "${workspaceFolder}",
						userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
					},
				}
			end
		end,
	},
}
