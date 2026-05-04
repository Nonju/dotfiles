--
-- SECTION TESTING
-------------------- Written by ChatGPT. Just testing if it works --------------------------

-- :BlameLine opens a scrollable floating window with full git show output
vim.api.nvim_create_user_command("BlameLine", function()
	local file = vim.fn.expand("%:p")
	local line = vim.fn.line(".")

	-- Get blame for current line
	local blame = vim.fn.system({
		"git",
		"blame",
		"-L",
		string.format("%d,%d", line, line),
		"--",
		file,
	})

	if vim.v.shell_error ~= 0 then
		vim.notify("git blame failed:\n" .. blame, vim.log.levels.ERROR)
		return
	end

	blame = blame:gsub("%s+$", "")

	-- Parse commit hash
	local commit = blame:match("^%^?([0-9a-fA-F]+)")
	if not commit then
		vim.notify("Could not parse commit hash", vim.log.levels.ERROR)
		return
	end

	-- Full commit patch
	local show = vim.fn.system({
		"git",
		"show",
		"--color=never",
		commit,
	})

	if vim.v.shell_error ~= 0 then
		vim.notify("git show failed:\n" .. show, vim.log.levels.ERROR)
		return
	end

	local lines = vim.split(show, "\n", { plain = true })

	-- Create scratch buffer
	local buf = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].filetype = "diff"
	vim.bo[buf].modifiable = false

	-- Floating window size
	local width = math.floor(vim.o.columns * 0.9)
	local height = math.floor(vim.o.lines * 0.85)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		width = width,
		height = height,
		border = "rounded",
		style = "minimal",
		title = " git show " .. commit .. " ",
		title_pos = "center",
	})

	-- Allow normal scrolling/jumping inside window
	vim.wo[win].wrap = false
	vim.wo[win].cursorline = true
	vim.wo[win].number = false
	vim.wo[win].relativenumber = false

	-- q or Esc closes
	local opts = { buffer = buf, nowait = true, silent = true }
	vim.keymap.set("n", "q", "<cmd>close<CR>", opts)
	vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", opts)
	vim.keymap.set("n", "<C-t>", function()
		print("Toggling window size")
		if win and vim.api.nvim_win_is_valid(win) then
			local cfg = vim.api.nvim_win_get_config(win)
			if cfg.width == width then
				cfg.width = width / 2
			else
				cfg.width = width
			end
			vim.api.nvim_win_set_config(win, cfg)
		end
	end, opts)
end, {})

-- :LineHistory shows commit history for the current line in a scrollable float

-- Show history of the current line in a scrollable floating window
vim.api.nvim_create_user_command("LineHistory", function()
	local file = vim.fn.expand("%:p")
	local line = vim.fn.line(".")

	-- IMPORTANT: no "-- file" here
	local history = vim.fn.system({
		"git",
		"log",
		"-L",
		string.format("%d,%d:%s", line, line, file),
		"--date=short",
		"--color=never",
	})

	if vim.v.shell_error ~= 0 then
		vim.notify("git log -L failed:\n" .. history, vim.log.levels.ERROR)
		return
	end

	if history:match("^%s*$") then
		vim.notify("No history found for line " .. line, vim.log.levels.INFO)
		return
	end

	local lines = vim.split(history, "\n", { plain = true })

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].modifiable = false
	vim.bo[buf].filetype = "git"

	local width = math.floor(vim.o.columns * 0.9)
	local height = math.floor(vim.o.lines * 0.85)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		width = width,
		height = height,
		border = "rounded",
		style = "minimal",
		title = " Line History (" .. line .. ") ",
		title_pos = "center",
	})

	vim.wo[win].wrap = false
	vim.wo[win].cursorline = true

	local opts = { buffer = buf, nowait = true, silent = true }
	vim.keymap.set("n", "q", "<cmd>close<CR>", opts)
	vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", opts)
end, {})

--
-- SECTION Own tools
--

