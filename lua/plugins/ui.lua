return {
  {
    'Kicamon/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme gruvbox")
      vim.fn.sign_define("DiagnosticSignError", { text = "🤣", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = "🧐", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = "🫠", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "🤔", texthl = "DiagnosticSignHint" })
    end,
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
  {
    "Kicamon/SimpleLine.nvim",
    lazy = true,
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require("SimpleLine").setup()
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '▔' },
          changedelete = { text = '┃' },
          untracked    = { text = '┃' },
        },
      }
      vim.keymap.set("n", "g[", '<cmd>silent lua require"gitsigns".prev_hunk()<CR>', { silent = true })
      vim.keymap.set("n", "g]", '<cmd>silent lua require"gitsigns".next_hunk()<CR>', { silent = true })
      vim.keymap.set("n", "<leader>H", '<cmd>lua require"gitsigns".preview_hunk_inline()<CR>', { silent = true })
      vim.keymap.set("n", "<leader>gd", '<cmd>lua require"gitsigns".diffthis("~")<CR>', { silent = true })
    end
  },
  {
    'nvimdev/indentmini.nvim',
    lazy = true,
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require("indentmini").setup({
        char = "│",
        exclude = {
          "help",
          "dashboard",
          "lazy",
          "notify",
          "toggleterm",
          "lazyterm",
          "markdown",
        }
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = { "BufRead", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "html",
          "javascript",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "typescript",
          "vim"
        },
        highlight = {
          enable = true,
          disable = {}, -- list of language that will be disabled
        },
        indent = {
          enable = false
        },
      })
    end
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = true,
    event = 'BufRead',
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterBlue',
          'RainbowDelimiterYellow',
          'RainbowDelimiterCyan',
          'RainbowDelimiterViolet',
          'RainbowDelimiterRed',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
        },
      }
    end
  },
}
