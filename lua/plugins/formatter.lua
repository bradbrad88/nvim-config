local keymaps = require("config.keymap").conform_keymaps
return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				javascript = { "tailwindcss", "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "tailwindcss", "prettier" },
				typescriptreact = { "tailwindcss", "prettier" },
				lua = { "stylua" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function()
				vim.bo.tabstop = 4
				vim.bo.shiftwidth = 4
				vim.bo.softtabstop = 4
				vim.bo.expandtab = true
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			callback = function()
				vim.bo.tabstop = 2
				vim.bo.shiftwidth = 2
				vim.bo.softtabstop = 2
				vim.bo.expandtab = true
			end,
		})
		keymaps(conform)
	end,
}
