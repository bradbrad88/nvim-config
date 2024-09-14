local keymaps = require("config.keymap").gitsigns_keymaps
return {
	{
		"lewis6991/gitsigns.nvim",
		opts = function()
			local gitsigns = require("gitsigns")
			vim.cmd("set statusline+=%{get(b:,'gitsigns_status','')}")
			keymaps(gitsigns)
			return {}
		end,
	},
}
