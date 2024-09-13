local conf = require('modules.ui.config')

packadd({
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = 'BufRead',
  config = conf.gitsigns,
})

packadd({
  'nvimdev/indentmini.nvim',
  lazy = true,
  event = 'BufRead',
  config = conf.indentmini,
})

packadd({
  'brenoprata10/nvim-highlight-colors',
  lazy = true,
  cmd = 'HighlightColors',
  event = 'BufEnter */colors/*',
  config = conf.colors,
})
