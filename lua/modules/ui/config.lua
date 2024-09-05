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
      'markdown',
      'text',
    },
  })
end

function config.colors()
  require('nvim-highlight-colors').setup({
    render = 'virtual',
    virtual_symbol = '■',
    virtual_symbol_position = 'eol',
  })
end

return config
