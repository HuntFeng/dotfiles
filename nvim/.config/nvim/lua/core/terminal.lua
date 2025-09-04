local term_bufnr = nil
local term_winid = nil
local term_height = 10

local function toggle_terminal()
	if term_bufnr and vim.api.nvim_buf_is_valid(term_bufnr) then
		local wins = vim.api.nvim_list_wins()
		for _, win in ipairs(wins) do
			if vim.api.nvim_win_get_buf(win) == term_bufnr then
				vim.api.nvim_win_close(win, true)
				return
			end
		end
		-- Terminal is hidden: open in a split at bottom
		vim.cmd("botright split")
		vim.cmd("startinsert")
		term_winid = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_buf(0, term_bufnr)
		vim.api.nvim_win_set_height(term_winid, term_height)
	else
		-- Create a new terminal buffer at the bottom
		vim.cmd("botright split")
		vim.cmd("terminal")
		vim.cmd("startinsert")
		vim.api.nvim_win_set_height(0, term_height)
		term_bufnr = vim.api.nvim_get_current_buf()
		term_winid = vim.api.nvim_get_current_win()
		vim.api.nvim_buf_set_option(term_bufnr, "buflisted", false)
	end
end

vim.keymap.set({ "n", "t" }, "<C-/>", toggle_terminal, { desc = "Toggle terminal" })
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
