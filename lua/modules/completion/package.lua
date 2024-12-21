local conf = require('modules.completion.config')

packadd({
  'saghen/blink.cmp',
  lazy = true,
  event = 'LspAttach',
  config = conf.blink,
  dependencies = 'L3MON4D3/LuaSnip',
  version = 'v0.*',
})
