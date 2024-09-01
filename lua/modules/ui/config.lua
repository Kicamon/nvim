local config = {}

function config.gitsigns()
  require('gitsigns').setup({
    signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┃' },
    },
  })
end

function config.indentmini()
  require('indentmini').setup({
    char = '│',
    exclude = {
      'help',
      'dashboard',
      'lazy',
      'notify',
      'toggleterm',
      'lazyterm',
      'markdown',
      'text',
      'Yazi',
    },
  })
end

function config.colors()
  require('nvim-highlight-colors').setup({
    render = 'virtual',
  })
end

return config
