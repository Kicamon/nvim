return {
  {
    "xeluxee/competitest.nvim",
    lazy = true,
    ft = { "cpp" },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },

    config = function()
      require('competitest').setup({
        runner_ui = {
          interface = "split",
        },
        split_ui = {
          total_width = 0.35,
          vertical_layout = {
            { 2, { { 2, { { 1, "se" }, { 1, "tc" } } }, { 2, "si" } } },
            { 2, { { 2, "so" }, { 2, "eo" } } },
          },
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
      vim.api.nvim_buf_create_user_command(0, 'CP', function(opt)
        if opt.args == 'true' then
          vim.keymap.set("n", "rr", "<cmd>CompetiTest run<CR>", { buffer = true })
          vim.keymap.set("n", "ra", "<cmd>CompetiTest add_testcase<CR>", { buffer = true })
          vim.keymap.set("n", "re", "<cmd>CompetiTest edit_testcase<CR>", { buffer = true })
          vim.keymap.set("n", "ri", "<cmd>CompetiTest receive testcases<CR>", { buffer = true })
          vim.keymap.set("n", "rd", "<cmd>CompetiTest delete_testcase<CR>", { buffer = true })
          vim.keymap.set("n", "rm", function()
            vim.cmd('silent ! rm -f "./%<" && rm -f "./%<"_(in|out)put*.txt')
            vim.notify(" 󰆴 Clearn")
          end, { buffer = true })
        elseif opt.args == 'false' then
          vim.keymap.del('n', 'rr', { buffer = true })
          vim.keymap.del('n', 'ra', { buffer = true })
          vim.keymap.del('n', 're', { buffer = true })
          vim.keymap.del('n', 'ri', { buffer = true })
          vim.keymap.del('n', 'rd', { buffer = true })
          vim.keymap.del('n', 'rm', { buffer = true })
        end
      end, { nargs = 1 })
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    keys = '<leader>f',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fw', builtin.current_buffer_fuzzy_find, {})
      vim.keymap.set('n', '<leader>fg', builtin.git_status, {})
    end
  },
  {
    "NvChad/nvim-colorizer.lua",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true,           -- #RGB hex codes
        RRGGBB = true,        -- #RRGGBB hex codes
        names = false,        -- "Name" codes like Blue or blue
        RRGGBBAA = true,      -- #RRGGBBAA hex codes
        AARRGGBB = true,      -- 0xAARRGGBB hex codes
        rgb_fn = false,       -- CSS rgb() and rgba() functions
        hsl_fn = false,       -- CSS hsl() and hsla() functions
        css = true,           -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,        -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "virtualtext", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true,
        sass = { enable = false },
        virtualtext = "■",
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    }
  },
  {
    "folke/flash.nvim",
    lazy = true,
    opts = {},
    keys = {
      {
        "<ESC>",
        mode = { "n" },
        function()
          require("flash").jump()
        end,
        desc = "Flash"
      },
    },
  },
  {
    "nvimdev/guard.nvim",
    lazy = true,
    ft = vim.g.fts,
    dependencies = {
      "nvimdev/guard-collection",
    },
    config = function()
      local ft = require("guard.filetype")
      ft("c", "cpp"):fmt("clang-format")
      ft("python"):fmt("black")
      ft("lua"):fmt("lsp")
      require("guard").setup({
        fmt_on_save = false,
        lsp_as_default_formatter = true,
        vim.keymap.set({ "n", "v" }, "<leader>fm", "<cmd>GuardFmt<CR>", {}),
      })
    end
  },
  {
    'iamcco/markdown-preview.nvim',
    lazy = true,
    build = "cd app && yarn install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_browser = vim.g.browser
    end,
  },
  {
    "img-paste-devs/img-paste.vim",
    lazy = true,
    ft = "markdown",
    config = function()
      vim.keymap.set("n", "<leader>P", ":call mdip#MarkdownClipboardImage()<CR>", {})
      vim.g.PasteImageFunction = 'g:MarkdownPasteImage'
    end,
  },
  {
    'gelguy/wilder.nvim',
    lazy = true,
    keys = ':',
    config = function()
      local wilder = require('wilder')
      wilder.setup {
        modes = { ':' },
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
  }
}
