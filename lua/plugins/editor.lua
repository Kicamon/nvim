return {
  {
    "windwp/nvim-autopairs",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("nvim-autopairs").setup({})
    end
  },
  {
    "gcmt/wildfire.vim",
    event = "VeryLazy",
    --{
    --"sustech-data/wildfire.nvim",
    --event = "VeryLazy",
    --dependencies = { "nvim-treesitter/nvim-treesitter" },
    --config = function()
    --require("wildfire").setup()
    --end,
    --}
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    key = { 'S', 'cs' },
    opts = {
      mappings = {
        add = "S",
        replace = "cs",
      }
    }
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    key = { '<C-n>' },
  },
  {
    "NvChad/nvim-colorizer.lua",
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
    "echasnovski/mini.comment",
    evnet = "VeryLazy",
    kay = { "<leader>cc" },
    opts = {
      mappings = {
        comment = "<leader>cc",
        comment_line = "<leader>cc",
      }
    },
  },
  {
    "Kicamon/im-switch.nvim",
    evnet = "VeryLazy",
    config = function()
      require("im-switch").setup()
    end
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
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
    'echasnovski/mini.align',
    opts = {
      mappings = {
        start = 'ga',
        start_with_preview = 'gA',
      },
    }
  },
  {
    "voldikss/vim-translator",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<leader>tr", "<Plug>TranslateW", { noremap = true })
    end,
  },
  {
    "Kicamon/mini.files",
    opts = {
      mappings = {
        close       = '<ESC>',
        go_in       = 'L',
        go_in_plus  = 'l',
        go_out      = 'H',
        go_out_plus = 'h',
      }
    },
    vim.keymap.set("n", "<leader>tt", ":lua MiniFiles.open()<CR>", {}),
  }
}
