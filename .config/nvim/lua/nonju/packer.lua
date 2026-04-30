-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- use 'folke/tokyonight.nvim'
	use({
		"folke/tokyonight.nvim",
		config = function()
			vim.cmd("colorscheme tokyonight-storm")

			tokyonight = require("tokyonight")
			tokyonight.setup({
				on_colors = function(colors)
					-- Todo
					-- https://github.com/folke/tokyonight.nvim?tab=readme-ov-file#-overriding-colors--highlight-groups
					-- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_storm.lua
				end,
			})
		end,
	})
	use({ -- To try out -> remove if not nice (vscode colorscheme)
		"rockyzhang24/arctic.nvim",
		requires = { "rktjmp/lush.nvim" },
	})

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("mbbill/undotree")
	use("theprimeagen/harpoon")

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			--- Uncomment the two plugins below if you want to manage the language servers from neovim
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			-- {'jay-babu/mason-null-ls.nvim'}, -- remove this?

			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "L3MON4D3/LuaSnip" },
		},
	})

	-- Followed tutorial in this video
	-- https://www.youtube.com/watch?v=ybUE4D80XSk
	-- (updated syntax after upgrading to neovim v0.11)
	use({
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			local format_options = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
				stop_after_first = true,
			}

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettierd", "prettier" },
					typescript = { "prettierd", "prettier" },
					javascriptreact = { "prettierd", "prettier" },
					typescriptreact = { "prettierd", "prettier" },
					svelte = { "prettierd", "prettier" },
					css = { "prettierd", "prettier" },
					html = { "prettierd", "prettier" },
					json = { "prettierd", "prettier" },
					yaml = { "prettierd", "prettier" },
					markdown = { "prettierd", "prettier" },
					lua = { "stylua" },
					python = { "isort", "black" },
					c = { "clang_format" },
					cpp = { "clang_format" },
				},

				format_on_save = format_options,
			})

			vim.keymap.set({ "n", "v" }, "<leader>f", function()
				conform.format(format_options)
			end, { desc = "Format file or range (in visual mode)" })
		end,
	})

	use({
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = {
					"~",
					"~/Downloads",
					"/",
				},
				auto_restore_enabled = true,
				auto_session_enable_last_session = false,
			})
		end,
	})

	use("delphinus/vim-firestore")

	-- TODO - try out!!
	-- use({
	--   "iamcco/markdown-preview.nvim",
	--   run = function() vim.fn["mkdp#util#install"]() end,
	-- })
	--
	-- use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

	-- Base commenting functions already exists in newer neovim versions. This might be helpful for adding block comments however!

	-- use({
	-- use {
	--   'numToStr/Comment.nvim',
	--   config = function()
	--     require('Comment').setup()
	--   end
	-- }
end)
