return {
  {
    'iamcco/markdown-preview.nvim',
    build = "cd app && yarn install",
    ft = { "markdown", "vimwiki" },
    config = function()
      vim.g.mkdp_browser = "chromium"
      vim.g.mkdp_theme = 'dark'
    end,
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown", "vimwiki" },
    config = function()
      vim.g.table_mode_corner = '|'
      vim.keymap.set("n", "\\f", "<cmd>TableModeToggle<CR>", { noremap = true })
    end,
  },
  {
    "mzlogin/vim-markdown-toc",
    ft = { "markdown", "vimwiki" },
    config = function()
      vim.keymap.set("n", "toc", ":GenTocGitLab<CR>", { noremap = true, buffer = true })
    end,
  },
  {
    "img-paste-devs/img-paste.vim",
    ft = { "markdown", "vimwiki", "tex" },
    config = function()
      vim.keymap.set("n", "<leader>p", ":call mdip#MarkdownClipboardImage()<CR>", { noremap = true })
      vim.g.PasteImageFunction = 'g:MarkdownPasteImage'
    end,
  },
  {
    "dkarter/bullets.vim",
    ft = { "markdown", "vimwiki" },
    config = function()
      vim.keymap.set("i", "<c-=>", "<Plug>(bullets-demote)")
      vim.keymap.set("i", "<c-->", "<Plug>(bullets-promote)")
      vim.g.bullets_set_mappings = 0
      vim.g.bullets_outline_levels = { 'num' }
    end,
  },
  {
    "vimwiki/vimwiki",
    lazy = false,
    init = function()
      vim.g.vimwiki_list = {
        {
          path = '~/Documents/study/Note/vimwiki/',
          syntax = 'markdown',
          ext = '.md',
        },
      }
      vim.g.vimwiki_global_ext = 0
    end,
  },
}
