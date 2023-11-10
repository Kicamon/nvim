return {
  {
    "windwp/nvim-autopairs",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-autopairs").setup({})
    end
  },
  {
    "echasnovski/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    key = { 'S', 'cs' },
    opts = {
      mappings = {
        add = "S",
        replace = "cs",
        highlight = "",
      }
    }
  },
  {
    "echasnovski/mini.comment",
    event = { "BufReadPre", "BufNewFile" },
    kay = { "<leader>cc" },
    opts = {
      mappings = {
        comment = "<leader>cc",
        comment_line = "<leader>cc",
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
    'iamcco/markdown-preview.nvim',
    build = "cd app && yarn install",
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_browser = "wyeb"
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
    "serenevoid/kiwi.nvim",
    evnet = "VeryLazy",
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    opts = {
      {
        name = "personal",
        path = "/home/KicamonIce/Documents/study/Note/wiki"
      }
    },
    keys = {
      { "<leader>ww", ":lua require(\"kiwi\").open_wiki_index()<cr>", desc = "Open Wiki index" },
    }
  },
}
