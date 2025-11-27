local wez = require("wezterm")
---@class bar.wezterm
local M = {}
local options = {
	position = "bottom",
	max_width = 32,
	padding = {
		left = 1,
		right = 1,
		tabs = {
			left = 0,
			right = 2,
		},
	},
	separator = {
		space = 1,
		left_icon = wez.nerdfonts.fa_long_arrow_right,
		right_icon = wez.nerdfonts.fa_long_arrow_left,
		field_icon = wez.nerdfonts.indent_line,
	},
}

---add spaces to each side of a string
---@param s string
---@param space number
---@param trailing_space number | nil
---@return string
local _space = function(s, space, trailing_space)
	if type(s) ~= "string" or type(space) ~= "number" then
		return ""
	end
	local spaces = string.rep(" ", space)
	local trailing_spaces = spaces
	if trailing_space ~= nil then
		trailing_spaces = string.rep(" ", trailing_space)
	end
	return spaces .. s .. trailing_spaces
end

---conforming to https://github.com/wez/wezterm/commit/e4ae8a844d8feaa43e1de34c5cc8b4f07ce525dd
---@param c table: wezterm config object
M.apply_to_config = function(c)
	c.tab_bar_at_bottom = options.position == "bottom"
	c.use_fancy_tab_bar = false
end

wez.on("update-status", function(window, pane)
	local present, conf = pcall(window.effective_config, window)
	if not present then
		return
	end

	local palette = conf.resolved_palette

	-- left status
	local left_cells = {
		{ Background = { Color = palette.tab_bar.background } },
	}

	table.insert(left_cells, { Text = string.rep(" ", options.padding.left) })
	window:set_left_status(wez.format(left_cells))

	-- right status
	local right_cells = {
		{ Background = { Color = palette.tab_bar.background } },
	}

	local callbacks = {
		{
			name = "git",
			color = palette.ansi[6],
			func = function()
				local cwd_uri = pane:get_current_working_dir()
				local cwd = cwd_uri.file_path

				local branch = ""
				local handle = io.popen('git -C "' .. cwd .. '" rev-parse --abbrev-ref HEAD 2>/dev/null')
				if handle then
					branch = handle:read("*l") or ""
					handle:close()
				end

				if branch == "" then
					return ""
				end

				local status = "["
				handle = io.popen('git -C "' .. cwd .. '" status --porcelain | grep "??" | wc -l 2>/dev/null')
				if handle then
					local added = handle:read("*l")
					if tonumber(added) > 0 then
						status = status .. "A:" .. added
					end
					handle:close()
				end
				handle = io.popen('git -C "' .. cwd .. '" status --porcelain | grep "M" | wc -l 2>/dev/null')
				if handle then
					local modified = handle:read("*l")
					if tonumber(modified) > 0 then
						status = status .. " M:" .. modified .. " "
					end
					handle:close()
				end
				handle = io.popen('git -C "' .. cwd .. '" status --porcelain | grep "D" | wc -l 2>/dev/null')
				if handle then
					local deleted = handle:read("*l")
					if tonumber(deleted) > 0 then
						status = status .. "D:" .. deleted
					end
					handle:close()
				end
				status = status .. "]"
				return branch .. " " .. status
			end,
		},
		{
			name = "cwd",
			color = palette.ansi[7],
			func = function()
				local cwd_uri = pane:get_current_working_dir()
				local cwd = cwd_uri.file_path
				local home = (os.getenv("USERPROFILE") or os.getenv("HOME") or wez.home_dir or ""):gsub("\\", "/")
				return cwd:gsub(home .. "(.-)$", "~%1")
			end,
		},
	}

	for _, callback in ipairs(callbacks) do
		local func = callback.func
		local text = func()
		if #text > 0 then
			table.insert(right_cells, { Foreground = { Color = callback.color } })
			table.insert(right_cells, { Text = text })
			table.insert(right_cells, { Text = _space(options.separator.field_icon, options.separator.space, nil) })
		end
	end
	-- remove trailing separator
	table.remove(right_cells, #right_cells)
	table.insert(right_cells, { Text = string.rep(" ", options.padding.right) })

	window:set_right_status(wez.format(right_cells))
end)

return M
