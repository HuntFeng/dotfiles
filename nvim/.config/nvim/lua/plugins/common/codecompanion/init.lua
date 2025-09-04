return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"github/copilot.vim",
		"j-hui/fidget.nvim",
	},
	init = function()
		require("plugins.common.codecompanion.fidget-spinner"):init()
	end,
	config = function()
		require("codecompanion").setup({
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "claude-sonnet-4",
							},
						},
					})
				end,
			},
		})
	end,
}
