local au = vim.api.nvim_create_autocmd
local uc = vim.api.nvim_create_user_command
local group = vim.api.nvim_create_augroup('KicamonIceGroup', {})

------------ auto commands ------------

-- initialization
au('UIEnter', {
  group = group,
  once = true,
  callback = function()
    -- colorscheme
    vim.cmd.colorscheme('gruvbox')

    -- status ui
    require('internal.status')

    -- lsp
    require('internal.lsp')

    -- keymap
    require('keymap')

    -- cursor word
    require('internal.cursor_word')
  end,
})

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

-- auto pairs
au({ 'InsertEnter', 'CmdlineEnter' }, {
  group = group,
  once = true,
  callback = function()
    require('internal.pairs')
  end,
})

-- hlsearch
au('CursorMoved', {
  group = group,
  callback = function()
    require('internal.hlsearch').start_hl()
  end,
})
au('InsertEnter', {
  group = group,
  callback = function()
    require('internal.hlsearch').stop_hl()
  end,
})

au('TermOpen', { group = group, command = 'startinsert' })

au('TextYankPost', {
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
    if vim.v.event.regname == '+' then
      vim.system({ 'xclip' }, { stdin = vim.fn.getreg('+') })
    end
  end,
})

au('BufRead', {
  group = group,
  callback = function()
    vim.cmd.setlocal('formatoptions-=ro')
    -- last plase
    local pos = vim.fn.getpos('\'"')
    if pos[2] > 0 and pos[2] <= vim.fn.line('$') then
      vim.api.nvim_win_set_cursor(0, { pos[2], pos[3] - 1 })
    end
  end,
})

au('BufLeave', {
  group = group,
  callback = function()
    if vim.bo.modified then
      vim.cmd('silent! write')
    end
  end,
})

------------ user commands ------------

-- code_running
uc('Run', function(args)
  require('internal.code_running').running(args.args)
end, {
  nargs = '?',
  complete = function(arg)
    local list = vim.tbl_extend(
      'force',
      require('internal.code_running_commands').commands_list(),
      { 'center' }
    )
    return vim.tbl_filter(function(s)
      return string.match(s, '^' .. arg)
    end, list)
  end,
})

-- change directory
uc('Chdir', function(args)
  vim.cmd('silent! lcd %:p:h')
  if args.args == 'silent' then
    return
  end
  vim.notify('From: ' .. vim.fn.getcwd() .. '\n' .. 'To: ' .. vim.fn.expand('%:p:h'))
end, { nargs = '?' })

-- get node
uc('GetNode', function(args)
  require('internal.get_node').operate(args.args)
end, {
  nargs = '?',
  complete = function()
    return { 'cap' }
  end,
})

-- open
uc('Google', function(args)
  local keyword = vim.fn.expand('<cword>')
  if args.args ~= '' then
    keyword = args.args
  end
  vim.ui.open(('https://google.com/search?q=%s'):format(keyword))
end, { nargs = '*' })
