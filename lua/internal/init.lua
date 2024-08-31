local au = vim.api.nvim_create_autocmd
local uc = vim.api.nvim_create_user_command
local group = vim.api.nvim_create_augroup('KicamonGroup', {})

-- im_switch
au('InsertLeave', {
  group = group,
  callback = function()
    require('internal.im_switch').change_to_en()
  end,
})
au('InsertEnter', {
  group = group,
  pattern = { '*.md', '*.txt' },
  callback = function()
    if require('internal.im_switch').filetype_checke() then
      require('internal.im_switch').change_to_zh()
    end
  end,
})

-- markdown_table_format
au('InsertLeave', {
  group = group,
  pattern = '*.md',
  callback = function()
    require('internal.markdown_table_format').format_markdown_table()
  end,
})
au('TextChangedI', {
  group = group,
  pattern = '*.md',
  callback = function()
    require('internal.markdown_table_format').format_markdown_table_lines()
  end,
})

au({ 'InsertEnter', 'CmdlineEnter' }, {
  group = group,
  once = true,
  callback = function()
    require('internal.pairs')
  end,
})

au('TermOpen', { group = group, command = 'startinsert' })

au('TextYankPost', {
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end,
})

au('BufRead', {
  callback = function()
    vim.cmd.setlocal('formatoptions-=ro')
    -- last plase
    local pos = vim.fn.getpos('\'"')
    if pos[2] > 0 and pos[2] <= vim.fn.line('$') then
      vim.api.nvim_win_set_cursor(0, { pos[2], pos[3] - 1 })
    end
  end,
})

au('FileType', {
  group = group,
  pattern = 'markdown',
  callback = function()
    require('keymap.markdown').markdown_keymap()
  end,
})

au('BufEnter', {
  group = group,
  once = true,
  callback = function()
    vim.cmd.colorscheme('gruvbox')
    require('keymap')
    -- lines
    require('internal.stl').setup()
    -- chdir
    uc('Chdir', function(args)
      require('internal.chdir').chdir(args.args == 'silent')
    end, { nargs = '?' })
  end,
})
