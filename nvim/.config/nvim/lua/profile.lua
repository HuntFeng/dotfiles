local M = {}
local state_file = vim.fn.stdpath("data") .. "/profile_states.json"

local function load_state()
	local f = io.open(state_file, "r")
	if not f then
		return {}
	end
	local content = f:read("*a")
	f:close()
	return vim.fn.json_decode(content)
end

local function save_state(state)
	local f = io.open(state_file, "w")
	if not f then
		vim.notify("Failed to write profile state file", vim.log.levels.ERROR)
		return
	end
	f:write(vim.fn.json_encode(state))
	f:close()
end

function M.get_current_profile()
	local cwd = vim.fn.getcwd()
	local state = load_state() or "common"
	return state[cwd] or "common"
end

function M.set_profile(profile_name)
	local cwd = vim.fn.getcwd()
	local state = load_state()
	state[cwd] = profile_name
	save_state(state)
	vim.notify("Switched profile to '" .. profile_name .. "' for " .. cwd)
end

return M
