return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = true,
	config = function()
		require("neo-tree").setup({
			window = {
				position = "current",
				-- use popup to set width for floating window
				popup = {
					size = {
						width = 35,
					},
				},
				mappings = {
					["h"] = "close_node",
					["l"] = "open",
				},
			},
			default_component_configs = {
				git_status = {
					symbols = {
						added = "N",
						modified = "M",
						deleted = "D",
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
		})
	end,
}
