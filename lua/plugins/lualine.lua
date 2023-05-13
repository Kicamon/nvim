return {
    "nvim-lualine/lualine.nvim",
    options = {theme = "horizon"},
    config = function()
        require("lualine").setup()
    end
}
