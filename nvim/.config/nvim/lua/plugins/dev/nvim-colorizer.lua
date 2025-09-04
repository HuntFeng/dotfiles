return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup()
	end,
	ft = { "html", "vue", "css", "scss", "less", "sass" },
}
