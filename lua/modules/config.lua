local config = {}

config.lspsaga = function()
  require('lspsaga').setup({
    ui = {
      devicon = false,
    },
    lightbulb = {
      enable = false,
    },
    finder = {
      keys = {
        edit = '<C-o>',
        toggle_or_open = '<cr>',
      },
    },
    definition = {
      keys = {
        edit = '<C-o>',
        vsplit = '<C-v>',
      },
    },
  })
end

config.blink = function()
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

config.treesitter = function()
  require('nvim-treesitter').setup({
    install_dir = vim.fn.stdpath('data') .. '/site',
  })
  require('nvim-treesitter').install({
    'bash',
    'c',
    'cpp',
    'go',
    'html',
    'javascript',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'typescript',
    'vim',
    'json',
    'vimdoc',
  })
end

config.guard = function()
  local ft = require('guard.filetype')
  ft('c,cpp'):fmt({
    cmd = 'clang-format',
    stdin = true,
    ignore_patterns = { 'neovim', 'vim' },
  })
  ft('python'):fmt({
    cmd = 'black',
    args = { '--quiet', '-' },
    stdin = true,
  })
  ft('lua'):fmt({
    cmd = 'stylua',
    args = { '-' },
    stdin = true,
    find = 'stylua.toml',
  })
  ft('sh'):fmt({
    cmd = 'shfmt',
    args = { '-' },
    stdin = true,
  })
  ft('go', 'html', 'css', 'javascript', 'json'):fmt('lsp')

  vim.g.guard_config = {
    fmt_on_save = false,
    lsp_as_default_formatter = true,
  }
end

config.gitsigens = function()
  require('gitsigns').setup({
    signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┃' },
    },
  })
end

config.indentmini = function()
  vim.opt.listchars:append({ tab = '  ' })
  require('indentmini').setup({
    char = '│',
    exclude = {
      'help',
      'dashboard',
      'lazy',
      'markdown',
      'text',
    },
  })
end

return config
