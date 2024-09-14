return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = { icons_enabled = true, theme = "auto", always_divide_middle = true },
		sections = {
			lualine_a = { "mode" },
		},
	},
}
