return function ()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'go',
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
      enable = true,
    },
  })
end
