local config = {}

function config.cmp()
  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end
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
        winhighlight = 'Normal:CmpSeWin,FloatBorder:CmpSeWin,Search:None',
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
end

function config.epo()
  vim.keymap.set('i', '<TAB>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-n>'
    elseif vim.snippet.jumpable(1) then
      return '<cmd>lua vim.snippet.jump(1)<cr>'
    else
      return '<TAB>'
    end
  end, { expr = true })

  vim.keymap.set('i', '<S-TAB>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-p>'
    elseif vim.snippet.jumpable(-1) then
      return '<cmd>lua vim.snippet.jump(-1)<CR>'
    else
      return '<S-TAB>'
    end
  end, { expr = true })

  -- For using enter as completion, may conflict with some autopair plugin
  vim.keymap.set('i', '<cr>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-y>'
    end
    return '<cr>'
  end, { expr = true, noremap = true })

  require('epo').setup({
    kind_format = function(k)
      return _G.kind_icons[k] .. ' ' .. k
    end,
  })
end

return config
