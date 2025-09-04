return {
	{
		"nvim-flutter/flutter-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		ft = { "dart" },
		opts = {
			lsp = {
				settings = { lineLength = 120 },
			},
			debugger = {
				enabled = true,
			},
			dev_log = {
				enabled = false,
			},
		},
		keys = {
			{ "<leader>Fd", "<cmd>FlutterDebug<cr>", desc = "FlutterDebug" },
			{ "<leader>Fe", "<cmd>FlutterEmulators<cr>", desc = "FlutterEmulators" },
			{ "<leader>Fr", "<cmd>FlutterRestart<cr>", desc = "FlutterRestart" },
			{ "<leader>Fq", "<cmd>FlutterQuit<cr>", desc = "FlutterQuit" },
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-vim-test",
			"huntf-bitstrata/neotest-dart",
		},
		event = "VeryLazy",
		config = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-dart")({ lsp = true }),
				},
			})

			vim.keymap.set("n", "<leader>tr", function()
				neotest.run.run()
			end, { desc = "Run nearest test" })
			vim.keymap.set("n", "<leader>tR", function()
				neotest.run.run(vim.fn.expand("%"))
			end, { desc = "Run tests in current file" })
			vim.keymap.set("n", "<leader>td", function()
				neotest.run.run({ strategy = "dap" })
			end, { desc = "Run nearest test with dap" })
			vim.keymap.set("n", "<leader>ts", ":Neotest summary<CR>", { desc = "Test Summary" })
			vim.keymap.set("n", "<leader>to", ":Neotest output-panel<CR>", { desc = "Test Output (Panel)" })
		end,
	},
}
