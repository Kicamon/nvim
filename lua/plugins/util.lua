return {
	{
		'junegunn/goyo.vim',
		key = { '<leader>gy' },
		config = function()
			vim.keymap.set('n', '<leader>gy', ':Goyo<CR>', { noremap = true })
		end
	},
	{
		'kevinhwang91/rnvimr',
		config = function()
			vim.keymap.set('n', 'R', ':RnvimrToggle<CR>', { noremap = true })
		end
	},
	{
		"Kicamon/im-switch.nvim",
		lazy = true,
		event = { "InsertEnter" },
		config = function()
			require("im-switch").setup()
		end
	}
}
