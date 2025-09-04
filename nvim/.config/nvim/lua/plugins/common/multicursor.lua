return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	event = "VeryLazy",
	config = function()
		local mc = require("multicursor-nvim")

		mc.setup()

		local map = vim.keymap.set

		-- Add or skip cursor above/below the main cursor.
		map({ "n", "x" }, "<up>", function()
			mc.lineAddCursor(-1)
		end)
		map({ "n", "x" }, "<down>", function()
			mc.lineAddCursor(1)
		end)

		-- Add or skip adding a new cursor by matching word/selection
		map({ "n", "x" }, "<C-n>", function()
			mc.matchAddCursor(1)
		end)

		-- In normal/visual mode, press `mwap` will create a cursor in every match of
		-- the word captured by `iw` (or visually selected range) inside the bigger
		-- range specified by `ap`. Useful to replace a word inside a function, e.g. mwif.
		map({ "n", "x" }, "mw", function()
			mc.operator({ motion = "iw", visual = true })
			-- Or you can pass a pattern, press `mwi{` will select every \w,
			-- basically every char in a `{ a, b, c, d }`.
			-- mc.operator({ pattern = [[\<\w]] })
		end)

		-- Press `mWi"ap` will create a cursor in every match of string captured by `i"` inside range `ap`.
		map("n", "mW", mc.operator)

		-- Add all matches in the document
		map({ "n", "x" }, "<leader>A", mc.matchAllAddCursors)

		-- Rotate the main cursor.
		map({ "n", "x" }, "<left>", mc.nextCursor)
		map({ "n", "x" }, "<right>", mc.prevCursor)

		map("n", "<esc>", function()
			if not mc.cursorsEnabled() then
				mc.enableCursors()
			elseif mc.hasCursors() then
				mc.clearCursors()
			else
				-- Default <esc>, clear highlight
				vim.cmd("noh")
			end
		end)

		-- Customize how cursors look.
		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { link = "Cursor" })
		hl(0, "MultiCursorVisual", { link = "Visual" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorMatchPreview", { link = "Search" })
		hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
	end,
}
