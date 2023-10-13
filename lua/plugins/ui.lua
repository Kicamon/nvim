return {
  {
    'Kicamon/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme gruvbox")
      vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#282828" })
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })
      vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
      vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
      vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })
      vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
      vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
      vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })
      vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
      vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
      vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })
      vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
      vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
      vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
      vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
      vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })
      vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
      vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })
      vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
      vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
      vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })
      vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
      vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
      vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })
      vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
      vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
      vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })

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
      vim.keymap.set("n", "<leader>g-", ":Gitsigns prev_hunk<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>g=", ":Gitsigns next_hunk<CR>", { noremap = true, silent = true })
      --vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { noremap = true, silent = true })
      --vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true })
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
      vim.api.nvim_set_hl(0, "IndentLine", { fg = "#504945" })
    end,
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local db = require('dashboard')
      db.setup({
        theme = 'hyper',
        config = {
          week_header = {
            enable = true,
          },
          project = {
            enable = true,
          },
          disable_move = true,
          shortcut = {
            {
              desc = 'Update',
              icon = ' ',
              group = 'Include',
              action = 'Lazy update',
              key = 'u',
            },
            {
              icon = ' ',
              desc = 'Files',
              group = 'Function',
              action = 'Telescope find_files find_command=rg,--ignore,--hidden,--files',
              key = 'f',
            },
            {
              icon = ' ',
              desc = 'Config',
              group = 'String',
              action = 'e ~/.config/nvim/init.lua',
              key = 'c',
            },
            {
              icon = '󱞁 ',
              desc = 'Note',
              group = 'Constant',
              action = require('kiwi').open_wiki_index,
              key = 'w',
            },
          },
        },
      })
    end
  },
  { "nvim-treesitter/playground" },
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
      local function getnode()
        local node_cursor = require("nvim-treesitter.ts_utils").get_node_at_cursor()
        while node_cursor do
          vim.notify(node_cursor:type())
          node_cursor = node_cursor:parent()
        end
        return true
      end
      vim.keymap.set("n", "<leader>P", getnode, { noremap = true })
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
}
