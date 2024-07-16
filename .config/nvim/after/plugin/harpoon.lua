local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

-- See how these keybinds feel
vim.keymap.set("n", "<C-n>", ui.nav_next)
vim.keymap.set("n", "<C-b>", ui.nav_prev)

