local conf = require('modules.completion.config')

packadd({
  'saghen/blink.cmp',
  lazy = true,
  event = 'LspAttach',
  config = conf.blink,
  version = 'v0.*',
})
