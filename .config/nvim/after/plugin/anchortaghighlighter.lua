--[[
  ---- PLUGIN TODOs ----
   - Highlight anchortags in different colors (same as https://marketplace.visualstudio.com/items?itemName=ExodiusStudios.comment-anchors)
      - Run highlight on buf BufRead (File entry)
      - Run highlighting on save (or on stopped editing?) to catch new anchortags
   - Add setting for enabling/disabling highlighting
   - Adding settings for changing highlight colors to others than the default

   - (BONUS POINTS) See how this plugin can be loaded from git repo
]]

local COLORS = {
	FIXME = "#B81A1A",
	TODO = "#6495ED",
	NOTE = "#FCBA03",
	REVIEW = "#00FF00",
	SECTION = "#1D8D91",
}

local function setuphighlight()
	print("Setting up anchortag highlighting") -- NOTE - this can be removed after dev

	-- REVIEW - Is this necessary to do for each buffer? Does it matter?
	for anchor, color in pairs(COLORS) do
		-- print(string.format("Setting up matching for anchor: %s", anchor))
		vim.cmd(string.format("highlight ANCHORTAGS_%s guifg=%s gui=bold", anchor, color))
		vim.fn.matchadd(string.format("ANCHORTAGS_%s", anchor), anchor)
	end
end

vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "*.js", "*.ts", "*.c", "*.cpp", "*.cc", "*.h", "*.py", "*.cs", "*.go", "*.lua", "*.java" },
	callback = setuphighlight,
})
