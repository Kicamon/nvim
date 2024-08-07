local conf = require('modules.completion.config')

packadd({
  'hrsh7th/nvim-cmp',
  commit = '24122371810089d390847d8ba66325c1f1aa64c0',
  lazy = true,
  event = 'LspAttach',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  },
  config = conf.cmp
})
