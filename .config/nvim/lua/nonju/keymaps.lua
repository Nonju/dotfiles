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

vim.keymap.set("n", "<Up>", ":resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", ":resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Left>", ":vertical resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", ":vertical resize -2<CR>", { noremap = true, silent = true })
