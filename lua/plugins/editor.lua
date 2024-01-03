return {
  {
    "m4xshen/autoclose.nvim",
    lazy = true,
    event = 'InsertEnter',
    config = function()
      require("autoclose").setup()
    end
  },
  {
    "echasnovski/mini.comment",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      mappings = {
        comment_line = "<leader>cc",
        comment_visual = '<leader>cc',
      }
    },
  },
  {
    'echasnovski/mini.align',
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      mappings = {
        start = 'ga',
      },
    }
  },
  {
    "dhruvasagar/vim-table-mode",
    lazy = true,
    ft = "markdown",
    config = function()
      vim.g.table_mode_corner = '|'
      vim.g.table_mode_disable_mappings = 1
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = '*.md',
        callback = function()
          vim.cmd('silent TableModeEnable')
        end
      })
    end,
  },
}
