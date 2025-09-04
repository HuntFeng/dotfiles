return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>L", "<cmd>Lazy<cr>", desc = "Lazy" },
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true })
				end,
				desc = "Neotree Toggle",
			},
			{ "<leader>f", group = "Fuzzy Find" },
			{
				"<leader>fF",
				function()
					require("telescope.builtin").find_files({ no_ignore = true })
				end,
				desc = "Find All Files",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Find Buffers",
			},
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files({ file_ignore_patterns = { "^public/" } })
				end,
				desc = "Find Files",
			},
			{
				"<leader>fw",
				function()
					require("telescope.builtin").live_grep({ file_ignore_patterns = { "^public/", "%.lock" } })
				end,
				desc = "Live Grep",
			},
			{
				"<leader>fs",
				function()
					require("telescope.builtin").lsp_document_symbols()
				end,
				desc = "LSP Document Symbols",
			},
			{
				"<leader>fS",
				function()
					require("telescope.builtin").lsp_workspace_symbols()
				end,
				desc = "LSP Workspace Symbols",
			},
			{
				"<leader>fi",
				function()
					require("telescope.builtin").lsp_incoming_calls()
				end,
				desc = "LSP Incoming Calls",
			},
			{
				"<leader>fr",
				function()
					require("telescope.builtin").lsp_references()
				end,
				desc = "LSP References",
			},
			{ "<leader>l", group = "LSP" },
			{
				"<leader>lR",
				function()
					vim.lsp.buf.rename()
				end,
				desc = "LSP Rename",
			},
			{
				"<leader>la",
				function()
					vim.lsp.buf.code_action()
				end,
				desc = "LSP Action",
			},
			{
				"<leader>ld",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>lf",
				function()
					vim.lsp.buf.format()
				end,
				desc = "Format Code",
			},
			{
				"<leader>li",
				function()
					vim.lsp.buf.incoming_calls()
				end,
				desc = "LSP Incoming Calls",
			},
			{
				"<leader>lr",
				function()
					vim.lsp.buf.references()
				end,
				desc = "LSP References",
			},
			{ "<leader>lI", "<cmd>LspInfo<cr>", desc = "LSP Info" },
			{ "<leader>ll", "<cmd>LspLog<cr>", desc = "LSP Log" },
			{
				"<leader>lR",
				function()
					vim.lsp.buf.rename()
				end,
				desc = "Rename Symbol",
			},
			{ "<leader>w", "<cmd>w<cr>", desc = "Save File" },
			{ "<localleader>l", "VimTex", group = "VimTex" },
			{ "<leader>n", group = "neogen" },
			{
				"<leader>nf",
				function()
					require("neogen").generate({ type = "func" })
				end,
				desc = "Function Doc String",
			},
			{
				"<leader>nc",
				function()
					require("neogen").generate({ type = "class" })
				end,
				desc = "Class Doc String",
			},
			{
				"<leader>nt",
				function()
					require("neogen").generate({ type = "type" })
				end,
				desc = "Type Doc String",
			},
			{
				"<leader>nm",
				function()
					require("neogen").generate({ type = "file" })
				end,
				desc = "Module/File Doc String",
			},
		})
	end,
}
