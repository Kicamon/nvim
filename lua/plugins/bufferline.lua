return {
    "akinsho/bufferline.nvim",
    config = function()
        vim.opt.termguicolors = true
        require("bufferline").setup {}
    end
}
