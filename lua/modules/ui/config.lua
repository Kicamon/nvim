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

function config.colorizer()
  require('colorizer').setup({
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      names = true,
      RRGGBBAA = true,
      AARRGGBB = true,
      rgb_fn = false,
      hsl_fn = false,
      css = true,
      css_fn = true,
      mode = 'virtualtext',
      tailwind = true,
      sass = { enable = false },
      virtualtext = '■',
    },
  })
end

return config
