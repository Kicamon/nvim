return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.2',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{ 'nvim-telescope/telescope-file-browser.nvim' },
	vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true }),
	vim.keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>", { noremap = true }),
	vim.keymap.set("n", "<leader>fb", ":Telescope buggers<CR>", { noremap = true }),
	vim.keymap.set("n", "<leader>fg", ":Telescope grep_string<CR>", { noremap = true }),
}
