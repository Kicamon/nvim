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
    'echasnovski/mini.comment',
    lazy = true,
    keys = { 'V', '<leader>cc' },
    opts = {
      mappings = {
        comment_line = '<leader>cc',
        comment_visual = '<leader>cc',
      }
    },
  },
  {
    'echasnovski/mini.align',
    lazy = true,
    keys = 'V',
    opts = {
      mappings = {
        start = 'ga',
      },
    }
  },
  {
    'dhruvasagar/vim-table-mode',
    lazy = true,
    ft = 'markdown',
    config = function()
      vim.g.table_mode_corner = '|'
      vim.g.table_mode_disable_mappings = 1
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = '*.md',
        command = 'silent TableModeEnable',
      })
    end,
  },
}
