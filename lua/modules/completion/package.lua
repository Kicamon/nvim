local conf = require('modules.completion.config')

packadd({
  'hrsh7th/nvim-cmp',
  lazy = true,
  event = 'LspAttach',
  config = conf.completion,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
  },
})
