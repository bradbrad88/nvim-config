local keymaps = require("config.keymap").neotree
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {},
		config = function()
			local neotree = require("neo-tree")
			neotree.setup({
				default_component_configs = {
					indent = {
						indent_size = 2,
					},
					git_status = {
						symbols = {
							added = "+",
							modified = "*",
							deleted = "x",
						},
					},
				},
				window = {
					position = "right",
					width = 60,
					mapping_options = {
						noremap = true,
						nowait = true,
					},
				},
			})
			keymaps(neotree)
		end,
	},
}
