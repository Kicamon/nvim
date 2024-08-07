local config = {}

function config.gitsigns()
  require('gitsigns').setup {
    signs = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┃' },

    },
  }
end

function config.indentmini()
  require('indentmini').setup({
    char = "│",
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
    }
  })
end

function config.treesitter()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'html',
      'javascript',
      'lua',
      'markdown',
      'markdown_inline',
      'python',
      'typescript',
      'vim',
      'json',
      'vimdoc',
    },
    highlight = {
      enable = true,
      disable = {},
    },
    indent = {
      enable = true
    },
  })
end

function config.rainbow()
  local rainbow_delimiters = require('rainbow-delimiters')
  vim.g.rainbow_delimiters = {
    strategy = {
      [''] = rainbow_delimiters.strategy['global'],
      vim = rainbow_delimiters.strategy['local'],
    },
    query = {
      [''] = 'rainbow-delimiters',
      lua = 'rainbow-blocks',
    },
    highlight = {
      'RainbowDelimiterBlue',
      'RainbowDelimiterYellow',
      'RainbowDelimiterCyan',
      'RainbowDelimiterViolet',
      'RainbowDelimiterRed',
      'RainbowDelimiterOrange',
      'RainbowDelimiterGreen',
    },
  }
end

return config
