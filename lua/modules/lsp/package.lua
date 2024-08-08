local conf = require('modules.lsp.backend')

packadd({
  'neovim/nvim-lspconfig',
  lazy = true,
  ft = _G.fts,
  config = conf.lsp,
})

packadd({
  'nvimdev/lspsaga.nvim',
  lazy = true,
  event = 'LspAttach',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = conf.lspsaga,
})
