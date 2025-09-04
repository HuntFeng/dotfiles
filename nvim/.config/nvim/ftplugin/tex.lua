-- remove Function types from the suggestion list as they are unnecessary
-- so that snippets will appear in the suggestion list
local cmp = require("cmp")
local sources = cmp.get_config().sources
for i = #sources, 1, -1 do
	if sources[i].name == "nvim_lsp" then
		sources[i].entry_filter = function(entry, ctx)
			local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
			if kind == "Function" then
				return false
			end
			return true
		end
	end
end
cmp.setup.buffer({ sources = sources })
