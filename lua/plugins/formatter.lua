-- return {
--     "mhartington/formatter.nvim",
--     opts = function()
--         return require "config.format"
--     end
-- }


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

		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4
		vim.opt.expandtab = true

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			print("formatting")
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "" })
	end,
	opts = function()
		return require("config.format")
	end,
}
