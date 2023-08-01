return {
	{
		'iamcco/markdown-preview.nvim',
		build = "cd app && yarn install",
		ft = { "markdown", "vimwiki" },
		config = function()
			vim.g.mkdp_browser = "chromium"
			vim.g.mkdp_theme = 'dark'
		end,
	},
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown", "vimwiki" },
		config = function()
			vim.g.table_mode_corner = '|'
			vim.keymap.set("n", "\f", ":TableModeToggle<CR>", { noremap = true })
		end,
	},
	{
		"mzlogin/vim-markdown-toc",
		ft = { "markdown", "vimwiki" },
		config = function()
			vim.keymap.set("n", "toc", ":GenTocGitLab<CR>", { noremap = true, buffer = true })
		end,
	},
	{
		"img-paste-devs/img-paste.vim",
		ft = { "markdown", "vimwiki", "tex" },
		config = function()
			vim.g.PasteImageFunction = 'g:MarkdownPasteImage'
			vim.g.PasteImageFunction = 'g:LatexPasteImage'
			vim.keymap.set("n", "<leader>p", ":call mdip#MarkdownClipboardImage()<CR>", { noremap = true })
		end,
	},
	--{
	--"dkarter/bullets.vim",
	--ft = { "markdown", "vimwiki" },
	--config = function()
	--vim.g.bullets_enabled_file_types = { 'markdown', 'text', 'gitcommit', 'scratch' }
	--vim.g.bullets_outline_levels = { 'num' }
	--vim.g.bullets_set_mappings = 0
	--vim.g.bullets_mapping_leader = '<M-b>'
	--vim.cmd([[
	--let g:bullets_custom_mappings = [
	--\ ['imap', '<cr>', '<Plug>(bullets-newline)'],
	--\ ['inoremap', '<C-cr>', '<cr>'],
	--\
	--\ ['nmap', 'o', '<Plug>(bullets-newline)'],
	--\
	--\ ['vmap', 'gN', '<Plug>(bullets-renumber)'],
	--\ ['nmap', 'gN', '<Plug>(bullets-renumber)'],
	--\
	--\ ['nmap', '<leader>x', '<Plug>(bullets-toggle-checkbox)'],
	--\
	--\ ['imap', '<C-=>', '<Plug>(bullets-demote)'],
	--\ ['imap', '<C-->', '<Plug>(bullets-promote)'],
	--]
	--]])
	--end,
	--},
	{
		"vimwiki/vimwiki",
		lazy = false,
		init = function()
			vim.g.vimwiki_list = {
				{
					path = '~/Documents/study/Note/vimwiki/',
					syntax = 'markdown',
					ext = '.md',
				},
			}
			vim.g.vimwiki_global_ext = 0
		end,
	},
}
