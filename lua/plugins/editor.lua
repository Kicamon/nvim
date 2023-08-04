return {
	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = { "InsertEnter" },
		config = function()
			require("nvim-autopairs").setup({})
		end
	},
	{
		"gcmt/wildfire.vim",
	},
	{
		"tpope/vim-surround",
	},
	{
		"mg979/vim-visual-multi",
	},
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				RGB = true,       -- #RGB hex codes
				RRGGBB = true,    -- #RRGGBB hex codes
				names = false,    -- "Name" codes like Blue or blue
				RRGGBBAA = true,  -- #RRGGBBAA hex codes
				AARRGGBB = true,  -- 0xAARRGGBB hex codes
				rgb_fn = false,   -- CSS rgb() and rgba() functions
				hsl_fn = false,   -- CSS hsl() and hsla() functions
				css = false,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = false,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "virtualtext", -- Set the display mode.
				-- Available methods are false / true / "normal" / "lsp" / "both"
				-- True is same as normal
				tailwind = true,
				sass = { enable = false },
				virtualtext = "■",
			},
			-- all the sub-options of filetypes apply to buftypes
			buftypes = {},
		}
	},
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
			local exft = {
				aerial = true,
				Navbuddy = true,
				markdown = true,
				snippets = true,
			}
			require("hlchunk").setup({
				chunk = {
					enable = true,
					use_treesitter = true,
					notify = false,
					exclude_filetypes = exft,
					support_filetypes = {
						"*.c",
						"*.cpp",
						"*.py",
						"*.python",
						"*.lua",
						"*.js",
					},
					style = {
						{ fg = "#806d9c" },
					},
				},
				indent = {
					enable = true,
					use_treesitter = true,
					exclude_filetypes = exft,
					chars = {
						"│",
					},
					style = {
						--'#00BFFF',
						--'#B0E0E6',
						--'#FF69B4',
						"#504945",
						"#454c50",
					},
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
	{
		"SmiteshP/nvim-navbuddy",
		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim"
		},
		opts = { lsp = { auto_attach = true } },
		vim.keymap.set("n", "\\n", ":Navbuddy<CR>", { noremap = true, silent = true })
	},
}
