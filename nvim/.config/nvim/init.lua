require("core")
local profile = require("profile")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
local spec = {
	{ import = "plugins.common" },
}
if profile.get_current_profile() == "dev" then
	table.insert(spec, { import = "plugins.dev" })
elseif profile.get_current_profile() == "research" then
	table.insert(spec, { import = "plugins.research" })
end
require("lazy").setup({ spec = spec })

vim.api.nvim_create_user_command("SwitchProfile", function()
	local profiles = { "dev", "research", "common" }
	vim.ui.select(profiles, {
		prompt = "Select a profile",
	}, function(choice)
		if choice then
			profile.set_profile(choice)
			vim.notify("Restart neovim to switch to profile: " .. choice, vim.log.levels.INFO)
		end
	end)
end, {})
