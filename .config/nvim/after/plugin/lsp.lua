vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)

		-- Handle diagnostics / errors
		-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { noremap = true, silent = true, buffer = bufnr }) -- Open diagnostics window
		-- vim.keymap.set("n", "<leader>r", vim.diagnostic.goto_next, opts) -- Goto next diagnostic

		vim.diagnostic.config({ virtual_text = true }) -- Enable virtual text by default
	end,
})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason").setup({})
require("mason-lspconfig").setup({
	-- ensure_installed = { "tsserver", "eslint", "rust_analyzer" },
	ensure_installed = { "ts_ls", "eslint", "rust_analyzer" }, -- "tsserver" -> "ts_ls"
	handlers = {
		function(server_name)
			-- require("lspconfig")[server_name].setup({ -- Deprecated
			vim.lsp.config(server_name, {
				capabilities = lsp_capabilities,
			})
			vim.lsp.enable(server_name)
		end,
		lua_ls = function()
			-- require("lspconfig").lua_ls.setup({ -- Deprecated
			vim.lsp.config("lua_ls", {
				capabilities = lsp_capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					},
				},
			})
			vim.lsp.enable("lua_ls")
		end,
	},
})
-- require("lspconfig").eslint.setup({}) -- Deprecated
vim.lsp.config("eslint", {})
vim.lsp.enable("eslint")

vim.lsp.config("clangd", {})
vim.lsp.enable("clangd")

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-m>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
})
vim.keymap.set("i", "<C-q>", cmp.complete)
