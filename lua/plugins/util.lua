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
		key = { 'R' },
		config = function()
			vim.keymap.set('n', 'R', ':RnvimrToggle<CR>', { noremap = true })
		end
	}
}
