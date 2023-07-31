return {
	"nvim-treesitter/playground",
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		priority = 1000,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"html",
					"javascript",
					"typescript",
					"query",
					"dart",
					"java",
					"c",
					"cpp",
					"prisma",
					"bash",
					"go",
					"lua",
					"vim"
				},
				highlight = {
					enable = true,
					disable = {}, -- list of language that will be disabled
				},
				indent = {
					enable = false
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection    = "<c-n>",
						node_incremental  = "<c-n>",
						node_decremental  = "<c-h>",
						scope_incremental = "<c-l>",
					},
				}
			})
		end
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			local rainbow_delimiters = require 'rainbow-delimiters'
			vim.g.rainbow_delimiters = {
				strategy = {
					[''] = rainbow_delimiters.strategy['global'],
					vim = rainbow_delimiters.strategy['local'],
				},
				query = {
					[''] = 'rainbow-delimiters',
					lua = 'rainbow-blocks',
				},
				highlight = {
					'RainbowDelimiterRed',
					'RainbowDelimiterYellow',
					'RainbowDelimiterBlue',
					'RainbowDelimiterOrange',
					'RainbowDelimiterGreen',
					'RainbowDelimiterViolet',
					'RainbowDelimiterCyan',
				},
			}
		end
	}
}
