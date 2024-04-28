return {
  {
    'xeluxee/competitest.nvim',
    lazy = true,
    cmd = 'CP',
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
      vim.api.nvim_buf_create_user_command(0, 'CP', function()
        vim.g.cp = not vim.g.cp
        vim.notify('Competitest ' .. (vim.g.cp and 'Enable' or 'Disable'))
        if vim.g.cp then
          vim.keymap.set('n', ';rr', '<cmd>CompetiTest run<CR>', {})
          vim.keymap.set('n', ';ra', '<cmd>CompetiTest add_testcase<CR>', {})
          vim.keymap.set('n', ';re', '<cmd>CompetiTest edit_testcase<CR>', {})
          vim.keymap.set('n', ';ri', '<cmd>CompetiTest receive testcases<CR>', {})
          vim.keymap.set('n', ';rd', '<cmd>CompetiTest delete_testcase<CR>', {})
          vim.keymap.set('n', ';rm', function()
            vim.cmd('silent ! rm -f "./%<" && rm -f "./%<"_(in|out)put*.txt')
            vim.notify(' 󰆴 Clearn')
          end, {})
        else
          vim.keymap.del('n', ';rr', {})
          vim.keymap.del('n', ';ra', {})
          vim.keymap.del('n', ';re', {})
          vim.keymap.del('n', ';ri', {})
          vim.keymap.del('n', ';rd', {})
          vim.keymap.del('n', ';rm', {})
        end
      end, { nargs = 0 })
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    keys = '<leader>f',
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
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>', {})
      vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fy', builtin.registers, {})
    end
  },
  {
    'NvChad/nvim-colorizer.lua',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      filetypes = { '*' },
      user_default_options = {
        RGB = true,           -- #RGB hex codes
        RRGGBB = true,        -- #RRGGBB hex codes
        names = true,         -- 'Name' codes like Blue or blue
        RRGGBBAA = true,      -- #RRGGBBAA hex codes
        AARRGGBB = true,      -- 0xAARRGGBB hex codes
        rgb_fn = false,       -- CSS rgb() and rgba() functions
        hsl_fn = false,       -- CSS hsl() and hsla() functions
        css = true,           -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,        -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = 'virtualtext', -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true,
        sass = { enable = false },
        virtualtext = '■',
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    }
  },
  {
    'folke/flash.nvim',
    lazy = true,
    opts = {},
    keys = {
      {
        '<A-j>',
        mode = 'n',
        function()
          require('flash').jump()
        end,
        desc = 'Flash'
      },
    },
  },
  {
    'iamcco/markdown-preview.nvim',
    lazy = true,
    build = 'cd app && yarn install',
    ft = 'markdown',
    config = function()
      vim.g.mkdp_browser = vim.g.browser
      vim.g.mkdp_auto_close = 1
    end,
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
            border = 'Normal', -- highlight to use for the border
          },
          left = { ' ', wilder.popupmenu_devicons() },
          right = { ' ', wilder.popupmenu_scrollbar() },
          border = 'rounded',
          max_height = '75%',      -- max height of the palette
          min_height = 0,          -- set to the same as 'max_height' for a fixed height window
          prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
          reverse = 0,             -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
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
    'aserowy/tmux.nvim',
    config = function()
      require('tmux').setup()
    end
  },
}
