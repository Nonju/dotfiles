-- general
vim.opt.backspace = "2"
vim.opt.showcmd = true
-- vim.opt.laststatus = 2 -- filename always visible
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true
vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2 -- ??
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- fix split directions for panes
vim.opt.splitright = true
vim.opt.splitbelow = true

-- vim.opt.autoindent = true -- TODO - Look into this one

vim.opt.wrap = false -- try this one out

-- Swap files
vim.opt.swapfile = false
-- -- vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true -- Updates search highlight on typing
vim.opt.scrolloff = 8 -- Always pad 8 lines on top/bottom of view

-- vim.opt.colorcolumn = "100"

-- Allow for case insensitive search by default ( enable by adding \C to pattern )
-- Ex:
--  - /word      -- Case insensitive
--  - /Word      -- Case sensitive
--  - /word\C    -- Case sensitive
--  - /Word\c    -- Case insensitive
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- set formatoptions-=cro -- Should probably set this to prevent autocommenting on new lines

-- Prevent panes from resizing when others are closed
-- vim.opt.noequalalways = true
