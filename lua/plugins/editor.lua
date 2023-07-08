return {
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end
	},
	{
		"gcmt/wildfire.vim",
		lazy = false,
	},
	{
		"tpope/vim-surround",
		lazy = false,
	},
	{
		"mg979/vim-visual-multi",
		branch = 'master',
		lazy = false,
	},
}
