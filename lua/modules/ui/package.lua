local conf = require('modules.ui.config')

packadd({
  'nvim-tree/nvim-web-devicons',
  lazy = true,
})

packadd({
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = { 'BufRead', 'BufNewFile' },
  config = conf.gitsigns
})

packadd({
  'nvimdev/indentmini.nvim',
  lazy = true,
  event = { 'BufRead', 'BufNewFile' },
  config = conf.indentmini
})

packadd({
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = true,
  event = { 'BufRead', 'BufNewFile' },
  config = conf.treesitter
})

packadd({
  'HiPhish/rainbow-delimiters.nvim',
  lazy = true,
  event = { 'BufRead', 'BufNewFile' },
  config = conf.rainbow
})
