local conf = require('modules.ui.config')

packadd({
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = { 'BufRead', 'BufNewFile' },
  config = conf.gitsigns,
})

packadd({
  'nvimdev/indentmini.nvim',
  lazy = true,
  event = { 'BufRead', 'BufNewFile' },
  config = conf.indentmini,
})

packadd({
  'brenoprata10/nvim-highlight-colors',
  lazy = true,
  cmd = 'HighlightColors',
  config = conf.colors,
})
