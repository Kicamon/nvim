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
    'akinsho/bufferline.nvim',
    event = 'BufEnter */*',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      options = {
        mode = "tabs",
        indicator = {
          icon = '▍', -- this should be omitted if indicator style is not 'icon'
          -- style = 'icon' | 'underline' | 'none',
          style = "icon",
        },
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_duplicate_prefix = false,
        tab_size = 10,
        enforce_regular_tabs = false,
        padding = 0,
        separator_style = "thick",
      }
    }
  },
  {
    "Kicamon/lualine.nvim",
    event = 'BufEnter */*',
    config = function()
      local lualine = require('lualine')

      -- Color table for highlights
      -- stylua: ignore
      local colors = {
        bg       = '#282828',
        bglight  = '#504945',
        bgdark   = '#3f3d3f',
        fg       = '#bbc2cf',
        yellow   = '#F0E68C',
        cyan     = '#008080',
        darkblue = '#081633',
        green    = '#afd787',
        orange   = '#FF8800',
        violet   = '#a9a1e1',
        magenta  = '#c678dd',
        blue     = '#51afef',
        red      = '#ec5f67',
        pink     = '#FF69B4',
        snow     = '#FFFAFA',
        black    = '#000000',
        none     = '#282828',
      }

      local mode_color = {
        n      = colors.green,
        i      = colors.violet,
        v      = colors.yellow,
        ['']  = colors.yellow,
        V      = colors.yellow,
        c      = colors.magenta,
        no     = colors.red,
        s      = colors.orange,
        S      = colors.orange,
        ['']  = colors.orange,
        ic     = colors.yellow,
        R      = colors.violet,
        Rv     = colors.violet,
        cv     = colors.red,
        ce     = colors.red,
        r      = colors.cyan,
        rm     = colors.cyan,
        ['r?'] = colors.cyan,
        ['!']  = colors.red,
        t      = colors.red,
      }

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand('%:p:h')
          local gitdir = vim.fn.finddir('.git', filepath .. ';')
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      -- Config
      local config = {
        options = {
          -- Disable sections and component separators
          component_separators = '',
          section_separators = '',
          theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
          },
          globalstatus = true,
        },
        sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- These will be filled later
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }

      -- Inserts a component in lualine_c at left section
      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      -- Inserts a component in lualine_x at right section
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      ins_left {
        function()
          return '█'
        end,
        padding = { right = 0 },
        color = function()
          return { fg = mode_color[vim.fn.mode()], bg = colors.bg, gui = 'bold' }
        end,
      }

      ins_left {
        'mode',
        color = function()
          return { fg = colors.bg, bg = mode_color[vim.fn.mode()], gui = 'bold' }
        end,
        padding = { left = 0, right = 0 }
      }

      ins_left {
        function()
          return ''
        end,
        color = function()
          return { fg = mode_color[vim.fn.mode()], bg = colors.bgdark, gui = 'bold' }
        end,
        padding = { left = 0, right = 0 }
      }

      ins_left {
        'filename',
        color = { bg = colors.bgdark, fg = colors.blue, gui = 'bold' },
      }

      ins_left {
        function()
          return ''
        end,
        color = { fg = colors.bgdark, bg = colors.bg },
        padding = { left = 0 },
      }

      ins_left {
        'branch',
        icon = '',
        color = { fg = colors.violet, bg = colors.bg, gui = 'bold' },
      }


      ins_left {
        'diff',
        -- Is it me or the symbol for modified us really weird
        symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        color = { bg = colors.bg },
        cond = conditions.hide_in_width,
      }

      -- Add components to right sections

      ins_right {
        'diagnostics',
        sources           = { 'nvim_diagnostic', 'coc' },
        sections          = { 'error', 'warn', 'info', 'hint' },
        symbols           = { error = '🤣', warn = '🧐', info = '🫠', hint = '🤔' },
        diagnostics_color = {
          error = { fg = colors.red },
          warn  = { fg = colors.yellow },
          info  = { fg = colors.cyan },
          hint  = { fg = colors.blue },
        },
      }

      ins_right {
        function()
          return ''
        end,
        color = { fg = colors.bgdark, gui = 'bold' },
        padding = { right = 0 },
      }

      ins_right {
        'filetype',
        cond = conditions.buffer_not_empty,
        color = { fg = colors.magenta, bg = colors.bgdark, gui = 'bold' },
      }

      ins_right {
        'fileformat',
        fmt = string.upper,
        icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
        color = { fg = colors.green,bg = colors.bgdark, gui = 'bold' },
      }

      ins_right {
        function()
          return ''
        end,
        padding = { left = 0, right = 0 },
        color = { bg = colors.bgdark, fg = colors.green, gui = 'bold' },
      }

      ins_right {
        'progress',
        icon = { '', align = 'right' },
        color = { fg = colors.bg, bg = colors.green, gui = 'bold' },
      }

      ins_right {
        'location',
        padding = { left = 0, right = 0 },
        color = { fg = colors.bg, bg = colors.green, gui = 'bold' },
      }

      -- Now don't forget to initialize lualine
      lualine.setup(config)
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { hl = 'GitSignsAdd', text = '▍', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
          change       = { hl = 'GitSignsChange', text = '▍', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
          delete       = { hl = 'GitSignsDelete', text = '▶', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          topdelete    = { hl = 'GitSignsDelete', text = '▶', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          changedelete = { hl = 'GitSignsChange', text = '▍', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
          untracked    = { hl = 'GitSignsAdd', text = '▍', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
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
              icon = ' ',
              desc = 'Apps',
              group = 'String',
              action = 'Telescope app',
              key = 'a',
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
