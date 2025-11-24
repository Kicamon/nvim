local function conf(config)
  return require('modules.config.' .. config)
end

packadd({
  'nvimdev/lspsaga.nvim',
  lazy = true,
  event = 'LspAttach',
  config = conf('lspsaga'),
})

packadd({
  'saghen/blink.cmp',
  lazy = true,
  event = 'LspAttach',
  config = conf('blink'),
  version = 'v1.*',
})

packadd({
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = conf('treesitter'),
})

packadd({
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  lazy = true,
  config = true,
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
  config = conf('guard'),
})

packadd({
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = 'BufRead',
  config = conf('gitsigns'),
})

packadd({
  'nvimdev/indentmini.nvim',
  lazy = true,
  event = 'BufReadPre',
  config = conf('indentmini'),
})
