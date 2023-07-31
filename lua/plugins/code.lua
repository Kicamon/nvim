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
					enable = true,
					use_treesitter = true,
					style = {
						{ fg = "#806d9c" },
					},

				},
				indent = {
					enable = true,
					use_treesitter = true,
					chars = {
						"│",
					},
					--style = {
						--'#00BFFF',
						--'#B0E0E6',
						--'#FF69B4',
					--},
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
}
