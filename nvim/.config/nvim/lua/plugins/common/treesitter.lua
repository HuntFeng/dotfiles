return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VeryLazy",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = { "vimdoc", "lua", "python", "javascript", "typescript", "html", "css", "vue" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
