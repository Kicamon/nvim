return {
  {
    'windwp/nvim-autopairs',
    lazy = true,
    event = 'InsertEnter',
    opts = {}
  },
  {
    'nvimdev/guard.nvim',
    lazy = true,
    event = 'LspAttach',
    dependencies = {
      'nvimdev/guard-collection',
    },
    config = function()
      local ft = require('guard.filetype')
      ft('c', 'cpp'):fmt('clang-format')
      ft('python'):fmt('black')
      ft('lua'):fmt('lsp')
      require('guard').setup({
        fmt_on_save = false,
        lsp_as_default_formatter = true,
        vim.keymap.set({ 'n', 'v' }, ';f', '<cmd>GuardFmt<CR>', {}),
      })
    end
  },
  {
    'windwp/nvim-ts-autotag',
    lazy = true,
    ft = 'html',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
  {
    'echasnovski/mini.comment',
    lazy = true,
    keys = { 'V', '<leader>cc' },
    opts = {
      mappings = {
        comment_line = '<leader>cc',
        comment_visual = '<leader>cc',
      }
    },
  }
}
