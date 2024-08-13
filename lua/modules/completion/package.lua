local conf = require('modules.completion.config')

packadd({
  'hrsh7th/nvim-cmp',
  commit = '24122371810089d390847d8ba66325c1f1aa64c0',
  lazy = true,
  event = 'LspAttach',
  config = conf.cmp,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
  },
})
