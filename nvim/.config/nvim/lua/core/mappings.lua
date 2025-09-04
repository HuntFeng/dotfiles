vim.g.mapleader = " "
vim.g.maplocalleader = ","
local map = vim.keymap.set

-- better escape
map("i", "jk", "<esc>l", { silent = true })
map("i", "jj", "<esc>l", { silent = true })
-- map("t", "<esc>", [[<C-\><C-n>]])
-- don't use this, the terminal typing experience is not good
-- map("t", "jk", [[<C-\><C-n>]])

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map("n", "[[", "#")
map("n", "]]", "*")

-- Move to window using the <ctrl>+hjkl keys
map({ "n", "t" }, "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window", remap = true })
map({ "n", "t" }, "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window", remap = true })
map({ "n", "t" }, "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window", remap = true })
map({ "n", "t" }, "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window", remap = true })

-- move cursor in insert mode using <ctrl>+hjkl
map("i", "<C-h>", "<Left>", { desc = "Move Cursor Left", remap = true })
map("i", "<C-j>", "<Down>", { desc = "Move Cursor Down", remap = true })
map("i", "<C-k>", "<Up>", { desc = "Move Cursor Up", remap = true })
map("i", "<C-l>", "<Right>", { desc = "Move Cursor Right", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<cr>", function()
	if vim.bo.filetype == "qf" then
		vim.api.nvim_input("<C-cr>")
	else
		vim.cmd("normal! o")
	end
end, { desc = "New line" })

-- buffers
map("n", "H", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "L", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>c", function()
	-- Close current buffer (and switch to alternate if there is any)
	-- but keep the current window open
	local curr_buf = vim.api.nvim_get_current_buf()
	local alt_buf = vim.fn.bufnr("#")
	local active_bufs = vim.tbl_map(function(buf)
		return buf.bufnr
	end, vim.fn.getbufinfo({ buflisted = 1 }))
	local buftype = vim.bo[curr_buf].buftype
	if buftype == "terminal" then
		vim.cmd("bdelete! " .. curr_buf)
	else
		if vim.list_contains(active_bufs, alt_buf) then
			-- if alternate buffer exists, switch to it
			vim.cmd("buffer " .. alt_buf)
			vim.cmd("bdelete " .. curr_buf)
		elseif #active_bufs > 1 then
			-- else if there are other buffers, switch to the first one
			for _, buf in ipairs(active_bufs) do
				if buf ~= curr_buf then
					vim.cmd("buffer " .. buf)
					vim.cmd("bdelete " .. curr_buf)
					return
				end
			end
		else
			-- if this is the last buffer, just create a new empty buffer
			vim.cmd("enew")
			vim.cmd("bdelete " .. curr_buf)
		end
	end
end, { noremap = true, desc = "Close Buffer" })

-- windows
map("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Delete Window", remap = true })
map("n", "<leader>Q", "<cmd>confirm qall<cr>", { desc = "Delete Window", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- wrap
map({ "n", "i", "x", "s" }, "<A-z>", "<cmd>set wrap!<cr>", { desc = "Wrap text" })

-- comment
map("n", "<leader>/", function()
	vim.cmd.normal("gcc")
end, { desc = "Comment", noremap = true })
map("v", "<leader>/", function()
	vim.cmd.normal("gc")
end, { desc = "Comment", noremap = true })
