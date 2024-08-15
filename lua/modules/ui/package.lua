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
  'NvChad/nvim-colorizer.lua',
  lazy = true,
  ft = { 'css', 'html', 'typescriptreact', 'conf', 'vim' },
  config = conf.colorizer,
})
