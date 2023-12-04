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
    "Kicamon/SimpleLine.nvim",
    config = function()
      require("statusline").setup()
      require("tabline").setup()
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { hl = 'GitSignsAdd', text = '┃', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
          change       = { hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
          delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          topdelete    = { hl = 'GitSignsDelete', text = '▔', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          changedelete = { hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
          untracked    = { hl = 'GitSignsAdd', text = '┃', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        },
      }
      vim.keymap.set("n", "<leader>g-", ":Gitsigns prev_hunk<CR>", { silent = true })
      vim.keymap.set("n", "<leader>g=", ":Gitsigns next_hunk<CR>", { silent = true })
      vim.keymap.set("n", "<leader>H", ":Gitsigns preview_hunk_inline<CR>", { noremap = true, silent = true })
    end
  },
  {
    'nvimdev/indentmini.nvim',
    event = 'BufEnter',
    config = function()
      require("indentmini").setup({
        char = "│",
        exclude = {
          "help",
          "dashboard",
          "lazy",
          "mason",
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
    event = { "BufReadPost", "BufNewFile" },
    lazy = false,
    priority = 1000,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "dart",
          "html",
          "go",
          "java",
          "javascript",
          "lua",
          "markdown",
          "markdown_inline",
          "prisma",
          "python",
          "query",
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
        incremental_selection = {
          enable = true,
          keymaps = {
            --init_selection    = "<c-n>",
            --node_incremental  = "<c-n>",
            node_decremental  = "<c-h>",
            scope_incremental = "<c-l>",
          },
        }
      })
    end
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
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
  { 'nvim-tree/nvim-web-devicons' },
}
