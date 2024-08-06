return {
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
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
    'nvimdev/guard.nvim',
    lazy = true,
    cmd = "GuardFmt",
    dependencies = {
      'nvimdev/guard-collection',
    },
    config = function()
      local ft = require('guard.filetype')
      ft('c,cpp'):fmt('clang-format');
      ft('python'):fmt('black')
      ft('lua'):fmt('lsp')
      require('guard').setup({
        fmt_on_save = false,
        lsp_as_default_formatter = true,
      })
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
