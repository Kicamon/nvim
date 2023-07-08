return {
	{
		"preservim/nerdcommenter",
		config = function()
			vim.g.NERDCreateDefaultMappings = 0
			vim.keymap.set("n", "<leader>cc", "<Plug>NERDCommenterToggle", { noremap = true, silent = true })
			vim.keymap.set("v", "<leader>cc", "<Plug>NERDCommenterToggle", { noremap = true, silent = true })
		end
	},
	{
		"shellRaining/hlchunk.nvim",
		config = function()
			require("hlchunk").setup({
				chunk = {
					enable = false,
				},
				indent = {
					enable = true,
					use_treesitter = false,
					chars = {
						"┃",
					},
					style = {
						'#00BFFF',
						'#B0E0E6',
						'#FF69B4',
					},
				},
				line_num = {
					enable = true,
					style = "#FFD700",
				},
				blank = {
					enable = false,
					chars = {
						"█",
					},
					style = {
						"#000000",
						"#0a0a0a"
					}
				}
			})
		end
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
	}
}
