return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
		event = "VeryLazy",
		config = function()
			require("nvim-dap-virtual-text").setup()
			local dap, dapui = require("dap"), require("dapui")
			vim.cmd("hi DapBreakpointColor guifg=#fa4848")
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "", texthl = "DapBreakpointColor", linehl = "", numhl = "" }
			)

			vim.cmd("hi DapStopped guifg=#fa4848")
			vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "Visual", numhl = "" })
			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "stacks", size = 0.3 },
							{ id = "watches", size = 0.3 },
							{ id = "repl", size = 0.4 },
						},
						size = 12,
						position = "bottom",
					},
				},
			})
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<leader>dt", function()
				dapui.toggle()
			end, { desc = "Toggle DAP UI" })
			vim.keymap.set("n", "E", function()
				dapui.eval()
			end, { desc = "DAP Eval" })

			vim.keymap.set("n", "<leader>db", function()
				dap.toggle_breakpoint()
			end, { desc = "Dap Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dC", function()
				dap.clear_breakpoints()
			end, { desc = "Dap Clear Breakpoints" })
			vim.keymap.set("n", "<leader>di", function()
				dap.step_into()
			end, { desc = "Dap Step Into" })
			vim.keymap.set("n", "<leader>do", function()
				dap.step_out()
			end, { desc = "Dap Step Out" })
			vim.keymap.set("n", "<leader>dn", function()
				dap.step_over()
			end, { desc = "Dap Step Over" })
			vim.keymap.set("n", "<leader>dc", function()
				dap.continue()
			end, { desc = "Dap Continue" })
			vim.keymap.set("n", "<leader>ds", function()
				dap.stop()
			end, { desc = "Dap Stop" })

			dap.adapters.gdb = {
				id = "gdb",
				type = "executable",
				command = "gdb",
				args = { "--quiet", "--interpreter=dap" },
			}

			dap.configurations.c = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
			}

			dap.configurations.cpp = dap.configurations.c
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			ensure_installed = {},
			handlers = {},
		},
	},
}
