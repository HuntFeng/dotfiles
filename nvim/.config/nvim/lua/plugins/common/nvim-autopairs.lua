return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			npairs.setup({
				-- remove %$ from default so autopairs works normally in $$ in tex file
				ignored_next_char = [=[[%w%%%'%[%"%.%`]]=],
			})
			npairs.add_rules({
				Rule("$", "$", { "tex", "typst" }),
				Rule("\\(", "\\)", "tex"),
				Rule("\\[", "\\]", "tex"),
				Rule("```", "```", "quarto"),
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opt = { enable_close_on_slash = true },
			})
		end,
	},
}
