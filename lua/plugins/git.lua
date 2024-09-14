local keymaps = require("config.keymap").gitsigns_keymaps
return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                print("on attach git signs")
                vim.cmd("set statusline+=%{get(b:,'gitsigns_status','')}")
            end,
        },
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")
			vim.cmd("set statusline+=%{get(b:,'gitsigns_status','')}")
			keymaps(gitsigns)
		end,
	},
}
