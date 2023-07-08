return {
	{
		"willothy/veil.nvim",
		lazy = false,
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim"
		},
		config = true,
		config = function()
			local builtin = require("veil.builtin")
			require('veil').setup({
				sections = {
					builtin.sections.animated(builtin.headers.frames_nvim, {
						hl = { fg = "#5de4c7" },
					}),
					builtin.sections.buttons({
						{
							icon = "",
							text = "Find Files",
							shortcut = "fdf",
							callback = function()
								require("telescope.builtin").find_files()
							end,
						},
						{
							icon = "",
							text = "Find Word",
							shortcut = "fdw",
							callback = function()
								require("telescope.builtin").live_grep()
							end,
						},
						{
							icon = "",
							text = "Config",
							shortcut = "vim",
							callback = function()
								require("telescope").extensions.file_browser.file_browser({
									path = vim.fn.stdpath("config"),
								})
							end,
						},
						{
							icon = "",
							text = "Config",
							shortcut = "acm",
							callback = function()
								vim.cmd('CompetiTestReceive contest')
							end,
						},
					}),
				},
				mappings = {},
				startup = true,
				listed = false,
			})
		end
	},
}
