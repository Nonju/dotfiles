vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>") -- clear search

-- tab quick switch
vim.keymap.set("n", "<s-h>", "gT")
vim.keymap.set("n", "<s-l>", "gt")

-- exit insert mode on movement
vim.keymap.set("i", "jj", "<esc>j")
-- vim.keymap.set("i", "nn", "<esc>n") -- keeping commented out, "jj" feels less clumsy

-- Move selection up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in same location when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Option to paste without overwriting clipboard
vim.keymap.set("x", "<leader>p", '"_dP')

-- Yank to clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>Y", '"+Y')

-- Delete to void register
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Get prompt for replacing selected word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Switch between header/source files (c / cpp)
-- vim.keymap.set("n", "<leader>gh", vim.cmd.ClangdSwitchSourceHeader)
vim.keymap.set("n", "<leader>gh", vim.cmd.LspClangdSwitchSourceHeader)

-- Horizontal scroll
vim.keymap.set("n", "<C-L>", "20zl")
vim.keymap.set("n", "<C-H>", "20zh")

-- Allows usage of word highlighting (asterisk *) without jumping to next instance
vim.keymap.set("n", "*", ":keepjumps normal! mi*`i<CR>", { silent = true })

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
