return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require('gitsigns').setup()
		require('gitsigns').setup {
			signs = {
				add          = { hl = 'GitSignsAdd', text = '▎', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
				change       = { hl = 'GitSignsChange', text = '░', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
				delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
				topdelete    = { hl = 'GitSignsDelete', text = '▔', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
				changedelete = { hl = 'GitSignsChange', text = '█', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
				untracked    = { hl = 'GitSignsAdd', text = '┆', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
			},
		}
		vim.keymap.set("n", "<leader>g-", ":Gitsigns prev_hunk<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>g=", ":Gitsigns next_hunk<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "H", ":Gitsigns preview_hunk_inline<CR>", { noremap = true, silent = true })
	end
}
