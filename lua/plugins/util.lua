return {
	{
		'junegunn/goyo.vim',
		key = { '<leader>gy' },
		config = function()
			vim.keymap.set('n', '<leader>gy', ':Goyo<CR>', { noremap = true })
		end
	}
}
