return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    {
			"neovim/nvim-lspconfig",
			dependencies = {
					{
							"SmiteshP/nvim-navbuddy",
							dependencies = {
									"SmiteshP/nvim-navic",
									"MunifTanjim/nui.nvim"
							},
							opts = { lsp = { auto_attach = true } }
					}
			},
		},             -- Required
    {                                      -- Optional
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
  },
	config = function()
		local lsp = require('lsp-zero').preset({})

		lsp.on_attach(function(client, bufnr)
			lsp.default_keymaps({buffer = bufnr})
		end)

		-- When you don't have mason.nvim installed
		-- You'll need to list the servers installed in your system
		lsp.setup_servers({'tsserver', 'eslint'})

		-- (Optional) Configure lua language server for neovim
		require('lspconfig').clangd.setup(lsp.nvim_lua_ls())
		require('lspconfig').pyright.setup(lsp.nvim_lua_ls())
		require('lspconfig').lua_ls.setup {
			settings = {
				Lua = {
					diagnostics = {
						globals = {
							'vim',
							'require',
						},
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
				},
			},
		}

		lsp.setup()

		lsp.set_sign_icons({
			error = '🤣',
			warn = '🧐',
			hint = '🫠',
			info = '🤔'
		})
		vim.keymap.set('n','\\n',':Navbuddy<CR>',{ noremap = true })
	end,
}
