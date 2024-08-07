local conf = require('modules.tools.config')

packadd({
  'nvim-telescope/telescope.nvim',
  lazy = true,
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = conf.telescope
})

packadd({
  'NvChad/nvim-colorizer.lua',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = conf.colorizer
})

packadd({
  'folke/flash.nvim',
  lazy = true,
  keys = {
    { 's', mode = 'n', function() require('flash').jump() end, desc = 'Flash' },
  },
})

packadd({
  'nvimdev/guard.nvim',
  lazy = true,
  cmd = "GuardFmt",
  dependencies = {
    'nvimdev/guard-collection',
  },
  config = conf.guard
})

packadd({
  'nvimdev/flybuf.nvim',
  lazy = true,
  cmd = 'FlyBuf',
  config = conf.flybuf
})
