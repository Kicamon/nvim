return {
  {
    'Kicamon/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme gruvbox')
      vim.fn.sign_define('DiagnosticSignError', { text = '🤣', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn', { text = '🧐', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = '🫠', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '🤔', texthl = 'DiagnosticSignHint' })
    end,
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
  {
    'Kicamon/SimpleLine.nvim',
    lazy = true,
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('SimpleLine').setup()
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '▔' },
          changedelete = { text = '┃' },
          untracked    = { text = '┃' },
        },
      }
      vim.keymap.set('n', 'g[', '<cmd>silent lua require"gitsigns".prev_hunk()<CR>', { silent = true })
      vim.keymap.set('n', 'g]', '<cmd>silent lua require"gitsigns".next_hunk()<CR>', { silent = true })
      vim.keymap.set('n', '<leader>H', '<cmd>lua require"gitsigns".preview_hunk_inline()<CR>', { silent = true })
      vim.keymap.set('n', '<leader>gd', '<cmd>lua require"gitsigns".diffthis("~")<CR>', { silent = true })
    end
  },
  {
    'nvimdev/indentmini.nvim',
    lazy = true,
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('indentmini').setup({
        char = "│",
        exclude = {
          'help',
          'dashboard',
          'lazy',
          'notify',
          'toggleterm',
          'lazyterm',
          'markdown',
        }
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = true,
    ft = vim.tbl_deep_extend('keep', {
      'sh',
    }, vim.g.ts_fts),
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = vim.g.ts_fts,
        highlight = {
          enable = true,
          disable = {},
        },
        indent = {
          enable = true
        },
      })
    end
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    lazy = true,
    event = 'BufRead',
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')
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
  {
    "rcarriga/nvim-notify",
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      local notify = require("notify")
      vim.notify = notify
      notify.setup({
        background_colour = "NONE",
        fps = 60,
        level = 2,
        minimum_width = 30,
        render = "compact",
        stages = "slide",
        timeout = 3000,
        top_down = true
      })
    end
  },
  {
    'kevinhwang91/nvim-hlslens',
    lazy = true,
    keys = { '/', '?' },
    config = function()
      require('hlslens').setup({
        override_lens = function(render, posList, nearest, idx, relIdx)
          local sfw = vim.v.searchforward == 1
          local indicator, text, chunks
          local absRelIdx = math.abs(relIdx)
          if absRelIdx > 1 then
            indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '' or '')
          elseif absRelIdx == 1 then
            indicator = sfw ~= (relIdx == 1) and '' or ''
          else
            indicator = ''
          end

          local lnum, col = unpack(posList[idx])
          if nearest then
            local cnt = #posList
            if indicator ~= '' then
              text = ('[%s %d/%d]'):format(indicator, idx, cnt)
            else
              text = ('[%d/%d]'):format(idx, cnt)
            end
            chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
          else
            text = ('[%s %d]'):format(indicator, idx)
            chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
          end
          render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end
      })
    end
  },
  {
    'nvimdev/dashboard-nvim',
    lazy = true,
    event = { 'UIEnter' },
    config = function()
      local db = require('dashboard')
      db.setup({
        theme = 'hyper',
        config = {
          header = {
            "",
            "                  ,~^^```\"~-,,<```.`;smm#####m,",
            "              ,^  ,s###MT7;#M ]Q#` ,a###########M\"`````'``\"~-,",
            "             /   \"^^\\  *W\"3@\"  ||  ~'7#######\"\\                '\".",
            "          :\"          a ,##\\         ]######               e#######M",
            "         L         ,######~        ,#######              ############m",
            "        f         ]######b         #######,           ,,##############b",
            "       ;         .%#####J W####Mm, #####b    ,;,ap ,###################p",
            "       ~ @#Q|^5mg##8#####  %#\"\"Wgs#######T `@#mw,s#@#@########WW@#######",
            "      ,^  ^= .MT\\ j###C            @#@##\"    `we\"|   @#####b` ,m 3######",
            "     ;    ,      #####      p   ,###,#\"    .      ,######## ###m  ######",
            "     ,%\"\"Y\"   ,]#\",##\\    `|p  @##,###M\"1^3`   ;##########Q]##`  @######",
            "    [     7W  ##,#### @m,   ^1 #######m#mw,@m  \\@########C^|`.;s#######`",
            "     y@Mw,   \"#######C  ^\"     |5###### mm ^\"~ ,#########  ;##########`",
            "    ^   ,aQ   ^@#####       N   ^j###7  `     ,######################",
            "   D   #####mg,######      M##p   ##b     ,##################^,#####",
            "   [   ##############       ##########m,###################, ;#####",
            "    o  ^############       @##########M`^`~\"%############\"  @#####b",
            "      \"m,j#########b      @#######M|          @#######M\"^^",
            "          ,^^\"||^7^\"7\\.   \"#####\"              \\#M7|",
            "                           \"||`",
            "         Karl Marx     Friedrich Engels     Vladimir Lenin",
            "",
          },
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
              icon = ' ',
              desc = 'ACM',
              group = 'Function',
              action = 'silent! lcd ~/Documents/Algorithm | Telescope find_files find_command=rg,--ignore,--hidden,--files',
              key = 'a',
            },
          },
          project = {
            enable = false,
          },
          disable_move = false,
        },
      })
    end
  }
}
