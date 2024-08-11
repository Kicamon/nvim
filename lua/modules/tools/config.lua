local config = {}

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
      enable = true,
    },
  })
end

function config.telescope()
  require('telescope').setup({
    defaults = {
      prompt_prefix = ' ',
      selection_caret = ' ',
      layout_config = {
        horizontal = { prompt_position = 'top', results_width = 0.6 },
        vertical = { mirror = false },
      },
      sorting_strategy = 'ascending',
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
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

function config.guard()
  local ft = require('guard.filetype')
  ft('c,cpp'):fmt({
    cmd = 'clang-format',
    stdin = true,
    ignore_patterns = { 'neovim', 'vim' },
  })
  ft('python'):fmt('black')
  ft('lua'):fmt({
    cmd = 'stylua',
    args = { '-' },
    stdin = true,
    ignore_patterns = '%w_spec%.lua',
  })
  require('guard').setup({
    fmt_on_save = false,
    lsp_as_default_formatter = true,
  })
end

return config
