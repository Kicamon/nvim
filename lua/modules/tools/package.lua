local conf = require('modules.tools.config')

packadd({
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = true,
  event = { 'BufRead', 'BufNewFile' },
  config = conf.treesitter,
})

packadd({
  'ibhagwan/fzf-lua',
  lazy = true,
  cmd = 'FzfLua',
  config = true,
})

packadd({
  'nvimdev/guard.nvim',
  lazy = true,
  cmd = 'GuardFmt',
  config = conf.guard,
})

packadd({
  'folke/flash.nvim',
  lazy = true,
  config = conf.flash,
})

packadd({
  'Kicamon/flybuf.nvim',
  lazy = true,
  cmd = 'FlyBuf',
  config = true,
})
