return function()
  require('blink.cmp').setup({
    keymap = {
      ['<tab>'] = {
        'select_next',
        'snippet_forward',
        'fallback',
      },
      ['<s-tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<cr>'] = { 'accept', 'fallback' },
      ['<c-o>'] = {
        function(cmp)
          return cmp.show()
        end,
      },
    },
    appearance = { kind_icons = icons },
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
        auto_show_delay_ms = 0,
        treesitter_highlighting = true,
        window = {
          border = 'rounded',
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:CursorLine,Search:None',
        },
      },
      list = { selection = { preselect = false, auto_insert = true } },
      accept = { auto_brackets = { enabled = true } },
      ghost_text = { enabled = true },
    },
    sources = { default = { 'snippets', 'lsp', 'path', 'buffer' } },
    cmdline = {
      completion = {
        menu = { auto_show = false },
        list = { selection = { preselect = false } },
      },
    },
    signature = { window = { border = 'rounded' } },
  })
end
