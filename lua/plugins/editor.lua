return {
  {
    "windwp/nvim-autopairs",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-autopairs").setup({})
    end
  },
  {
    "echasnovski/mini.comment",
    event = { "BufReadPre", "BufNewFile" },
    key = { "<leader>cc" },
    opts = {
      mappings = {
        comment_line = "<leader>cc",
        comment_visual = '<leader>cc',
      }
    },
  },
  {
    'echasnovski/mini.align',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      mappings = {
        start = 'ga',
        start_with_preview = 'gA',
      },
    }
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    config = function()
      vim.g.table_mode_corner = '|'
      vim.g.table_mode_disable_mappings = 1
      vim.api.nvim_create_autocmd({'BufRead','BufNewFile'},{
        pattern = '*.md',
        callback = function()
           vim.cmd('TableModeEnable')
        end
      })
    end,
  },
}
