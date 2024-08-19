local conf = require('modules.tools.config')

packadd({
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = true,
  event = { 'BufRead', 'BufNewFile' },
  config = conf.treesitter,
})

packadd({
  'nvim-telescope/telescope.nvim',
  lazy = true,
  cmd = 'Telescope',
  config = conf.telescope,
  dependencies = { 'nvim-lua/plenary.nvim' },
})

packadd({
  'nvimdev/guard.nvim',
  lazy = true,
  cmd = 'GuardFmt',
  config = conf.guard,
})

packadd({
  'nvimdev/flybuf.nvim',
  lazy = true,
  cmd = 'FlyBuf',
  config = true,
})

packadd({
  'folke/flash.nvim',
  lazy = true,
  config = conf.flash,
})
