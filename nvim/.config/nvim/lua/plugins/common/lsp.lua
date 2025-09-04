return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason").setup({
				ui = {
					border = "single",
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					-- lsps
					"lua_ls",
					"pyright",
					"ts_ls",
					"vue_ls",
					"rust_analyzer",
					"clangd",
					"cmake",
					"tinymist",
					"marksman",
				},
			})

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								checkThirdParty = false,
								library = vim.api.nvim_get_runtime_file("", true),
							},
							telemetry = { enable = false },
							runtime = { version = "LuaJIT" },
						},
					},
				},
				pyright = {},
				ts_ls = {},
				vue_ls = {},
				rust_analyzer = {},
				clangd = {},
				tinymist = {},
				marksman = {},
			}

			for name, config in pairs(servers) do
				vim.lsp.config(name, config)
			end

			-- Keymaps
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
			vim.keymap.set("n", "gs", function()
				vim.lsp.buf.signature_help({ border = "single" })
			end, { desc = "LSP Signature Help" })
			vim.keymap.set("n", "gl", function()
				vim.diagnostic.open_float({ border = "single" })
			end, { desc = "Show Diagnostics" })
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover({ border = "single" })
			end, { desc = "LSP Hover" })
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
			vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, { desc = "Rename Symbol" })
			vim.keymap.set("n", "<leader>lf", function()
				require("conform").format({ async = true, lsp_fallback = true })
			end, { desc = "Format code" })
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				-- Formatters:
				"stylua",
				"black",
				"isort",
				"prettierd",
				"clang-format",
				"cmakelang",
				"typstyle",
				"taplo",
			},
			auto_update = true,
			run_on_start = true,
		},
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms = 1000,
					lsp_fallback = true,
				},
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black", "isort" },
					rust = { "rustfmt" },
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescriptreact = { "prettierd" },
					vue = { "prettierd" },
					css = { "prettierd" },
					html = { "prettierd" },
					json = { "prettierd" },
					yaml = { "prettierd" },
					markdown = { "prettierd" },
					cpp = { "clang_format" },
					c = { "clang_format" },
					typst = { "typstyle" },
					toml = { "taplo" },
				},
				formatters = {
					isort = {
						prepend_args = { "--profile", "black" },
					},
				},
			})
		end,
	},
}
