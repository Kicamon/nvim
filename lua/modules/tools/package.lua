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
  cmd = 'Guard',
  config = conf.guard,
})
