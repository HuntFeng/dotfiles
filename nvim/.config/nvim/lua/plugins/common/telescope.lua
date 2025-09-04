return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	lazy = true,
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "filename_first" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
					},
				},
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						preview_cutoff = 0, -- don't cutoff previewer for smaller terminal
					},
				},
			},
		})
	end,
}
