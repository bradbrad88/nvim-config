local keymaps = require("config.keymap").telescope_keymaps

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
		config = function()
			local telescope = require("telescope.builtin")
			keymaps(telescope)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "nvim-treesitter/playground" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "vim", "javascript", "typescript", "html", "css" },
				ignore_install = {},
				modules = {},
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
							["ab"] = "@block.outer",
							["ib"] = "@block.innter",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							[']"'] = "@string.outer",
							["]f"] = "@function.outer",
							["]F"] = "@function.inner",
							["]b"] = "@block.inner",
							["]ah"] = "@assignment.lhs",
							["]al"] = "@assignment.rhs",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[F"] = "@function.inner",
							["[b"] = "@block.inner",
							["[ah"] = "@assignment.lhs",
							["[al"] = "@assignment.rhs",
						},
					},
				},
			})
		end,
	},
}
