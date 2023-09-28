local fts = require("user.lsp_fts")
return {
  {
    "xeluxee/competitest.nvim",
    ft = { "cpp" },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },

    config = function()
      require('competitest').setup()
      vim.keymap.set("n", "rr", "<cmd>CompetiTest run<CR>", { noremap = true })
      vim.keymap.set("n", "ra", "<cmd>CompetiTest add_testcase<CR>", { noremap = true })
      vim.keymap.set("n", "re", "<cmd>CompetiTest edit_testcase<CR>", { noremap = true })
      vim.keymap.set("n", "ri", "<cmd>CompetiTest receive testcases<CR>", { noremap = true })
      vim.keymap.set("n", "rd", "<cmd>CompetiTest delete_testcase<CR>", { noremap = true })
    end
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")
      vim.notify = notify
      notify.setup({
        background_colour = "#202020",
        fps = 60,
        level = 2,
        minimum_width = 50,
        render = "compact",
        stages = "slide",
        timeout = 3000,
        top_down = true
      })
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
      vim.keymap.set('n', '<leader>fw', builtin.current_buffer_fuzzy_find, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fg', builtin.git_status, {})
      --vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
      vim.keymap.set('n', '<leader>fz', builtin.spell_suggest, {})
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup {
        defaults = {
          mappings = {
            i = {
              ["<CR>"] = actions.file_tab
            },
            n = {
              ["l"] = actions.file_tab
            },
          }
        },
      }
    end
  },
  {
    "NvChad/nvim-colorizer.lua",
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
        css = false,          -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
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
    "Kicamon/im-switch.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("im-switch").setup()
    end
  },
  {
    "folke/flash.nvim",
    event = { "BufReadPre", "BufNewFile" },
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
      {
        "S",
        mode = { "n", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter"
      },
    },
  },
  {
    "voldikss/vim-translator",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.keymap.set("n", "<leader>tr", "<Plug>TranslateW", { noremap = true })
      vim.keymap.set("v", "<leader>tr", "<Plug>TranslateWV", { noremap = true })
    end,
  },
  {
    "echasnovski/mini.files",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      mappings = {
        close       = '<ESC>',
        go_in       = 'L',
        go_in_plus  = 'l',
        go_out      = 'H',
        go_out_plus = 'h',
      }
    },
    vim.keymap.set("n", "tt", ":lua MiniFiles.open()<CR>", {}),
  },
  {
    "nvimdev/guard.nvim",
    ft = fts,
    dependencies = {
      "nvimdev/guard-collection",
    },
    config = function()
      local ft = require("guard.filetype")
      ft("c"):fmt("clang-format")
      ft("cpp"):fmt("clang-format")
      ft("lua"):fmt("lsp")
      ft("python"):fmt("black")
      ft("sh"):fmt("lsp")
      require("guard").setup({
        fmt_on_save = false,
        lsp_as_default_formatter = true,
        vim.keymap.set({ "n", "v" }, "<leader>fm", "<cmd>GuardFmt<CR>", { noremap = true }),
      })
    end
  },
}
