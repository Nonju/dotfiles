--[[
  ---- PLUGIN TODOs ----
   - Highlight anchortags in different colors (same as https://marketplace.visualstudio.com/items?itemName=ExodiusStudios.comment-anchors)
      - Run highlight on buf BufRead (File entry)
      - Run highlighting on save (or on stopped editing?) to catch new anchortags
   - Add setting for enabling/disabling highlighting
   - Adding settings for changing highlight colors to others than the default
   - Add function for scraping tags for listing and being able to quick jump to them

   - (BONUS POINTS) See how this plugin can be loaded from git repo
]]

local SETTING_NAME = "anchortags_enabled"
local COLORS = {
	FIXME = "#B81A1A",
	TODO = "#6495ED",
	NOTE = "#FCBA03",
	REVIEW = "#00FF00",
	SECTION = "#1D8D91",
	ENDSECTION = "#1D8D91",
}

local function setupplugin()
	-- print("Running anchortags plugin setup") -- TODO - Remove
	-- vim.g.anchortags_enabled = true
	if not vim.fn.exists(SETTING_NAME) then
		print("Anchortag setting didn't exist -> creating it")
		vim.api.nvim_set_var(SETTING_NAME, true)
	end
end
-- setupplugin()

function ANCHORTAGS_enable()
	vim.api.nvim_set_var(SETTING_NAME, true)
	for anchor, color in pairs(COLORS) do
		-- print(string.format("Setting up matching for anchor: %s", anchor))
		vim.cmd(string.format("highlight ANCHORTAGS_%s guifg=%s gui=bold", anchor, color))
		vim.fn.matchadd(string.format("ANCHORTAGS_%s", anchor), anchor)
	end
end

function ANCHORTAGS_disable()
	vim.api.nvim_set_var(SETTING_NAME, false)
	-- FIXME - Does not clear colors nor reset bolding
	for anchor, _ in pairs(COLORS) do
		vim.cmd(string.format("highlight clear %s", anchor))
	end
end

local function setuphighlight()
	setupplugin()
	-- local plugin_enabled = vim.api.nvim_get_var(SETTING_NAME) -- FIXME -> Throws Error, not sure why!?
	local plugin_enabled = vim.g[SETTING_NAME]
	-- print(">>> ANCHORTAG SETTING STATUS: " .. (plugin_enabled and "ENABLED" or "DISABLED"))
	-- print("Setting up anchortag highlighting") -- NOTE - this can be removed after dev

	-- REVIEW - Is this necessary to do for each buffer? Does it matter?
	ANCHORTAGS_enable()
end

vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "*.js", "*.ts", "*.c", "*.cpp", "*.cc", "*.h", "*.py", "*.cs", "*.go", "*.lua", "*.java" },
	callback = setuphighlight,
})
