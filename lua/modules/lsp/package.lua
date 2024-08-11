local conf = require('modules.lsp.backend')

packadd({
  'neovim/nvim-lspconfig',
  lazy = true,
  ft = _G.lsp_fts,
  config = conf.lsp,
})

packadd({
  'nvimdev/lspsaga.nvim',
  lazy = true,
  event = 'LspAttach',
  config = conf.lspsaga,
})
