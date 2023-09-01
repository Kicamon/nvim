return {
  {
    'iamcco/markdown-preview.nvim',
    build = "cd app && yarn install",
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_browser = "chromium"
      vim.g.mkdp_theme = 'dark'
    end,
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    config = function()
      vim.g.table_mode_corner = '|'
      vim.keymap.set("n", "\\f", "<cmd>TableModeToggle<CR>", { noremap = true })
    end,
  },
  {
    "mzlogin/vim-markdown-toc",
    ft = { "markdown" },
    config = function()
      vim.keymap.set("n", "toc", ":GenTocGitLab<CR>", { noremap = true, buffer = true })
    end,
  },
  {
    "img-paste-devs/img-paste.vim",
    ft = { "markdown" },
    config = function()
      vim.keymap.set("n", "<leader>p", ":call mdip#MarkdownClipboardImage()<CR>", { noremap = true })
      vim.g.PasteImageFunction = 'g:MarkdownPasteImage'
    end,
  },
  {
    "dkarter/bullets.vim",
    ft = { "markdown" },
    config = function()
      vim.g.bullets_set_mappings = 0
      vim.g.bullets_outline_levels = { 'num' }
      vim.keymap.set("i", "<c-=>", "<Plug>(bullets-demote)")
      vim.keymap.set("i", "<c-->", "<Plug>(bullets-promote)")
    end,
  },
  {
    "serenevoid/kiwi.nvim",
    evnet = "VeryLazy",
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('kiwi').setup({
        {
          name = "personal",
          path = "/home/KicamonIce/Documents/study/Note/wiki"
        }
      })
      local kiwi = require('kiwi')
      vim.keymap.set('n', '<leader>ww', kiwi.open_wiki_index, {})
      vim.keymap.set('n', '<leader>wd', kiwi.open_diary_index, {})
      vim.keymap.set('n', '<leader>wn', kiwi.open_diary_new, {})
      vim.keymap.set('n', '<leader-x>', kiwi.todo.toggle, {})
    end
  },
}
