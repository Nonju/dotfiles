local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close, -- Insta-close prompt
				-- ["<C-c>"] = function() -- Goto normal mode instead of closing
				-- 	vim.cmd("stopinsert")
				-- end,
			},
			n = {
				["<C-c>"] = actions.close, -- Close prompt from normal mode
			},
		},
	},
})
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<leader>pg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
vim.keymap.set("n", "<leader>ph", builtin.help_tags, {})

vim.keymap.set("n", "<C-p>", builtin.git_files, {})
-- vim.keymap.set("n", "<M-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
