return {
	"echasnovski/mini.move",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("mini.move").setup({
			mappings = {
				-- Move visual selection in Visual mode.
				left = "<S-h>",
				right = "<S-l>",
				down = "<S-j>",
				up = "<S-k>",
			},
		})
	end,
}
