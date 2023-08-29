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
    evnet = "BufEnter",
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
    "tpope/vim-surround",
    evnet = "BufEnter",
    key = { 'S', 'cs' },
  },
  {
    "mg979/vim-visual-multi",
    evnet = "BufEnter",
    key = { '<C-n>' },
  },
  {
    "NvChad/nvim-colorizer.lua",
    evnet = "BufEnter",
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
    evnet = "BufEnter",
    kay = { "<leader>cc" },
    config = function()
      vim.g.NERDCreateDefaultMappings = 0
      vim.keymap.set("n", "<leader>cc", "<Plug>NERDCommenterToggle", { noremap = true, silent = true })
      vim.keymap.set("v", "<leader>cc", "<Plug>NERDCommenterToggle", { noremap = true, silent = true })
    end
  },
  {
    "SmiteshP/nvim-navbuddy",
    ft = { "bash", "c", "cpp", "json", "lua", "python" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim"
    },
    opts = { lsp = { auto_attach = true } },
    vim.keymap.set("n", "\\n", ":Navbuddy<CR>", { noremap = true, silent = true })
  },
  {
    "Kicamon/im-switch.nvim",
    evnet = "BufEnter",
    config = function()
      require("im-switch").setup()
    end
  },
  {
    'kevinhwang91/rnvimr',
    evnet = "BufEnter",
    key = { 'R' },
    config = function()
      vim.keymap.set('n', 'R', '<cmd>RnvimrToggle<CR>', { noremap = true })
    end
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<ESC>",
        mode = { "n", },
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
      --{
      --"r",
      --mode = "o",
      --function()
      --require("flash").remote()
      --end,
      --desc = "Remote Flash"
      --},
      --{
      --"R",
      --mode = { "o", "x" },
      --function()
      --require("flash").treesitter_search()
      --end,
      --desc = "Treesitter Search"
      --},
      --{
      --"<c-s>",
      --mode = { "c" },
      --function()
      --require("flash").toggle()
      --end,
      --desc = "Toggle Flash Search"
      --},
    },
  },
  {
    "xiyaowong/link-visitor.nvim",
    key = { "gl" },
    config = function()
      require("link-visitor").setup({
        open_cmd = nil,
        silent = true,             -- disable all prints, `false` by defaults skip_confirmation
        skip_confirmation = false, -- Skip the confirmation step, default: false
        border = "rounded"         -- none, single, double, rounded, solid, shadow see `:h nvim_open_win()`
      })
      vim.keymap.set("n", "gl", ":VisitLinkUnderCursor<CR>", { silent = true })
    end
  }
}
