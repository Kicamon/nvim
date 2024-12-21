local config = {}

function config.blink()
  local function has_words_before()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  require('blink.cmp').setup({
    keymap = {
      ['<Tab>'] = {
        function(cmp)
          if has_words_before() then
            return cmp.show()
          end
        end,
        'select_next',
        'snippet_forward',
        'fallback',
      },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },
    snippets = {
      expand = function(snippet)
        require('luasnip').lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require('luasnip').jumpable(filter.direction)
        end
        return require('luasnip').in_snippet()
      end,
      jump = function(direction)
        require('luasnip').jump(direction)
      end,
    },
    appearance = { kind_icons = _G.kind_icons },
    completion = {
      menu = {
        border = 'rounded',
        winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:CursorLine,Search:None',
        draw = {
          columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' } },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100,
        treesitter_highlighting = true,
        window = {
          border = 'rounded',
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:CursorLine,Search:None',
        },
      },
      list = { selection = 'manual' },
      accept = { auto_brackets = { enabled = true } },
      ghost_text = { enabled = true },
    },
    sources = { default = { 'snippets', 'lsp', 'path', 'buffer' } },
    signature = { window = { border = 'rounded' } },
  })
end

return config
