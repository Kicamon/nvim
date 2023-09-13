return {
  {
    'mg979/tabline.nvim',
    event = 'VeryLazy',
    config = function()
      require("tabline.setup").setup({
        tabs_badge       = false,
        modes            = { "tabs", "buffers" },
        theme            = "slate",
        default_mappings = false,
        label_style      = "order",
      })
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    event = 'VeryLazy',
    config = function()
      -- Eviline config for lualine
      -- Author: shadmansaleh
      -- Credit: glepnir
      local lualine = require('lualine')

      -- Color table for highlights
      -- stylua: ignore
      local colors = {
        bg       = '#3c3836',
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
        n       = colors.green,
        i       = colors.violet,
        v       = colors.yellow,
        ['']  = colors.yellow,
        V       = colors.yellow,
        c       = colors.magenta,
        no      = colors.red,
        s       = colors.orange,
        S       = colors.orange,
        ['']  = colors.orange,
        ic      = colors.yellow,
        R       = colors.violet,
        Rv      = colors.violet,
        cv      = colors.red,
        ce      = colors.red,
        r       = colors.cyan,
        rm      = colors.cyan,
        ['r?']  = colors.cyan,
        ['!']   = colors.red,
        t       = colors.red,
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
          return ''
        end,
        padding = { right = 0 },
        color = function()
          return { fg = mode_color[vim.fn.mode()], bg = colors.none, gui = 'bold' }
        end,
      }

      ins_left {
        'mode',
        icon = '󰕷',
        color = function()
          return { fg = colors.bg, bg = mode_color[vim.fn.mode()], gui = 'bold' }
        end,
      }

      ins_left {
        function()
          return ''
        end,
        color = function()
          return { fg = mode_color[vim.fn.mode()], bg = colors.bgdark, gui = 'bold' }
        end,
        padding = { left = 0, right = 0 }
      }

      ins_left {
        function()
          local mode2 = ""
          if (vim.wo.spell) then
            mode2 = mode2 .. "󰓆 "
          end
          if (vim.wo.wrap) then
            mode2 = mode2 .. "󰖶 "
          end
          return mode2
        end,
        cond = conditions.buffer_not_empty,
        color = { fg = colors.yellow, bg = colors.bgdark, gui = 'bold' },
        padding = { left = 1, right = 0 },
      }

      ins_left {
        'branch',
        icon = '',
        color = { fg = colors.violet, bg = colors.bgdark, gui = 'bold' },
      }

      ins_left {
        function()
          return ''
        end,
        color = { fg = colors.bgdark, bg = colors.bglight },
        padding = { left = 0 },
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
        cond = conditions.hide_in_width,
        color = { bg = colors.bglight },
      }

      ins_left {
        function()
          return ''
        end,
        color = { fg = colors.bglight },
        padding = { left = 0 },
      }

      ins_left {
        function()
          return '%='
        end,
      }

      ins_left {
        -- Lsp server name .
        function()
          local msg = 'No Active Lsp'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = ' LSP:',
        color = { fg = colors.violet, gui = 'bold' },
      }

      ins_right {
        'filetype',
        cond = conditions.buffer_not_empty,
        color = { fg = colors.magenta, gui = 'bold' },
      }

      -- Add components to right sections
      ins_right {
        'o:encoding',       -- option component same as &encoding in viml
        fmt = string.upper, -- I'm not sure why it's upper case either ;)
        cond = conditions.hide_in_width,
        color = { fg = colors.green, gui = 'bold' },
      }

      ins_right {
        'fileformat',
        fmt = string.upper,
        icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
        color = { fg = colors.green, gui = 'bold' },
      }

      ins_right {
        function()
          return ''
        end,
        color = { fg = colors.bgdark, gui = 'bold' },
        padding = { right = 0 },
      }

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
        color             = { bg = colors.bgdark },
      }

      ins_right {
        function()
          return ''
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

      ins_right {
        function()
          return ''
        end,
        color = { bg = colors.none, fg = colors.green },
        padding = { left = 0 },
      }

      -- Now don't forget to initialize lualine
      lualine.setup(config)
    end
  },
  {
    'petertriho/nvim-scrollbar',
    dependencies = {
      'kevinhwang91/nvim-hlslens',
      lazy = true,
    },
    config = function()
      require("scrollbar.handlers.search").setup()
      require("scrollbar").setup({
        show = true,
        handle = {
          text = " ",
          color = "#696969",
          hide_if_all_visible = true,
        },
        marks = {
          Search = { color = "yellow" },
          Misc = { color = "purple" },
        },
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = true,
          handle = true,
          search = true,
        },
      })
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
    "nvim-zh/colorful-winsep.nvim",
    lazy = true,
    config = true,
    event = { "WinNew" },
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
  }
}
