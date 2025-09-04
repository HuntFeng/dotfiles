return {
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"sindrets/diffview.nvim",
		lazy = true,
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview" },
			{ "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
		},
	},
}
