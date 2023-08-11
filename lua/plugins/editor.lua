return {
  {
    "windwp/nvim-autopairs",
    lazy = true,
    event = { "InsertEnter" },
    config = function()
      require("nvim-autopairs").setup({})
    end
  },
  {
    "gcmt/wildfire.vim",
  },
  {
    "tpope/vim-surround",
  },
  {
    "mg979/vim-visual-multi",
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
    "preservim/nerdcommenter",
    config = function()
      vim.g.NERDCreateDefaultMappings = 0
      vim.keymap.set("n", "<leader>cc", "<Plug>NERDCommenterToggle", { noremap = true, silent = true })
      vim.keymap.set("v", "<leader>cc", "<Plug>NERDCommenterToggle", { noremap = true, silent = true })
    end
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim"
    },
    opts = { lsp = { auto_attach = true } },
    vim.keymap.set("n", "\\n", ":Navbuddy<CR>", { noremap = true, silent = true })
  },
  {
    "Kicamon/im-switch.nvim",
    config = function()
      require("im-switch").setup()
    end
  },
  {
    "xeluxee/competitest.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    ft = { "cpp" },
    config = function()
      require('competitest').setup()
      vim.keymap.set("n", "rr", ":CompetiTest run<CR>", { noremap = true })
      vim.keymap.set("n", "ra", ":CompetiTest add_testcase<CR>", { noremap = true })
      vim.keymap.set("n", "re", ":CompetiTest edit_testcase<CR>", { noremap = true })
      vim.keymap.set("n", "ri", ":CompetiTest receive testcases<CR>", { noremap = true })
      vim.keymap.set("n", "rd", ":CompetiTest delete_testcase<CR>", { noremap = true })
      vim.keymap.set("n", "<leader>acm", ":CompetiTest receive contest<CR>", { noremap = true })
    end
  },
  {
    'junegunn/goyo.vim',
    key = { '<leader>gy' },
    config = function()
      vim.keymap.set('n', '<leader>gy', ':Goyo<CR>', { noremap = true })
    end
  },
  {
    'kevinhwang91/rnvimr',
    config = function()
      vim.keymap.set('n', 'R', ':RnvimrToggle<CR>', { noremap = true })
    end
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    kays = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
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
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash"
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search"
      },
    },
  },
}
