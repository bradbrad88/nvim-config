return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		tag = "0.1.8",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
        dependencies = {"nvim-treesitter/nvim-treesitter-textobjects"},
		opts = {
			ensure_installed = { "lua", "vim", "javascript", "typescript", "html", "css" },
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                    }
                }
            }
		},
	},
	-- {
	-- 	"nvim-treesitter/nvim-treesitter-textobjects",
	-- 	opts = {
	-- 		textobjects = {
	-- 			select = {
	-- 				keymaps = {
	-- 					["af"] = "@function.outer",
	-- 					["if"] = "@function.inner",
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"VonHeikemen/lsp-zero.nvim",
	-- 	lazy = true,
	-- 	config = false,
	-- },
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	cmd = "LspInfo",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	dependencies = {
	-- 		{ "hrsh7th/cmp-nvim-lsp" },
	-- 	},
	-- 	config = function()
	-- 		local lsp_zero = require("lsp-zero")
	-- 		local lsp_attach = function(client, bufnr)
	-- 			local opts = { buffer = bufnr }
	--
	-- 			vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
	-- 		end
	--
	-- 		lsp_zero.extend_lspconfig({
	-- 			sign_text = true,
	-- 			lsp_attach = lsp_attach,
	-- 			capabilities = require("cmp_nvim_lsp").default_capabilities()
	-- 		})
	-- 		require("lspconfig").tsserver.setup({})
	-- 	end
	-- },
	-- { "hrsh7th/cmp-nvim-lsp" },
	-- { "hrsh7th/nvim-cmp" },
	--	{
	--		"neovim/nvim-lspconfig",
	--		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
	--		config = function()
	--			require("mason").setup()
	--			require("mason-lspconfig").setup()
	--		end,
	--	},
	--	{
	--		"hrsh7th/nvim-cmp",
	--		dependencies = {
	--			"hrsh7th/cmp-nvim-lsp",
	--			"hrsh7th/cmp-buffer",
	--			"hrsh7th/cmp-path",
	--			"hrsh7th/cmp-cmdline",
	--			"L3MON4D3/LuaSnip",
	--		},
	--		config = function()
	--			local cmp = require("cmp")
	--			cmp.setup({
	--				snippet = {
	--					expand = function(args)
	--						require("luasnip").lsp_expand(args.body)
	--					end,
	--				},
	--				sources = cmp.config.sources({
	--					{ name = "nvim_lsp" },
	--					{ name = "buffer" },
	--					{ name = "path" },
	--				}),
	--			})
	--		end,
	--	},
	-- {
	-- 	"jose-elias-alvarez/null-ls.nvim",
	-- 	config = function()
	-- 		require("null-ls").setup()
	-- 	end,
	-- },
}
