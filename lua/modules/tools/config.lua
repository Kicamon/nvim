local config = {}

function config.treesitter()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'rust',
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

function config.guard()
  local ft = require('guard.filetype')
  ft('c,cpp'):fmt({
    cmd = 'clang-format',
    stdin = true,
    ignore_patterns = { 'neovim', 'vim' },
  })
  ft('python'):fmt({
    cmd = 'black',
    args = { '--quiet', '-' },
    stdin = true,
  })
  ft('lua'):fmt({
    cmd = 'stylua',
    args = { '-' },
    stdin = true,
    ignore_patterns = '%w_spec%.lua',
  })
  ft('sh'):fmt({
    cmd = 'shfmt',
    args = { '-' },
    stdin = true,
  })
  ft('html', 'css', 'javascript', 'json'):fmt('lsp')
  require('guard').setup({
    fmt_on_save = false,
    lsp_as_default_formatter = true,
  })
end

function config.flash()
  require('flash').setup({
    modes = { char = { enabled = false } },
  })
end

return config
