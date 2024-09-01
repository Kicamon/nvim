local config = {}

function config.completion()
  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  local luasnip = require('luasnip')
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = vim.fn.stdpath('config') .. '/snippets/',
  })

  local cmp = require('cmp')
  cmp.setup({
    window = {
      completion = {
        winhighlight = 'Normal:CmpWin,FloatBorder:CmpWinBor,Search:None',
        border = 'rounded',
        col_offset = -3,
        side_padding = 0,
        scrollbar = true,
      },
      documentation = {
        winhighlight = 'Normal:CmpWinSec,FloatBorder:CmpWinBor,Search:None',
        border = 'rounded',
        scrollbar = true,
      },
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(_, vim_item)
        vim_item.menu = ' ' .. (vim_item.kind or '')
        vim_item.kind = _G.kind_icons[vim_item.kind] or ''
        return vim_item
      end,
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
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
end

return config
