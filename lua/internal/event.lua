local au = vim.api.nvim_create_autocmd
local uc = vim.api.nvim_create_user_command
local group = vim.api.nvim_create_augroup('KicamonGroup', {})

--- cursorword
au({ 'CursorMoved' }, {
  group = group,
  callback = require('internal.CursorWord').matchadd,
})
au({ 'BufLeave', 'WinLeave', 'InsertEnter' }, {
  group = group,
  callback = function()
    require('internal.CursorWord').matchdelete(true)
  end,
})

--- ImSwitch
au('InsertLeave', {
  group = group,
  callback = function()
    require('internal.ImSwitch').change_to_en()
  end,
})
au('InsertEnter', {
  group = group,
  pattern = { '*.md', '*.txt' },
  callback = function()
    if require('internal.ImSwitch').filetype_checke() then
      require('internal.ImSwitch').change_to_zh()
    end
  end,
})

--- MdTableFormat
au('InsertLeave', {
  group = group,
  pattern = '*.md',
  callback = function()
    require('internal.MdTableFormat').format_markdown_table()
  end,
})
au('TextChangedI', {
  group = group,
  pattern = '*.md',
  callback = function()
    require('internal.MdTableFormat').format_markdown_table_lines()
  end,
})

--- Pairs
au({ 'InsertEnter', 'CmdlineEnter' }, {
  group = group,
  once = true,
  callback = function()
    require('internal.Pair')
  end,
})

au('TermOpen', { group = group, pattern = 'term://*', command = 'startinsert' })

au('TextYankPost', {
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end,
})

au({ 'BufRead', 'BufNewFile' }, {
  callback = function()
    vim.cmd('setlocal formatoptions-=ro')
    --- last plase
    local pos = vim.fn.getpos('\'"')
    if pos[2] > 0 and pos[2] <= vim.fn.line('$') then
      vim.api.nvim_win_set_cursor(0, { pos[2], pos[3] - 1 })
    end
  end,
})

au({ 'FileType' }, {
  group = group,
  pattern = 'markdown',
  callback = function()
    require('keymap.markdown')
  end,
})

au('BufEnter', {
  group = group,
  once = true,
  callback = function()
    vim.cmd.colorscheme('gruvbox')
    require('keymap')
    uc('Yazi', function()
      require('internal.Yazi').yazi('edit')
    end, { nargs = 0 })
    --- lines
    require('internal.lines').setup()
    --- Chdir
    uc('Chdir', function()
      require('internal.Chdir').chdir()
    end, { nargs = 0 })
  end,
})
