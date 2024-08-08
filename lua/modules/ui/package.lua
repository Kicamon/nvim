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
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = true,
  event = { 'BufRead', 'BufNewFile' },
  config = conf.treesitter,
})
