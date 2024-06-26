return {
  {
    'xeluxee/competitest.nvim',
    lazy = true,
    cmd = 'CompetiTest',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('competitest').setup({
        runner_ui = {
          interface = 'split',
        },
        compile_command = {
          cpp       = { exec = 'g++', args = { '$(FNAME)', '-std=c++17', '-O2', '-g', '-Wall', '-o', '$(FNOEXT)' } },
          some_lang = { exec = 'some_compiler', args = { '$(FNAME)' } },
        },
        run_command = {
          cpp       = { exec = './$(FNOEXT)' },
          some_lang = { exec = 'some_interpreter', args = { '$(FNAME)' } },
        },
      })
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
    },
    config = function()
      require('telescope').setup({
        defaults = {
          prompt_prefix = ' ',
          selection_caret = ' ',
          layout_config = {
            horizontal = { prompt_position = 'top', results_width = 0.6 },
            vertical = { mirror = false },
          },
          sorting_strategy = 'ascending',
          file_previewer = require('telescope.previewers').vim_buffer_cat.new,
          grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
          qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        },
        extensions = {
          fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
          },
        },
      })
      require('telescope').load_extension('fzy_native')
    end
  },
  {
    'NvChad/nvim-colorizer.lua',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      filetypes = { '*' },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = false,
        hsl_fn = false,
        css = true,
        css_fn = true,
        mode = 'virtualtext',
        tailwind = true,
        sass = { enable = false },
        virtualtext = '■',
      },
      buftypes = {},
    }
  },
  {
    'folke/flash.nvim',
    lazy = true,
    keys = {
      {
        's',
        mode = 'n',
        function()
          require('flash').jump()
        end,
        desc = 'Flash'
      },
    },
  },
  {
    'Kicamon/tool.nvim',
    config = function()
      require('tool')
    end
  },
  {
    'gelguy/wilder.nvim',
    build = ':silent! UpdateRemotePlugins',
    event = 'CmdlineEnter',
    config = function()
      local wilder = require('wilder')
      wilder.setup {
        modes = { ':', '/', '?' },
        next_key = '<Tab>',
        previous_key = '<S-Tab>',
      }
      wilder.set_option('renderer', wilder.popupmenu_renderer(
        wilder.popupmenu_palette_theme({
          highlights = {
            border = 'Normal',
          },
          left = { ' ', wilder.popupmenu_devicons() },
          right = { ' ', wilder.popupmenu_scrollbar() },
          border = 'rounded',
          max_height = '75%',
          min_height = 0,
          prompt_position = 'top',
          reverse = 0,
        })
      ))
      wilder.set_option('pipeline', {
        wilder.branch(
          wilder.cmdline_pipeline({
            language = 'vim',
            fuzzy = 1,
          }), wilder.search_pipeline()
        ),
      })
    end
  },
  {
    "voldikss/vim-translator",
    lazy = true,
    cmd = "TranslateW",
  },
  {
    'aserowy/tmux.nvim',
    lazy = true,
    keys = { '<C-h>', '<C-j>', '<C-k>', '<C-l>', '<A-h>', '<A-j>', '<A-k>', '<A-l>' },
    config = function()
      require('tmux').setup()
    end
  },
  {
    'windwp/nvim-autopairs',
    lazy = true,
    event = 'InsertEnter',
    opts = {}
  },
  {
    'nvimdev/guard.nvim',
    lazy = true,
    cmd = "GuardFmt",
    dependencies = {
      'nvimdev/guard-collection',
    },
    config = function()
      local ft = require('guard.filetype')
      ft('c'):fmt('clang-format');
      ft('cpp'):fmt('clang-format')
      ft('python'):fmt('black')
      ft('lua'):fmt('lsp')
      require('guard').setup({
        fmt_on_save = false,
        lsp_as_default_formatter = true,
      })
    end
  },
  {
    'windwp/nvim-ts-autotag',
    lazy = true,
    ft = 'html',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
  {
    'nvimdev/flybuf.nvim',
    lazy = true,
    cmd = 'FlyBuf',
    config = function()
      require('flybuf').setup({
        hotkey = 'asxfghwertyuiopzcvbnm', -- hotkye
        border = 'rounded',               -- border
        quit = 'q',                       -- quit flybuf window
        mark = 'l',                       -- mark as delet or cancel delete
        delete = 'd',                     -- delete marked buffers or buffers which cursor in
      })
    end
  },
}
