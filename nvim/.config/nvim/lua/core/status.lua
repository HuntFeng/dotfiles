local cmp = {} -- statusline components

--- highlight pattern
-- This has three parts:
-- 1. the highlight group
-- 2. text content
-- 3. special sequence to restore highlight: %*
-- Example pattern: %#SomeHighlight#some-text%*
local hi_pattern = "%%#%s#%s%%*"

function _G._statusline_component(name)
	return cmp[name]()
end

function cmp.position()
	return hi_pattern:format("Search", " %2p%%%3l:%-2c ")
end

function cmp.git_branch()
	local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
	if branch and branch ~= "" and not branch:match("^fatal") then
		return hi_pattern:format("Identifier", "  " .. branch .. " ")
	end
	return ""
end

function cmp.hlcount()
	local ok, sc = pcall(vim.fn.searchcount, { maxcount = 9999, timeout = 50 })
	if not ok or sc.incomplete ~= 0 or sc.total == 0 then
		return ""
	end
	local txt = string.format(" [%d/%d] ", sc.current, sc.total)
	return hi_pattern:format("WarningMsg", txt)
end

function cmp.selection_count()
	local mc = require("multicursor-nvim")
	local count = mc.numCursors()
	if count > 1 then
		local index = 1
		mc.action(function(ctx)
			if ctx == nil then
				return ""
			end
			local cursors = ctx.getCursors()
			for i, cursor in ipairs(cursors) do
				if vim.deep_equal(cursor._pos, ctx.mainCursor()._pos) then
					index = i
				end
			end
		end)
		return hi_pattern:format("Visual", string.format(" MC: [%d/%d] ", index, count))
	else
		return ""
	end
end

local statusline = {

	'%{%v:lua._statusline_component("git_branch")%}', -- git branch
	"%f", -- relative file path
	"%=", -- separator
	'%{%v:hlsearch ? v:lua._statusline_component("hlcount") : ""%}', -- highlight count
	'%{%v:lua._statusline_component("selection_count")%}',
	'%{%v:lua._statusline_component("position")%}', -- cursor position,
}

vim.o.statusline = table.concat(statusline, "")
