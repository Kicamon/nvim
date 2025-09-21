local conf = require('modules.lsp.config')

packadd({
  'nvimdev/lspsaga.nvim',
  lazy = true,
  event = 'LspAttach',
  config = conf.lspsaga,
})
