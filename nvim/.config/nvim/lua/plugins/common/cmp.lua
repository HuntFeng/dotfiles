return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
		},
	},
	event = "InsertEnter",
	config = function()
		-- define keymaps for autocomplete
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } }) -- load custom snippets
		require("luasnip.loaders.from_vscode").lazy_load() -- load friendly-snippets
		local cmp = require("cmp")
		cmp.setup({
			window = {
				completion = cmp.config.window.bordered({ border = "single" }),
				documentation = cmp.config.window.bordered({ border = "single" }),
			},
			mapping = {
				["<cr>"] = cmp.mapping.confirm({ select = false }),
				["<esc>"] = cmp.mapping.abort(),
				["<Up>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
				["<Down>"] = cmp.mapping.select_next_item({ behavior = "select" }),
				["<Tab>"] = cmp.mapping.select_next_item({ behavior = "select" }),
				["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			},
			snippet = {
				-- required - must specify a snippet engine
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = function(entry, vim_item)
					vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
					-- in rust, if we don't set menu to "", it shows up as long white spaces
					vim_item.menu = ""
					return vim_item
				end,
			},
			experimental = {
				ghost_text = true,
			},
		})
	end,
}
