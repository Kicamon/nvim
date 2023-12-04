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
    end,
  },
  {
    "mzlogin/vim-markdown-toc",
    ft = { "markdown" },
    config = function()
      vim.api.nvim_create_user_command('toc', 'GenTocGitLab', {})
    end,
  },
}
