return {
	"echasnovski/mini.surround",
	version = false,
	event = "VeryLazy",
	config = function()
		require("mini.surround").setup({
			mappings = {
				add = "sa", -- Add surrounding in Normal and Visual modes
				--e.g. saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
				--e.g. saa}) - [S]urround [A]dd [A]round [}]Braces [)]Paren
				delete = "sd", -- Delete surrounding
				--e.g.    sd"   - [S]urround [D]elete ["]quotes
				replace = "sr", -- Replace surrounding
				--e.g.     sr)'  - [S]urround [R]eplace [)]Paren by [']quote
				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				update_n_lines = "sn", -- Update `n_lines`
			},
			n_lines = 500,
		})
	end,
}
