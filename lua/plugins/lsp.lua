local keymaps = require("config.keymap").cmp
local lsp_keymaps = require("config.keymap").lsp

return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
		lazy = true,
		config = false,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
				}),
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
			})
			keymaps(cmp)
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			local lsp_attach = function(_, bufnr)
				local opts = { buffer = bufnr }
				lsp_keymaps(opts)
			end

			lsp_zero.extend_lspconfig({
				sign_text = true,
				lsp_attach = lsp_attach,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			require("mason-lspconfig").setup({
				ensure_installed = { "ts_ls", "eslint", "tailwindcss" },
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,

					ts_ls = function()
						local lspconfig = require("lspconfig")
						local util = require("lspconfig.util")

						lspconfig.ts_ls.setup({
							on_attach = function(client, bufnr)
								client.server_capabilities.document_formatting = false
								client.server_capabilities.document_range_formatting = false
								lsp_attach(client, bufnr)
							end,
							root_dir = util.root_pattern("package.json", "tsconfig.json", ".git"),
						})
					end,

					lua_ls = function()
						require("lspconfig").lua_ls.setup({
							settings = {
								Lua = {
									workspace = {
										library = vim.api.nvim_get_runtime_file("", true),
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
}
