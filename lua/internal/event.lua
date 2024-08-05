local au = vim.api.nvim_create_autocmd
local uc = vim.api.nvim_create_user_command
local map = require('core.keymap')

local function ele_in_table(ele, tab)
  for _, v in ipairs(tab) do
    if v == ele then
      return true
    end
  end
  return false
end

--- CodeRunning
au({ 'FileType' }, {
  pattern = { 'c', 'cpp', 'python', 'lua', 'markdown', 'sh', 'html' },
  callback = function()
    map.n({
      ['<F5>'] = function()
        require('internal.CodeRunning').running(false)
      end,
      ['<F10>'] = function()
        require('internal.CodeRunning').running(true)
      end,
    }, { silent = true })
  end
})

--- cursorword
au('FileType', {
  pattern = vim.g.fts,
  callback = function()
    local group_id = vim.api.nvim_create_augroup('CursorWord', { clear = true })
    vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
      group = group_id,
      callback = require('internal.CursorWord').matchadd,
    })
    vim.api.nvim_create_autocmd({ 'BufLeave', 'WinLeave', 'InsertEnter' }, {
      group = group_id,
      callback = function()
        require('internal.CursorWord').matchdelete(true)
      end
    })
  end
})

--- ImSwitch
au('InsertLeave', {
  callback = function()
    require('internal.ImSwitch').En()
  end
})
au('InsertEnter', {
  callback = function()
    local buf_info = vim.fn.expand('%:e')
    if ele_in_table(buf_info, { 'md', 'txt' }) then
      if require('internal.ImSwitch').filetype_checke() then
        require('internal.ImSwitch').Zh()
      end
    end
  end
})

--- MdTableFormat
au('InsertLeave', {
  pattern = "*.md",
  callback = function()
    require('internal.MdTableFormat').format_markdown_table()
  end
})
au('TextChangedI', {
  pattern = "*.md",
  callback = function()
    require('internal.MdTableFormat').format_markdown_table_lines()
  end
})

--- Pairs
au({ 'InsertEnter', 'CmdlineEnter' }, {
  callback = function()
    require('internal.Pair')
  end
})

au('TermOpen', { pattern = 'term://*', command = [[startinsert]] })

au('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end
})

au({ 'BufRead', 'BufNewFile' }, {
  callback = function()
    vim.cmd('set formatoptions-=ro')
    --- last plase
    local pos = vim.fn.getpos("'\"")
    if pos[2] > 0 and pos[2] <= vim.fn.line('$') then
      vim.api.nvim_win_set_cursor(0, { pos[2], pos[3] - 1 })
    end
    --- lines
    require('internal.lines').setup()
    --- Chdir
    uc('Chdir', function()
      require('internal.Chdir').Chdir()
    end, { nargs = 0 })
  end
})

au('BufEnter', {
  once = true,
  callback = function()
    require('keymap')
    uc('Yazi', function() require('internal.Yazi').Yazi('edit') end, { nargs = 0 })
  end
})

au({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.md',
  callback = function()
    require('keymap.markdown')
  end
})
