return {
	{
		--translate
		'niuiic/translate.nvim',
		key = { "<space>ts" },
		config = function()
			vim.keymap.set("v", "<leader>ts", "<cmd>TransToZH<CR>", { silent = true })
			vim.keymap.set("n", "<leader>ts", "<cmd>TransToEN<CR>")
		end,
	},
	{
		'junegunn/goyo.vim',
		key = { '<leader>gy' },
		config = function()
			vim.keymap.set('n', '<leader>gy', ':Goyo<CR>', { noremap = true })
		end
	}
}
