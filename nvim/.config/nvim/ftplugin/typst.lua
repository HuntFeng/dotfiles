vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.typ",
	callback = function()
		local file = vim.fn.expand("%")
		vim.fn.system("typstyle -i " .. file)
		-- refresh the buffer if the file has been modified externally
		vim.cmd("checktime")
	end,
})

vim.api.nvim_create_user_command("TypstPin", function()
	local tinymist_id = nil
	for _, client in pairs(vim.lsp.get_clients()) do
		if client.name == "tinymist" then
			tinymist_id = client.id
			break
		end
	end

	if not tinymist_id then
		vim.notify("tinymist not running!", vim.log.levels.ERROR)
		return
	end

	local client = vim.lsp.get_client_by_id(tinymist_id)
	if client then
		client.request("workspace/executeCommand", {
			command = "tinymist.pinMain",
			arguments = { vim.api.nvim_buf_get_name(0) },
		}, function(err)
			if err then
				vim.notify("error pinning: " .. err, vim.log.levels.ERROR)
			else
				vim.notify("succesfully pinned", vim.log.levels.INFO)
			end
		end, 0)
	end
end, {})
