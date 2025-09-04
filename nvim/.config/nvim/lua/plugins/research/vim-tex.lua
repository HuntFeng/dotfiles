-- need to do pip3 install neovim-remote in order to use nvr
return {
	"lervag/vimtex",
	init = function()
		vim.g.vimtex_compiler_method = "tectonic"
		vim.g.vimtex_compiler_tectonic = {
			executable = "tectonic",
			callback = 1,
			options = {
				"--synctex",
			},
		}
		vim.g.vimtex_quickfix_open_on_warning = 0
		vim.g.vimtex_view_general_viewer = "sioyek"
		-- %1: file, %2: line number
		local options = string.format(
			'--inverse-search="nvr --servername %s +%%2 %%1" --forward-search-file @tex --forward-search-line @line @pdf',
			vim.v.servername
		)
		vim.g.vimtex_view_general_options = options
	end,
	config = function()
		vim.api.nvim_create_autocmd("BufWrite", {
			callback = function()
				local method = vim.g.vimtex_compiler_method
				local filetype = vim.bo.filetype
				if method == "tectonic" and filetype == "tex" then
					vim.cmd("VimtexCompile")
				end
			end,
		})
	end,
	config = function()
		vim.opt.spell = true -- enable spelling check
		vim.opt.spelllang = "en_us"
	end,
	ft = { "tex" },
}
