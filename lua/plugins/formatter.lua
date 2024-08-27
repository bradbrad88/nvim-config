-- return {
--     "mhartington/formatter.nvim",
--     opts = function()
--         return require "config.format"
--     end
-- }


return {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
        return require("config.format")
    end
}


