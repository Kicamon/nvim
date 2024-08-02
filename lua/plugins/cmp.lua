return {
  'hrsh7th/nvim-cmp',
  commit = '24122371810089d390847d8ba66325c1f1aa64c0',
  lazy = true,
  event = 'LspAttach',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  },
  config = function()
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0
          and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end
    local kind_icons = {
      Text = " 󰉿 ",
      Method = " 󰆧 ",
      Function = " 󰊕 ",
      Constructor = "  ",
      Field = " 󰜢 ",
      Variable = " 󰀫 ",
      Class = " 󰠱 ",
      Interface = "  ",
      Module = "  ",
      Property = " 󰜢 ",
      Unit = " 󰑭 ",
      Value = " 󰎠 ",
      Enum = "  ",
      Keyword = " 󰌋 ",
      Snippet = "  ",
      Color = " 󰏘 ",
      File = " 󰈙 ",
      Reference = " 󰈇 ",
      Folder = " 󰉋 ",
      EnumMember = "  ",
      Constant = " 󰏿 ",
      Struct = " 󰙅 ",
      Event = "  ",
      Operator = " 󰆕 ",
      TypeParameter = " 󰅲 ",
    }
    local luasnip = require('luasnip')
    require('luasnip.loaders.from_vscode').lazy_load({ paths = '~/.config/nvim/snippets' })
    local cmp = require('cmp')
    cmp.setup({
      window = {
        completion = {
          winhighlight = 'Normal:CmpWin,FloatBorder:CmpWin,Search:None',
          col_offset = -3,
          side_padding = 0,
          border = 'rounded',
          scrollbar = true,
        },
        documentation = {
          winhighlight = 'Normal:CmpWin,FloatBorder:CmpWin,Search:None',
          border = 'rounded',
          scrollbar = true,
        },
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(_, vim_item)
          vim_item.menu = ' ' .. (vim_item.kind or '')
          vim_item.kind = kind_icons[vim_item.kind] or ''
          return vim_item
        end,
      },
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
      }),
      mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
      }),
      experimental = {
        ghost_text = true,
      },
    })
  end,
}