-- TODO - Clean up code
vim.api.nvim_create_user_command("BlameFile", function()
	print("Running BlameFile")

	local mainWin = nil
	local commitWin = nil

	function closeAll()
		local windows = { mainWin, commitWin }
		for _, win in ipairs(windows) do
			if win and vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
		end
	end

	-- Current file
	local file = vim.fn.expand("%:p")
	local currentLine = vim.fn.line(".")

	local blame = vim.fn.system({
		"git",
		"blame",
		file,
	})

	if vim.v.shell_error ~= 0 then
		vim.notify("git blame failed:\n" .. blame, vim.log.levels.ERROR)
		return
	end

	-- Filtering trailing spaces
	blame = blame:gsub("%s+$", "")

	-- Create blame buffer
	local blameLines = vim.split(blame, "\n", { plain = true })
	local blameBuf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(blameBuf, 0, -1, false, blameLines)
	vim.bo[blameBuf].bufhidden = "wipe"
	vim.bo[blameBuf].filetype = "diff"
	vim.bo[blameBuf].modifiable = false

	-- Main (blame) window max size
	local maxWidth = math.floor(vim.o.columns * 0.9)
	local maxHeight = math.floor(vim.o.lines * 0.85)
	-- Commit view width
	local maxCommitWidth = math.floor(maxWidth * 0.65)

	mainWin = vim.api.nvim_open_win(blameBuf, true, {
		relative = "editor",
		row = math.floor((vim.o.lines - maxHeight) / 2),
		col = math.floor((vim.o.columns - maxWidth) / 2),
		width = maxWidth,
		height = maxHeight,
		border = "rounded",
		style = "minimal",
		title_pos = "center",
		title = " git blame " .. file .. " ",
	})
	vim.cmd(string.format(":%d", currentLine))

	vim.api.nvim_set_option_value("cursorline", true, { win = mainWin })
	vim.api.nvim_set_option_value("relativenumber", true, { win = mainWin }) -- TEST

	-- Parse current line and return commit content
	function getCommitId(line)
		local commit = line:match("^(%w+)")
		if not commit then
			vim.notify("Could not parse commit hash", vim.log.levels.ERROR)
			return
		end
		return commit
	end
	function getCommitContent(commit)
		print("Reading commit content from commit " .. commit)
		local content = vim.fn.system({
			"git",
			"show",
			"--color=never",
			commit,
		})
		if vim.v.shell_error ~= 0 then
			vim.notify("git show failed for commit " .. commit)
			return nil
		end
		return content
	end

	function toggleMainWindowWidth(fullscreen)
		if mainWin and vim.api.nvim_win_is_valid(mainWin) then
			local cfg = vim.api.nvim_win_get_config(mainWin)
			cfg.width = math.floor(fullscreen == true and maxWidth or (maxWidth - maxCommitWidth))
			vim.api.nvim_win_set_config(mainWin, cfg)
		end
	end

	local mainBufOpts = { buffer = blameBuf, nowait = true, silent = true }
	vim.keymap.set("n", "q", closeAll, mainBufOpts)
	vim.keymap.set("n", "<Esc>", closeAll, mainBufOpts)
	vim.keymap.set("n", "v", function()
		-- TODO - get current line and open result from getCommitContent(line) into new split buffer
		local lineNr = vim.fn.line(".")
		local commitId = getCommitId(blameLines[lineNr])
		local commitContent = getCommitContent(commitId)
		if commitContent == nil then
			return
		end

		local commitLines = vim.split(commitContent, "\n", { plain = true })
		local commitBuf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(commitBuf, 0, -1, false, commitLines)
		vim.bo[commitBuf].bufhidden = "wipe"
		vim.bo[commitBuf].filetype = "diff"
		vim.bo[commitBuf].modifiable = false

		commitWin = vim.api.nvim_open_win(commitBuf, true, {
			relative = "editor",
			row = math.floor((vim.o.lines - maxHeight) / 2),
			col = math.floor((vim.o.columns - maxWidth) / 2) + (maxWidth - maxCommitWidth + 2), -- offset + padding
			width = maxCommitWidth,
			height = maxHeight,
			border = "rounded",
			style = "minimal",
			title = " git show " .. commitId .. " ",
			title_pos = "center",
		})

		toggleMainWindowWidth(false)

		function closeCommitWinAndRestoreMain()
			if commitWin and vim.api.nvim_win_is_valid(commitWin) then
				vim.api.nvim_win_close(commitWin, true)
			end
			toggleMainWindowWidth(true)
		end
		local commitBufOpts = { buffer = commitBuf, nowait = true, silent = true }
		-- vim.keymap.set("n", "q", "<cmd>close<CR>", commitBufOpts)
		-- vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", commitBufOpts)
		vim.keymap.set("n", "v", closeCommitWinAndRestoreMain, commitBufOpts) -- allow using same button that opened view to close it
		vim.keymap.set("n", "q", closeCommitWinAndRestoreMain, commitBufOpts)
		vim.keymap.set("n", "<Esc>", closeCommitWinAndRestoreMain, commitBufOpts)
	end, mainBufOpts)
end, {})

-- Plugin keymaps
vim.keymap.set("n", "<leader>bl", "<cmd>BlameLine<CR>", {})
vim.keymap.set("n", "<leader>bf", "<cmd>BlameFile<CR>", {})
vim.keymap.set("n", "<leader>bh", "<cmd>LineHistory<CR>", {})
